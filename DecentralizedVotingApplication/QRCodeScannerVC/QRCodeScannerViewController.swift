//
//  QRCodeScannerViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 6/16/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import AVFoundation
import web3swift
import BigInt
import CryptoSwift
class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    
    @IBOutlet weak var videoPreview:UIView!
    let avCaptureSession = AVCaptureSession()
//    var studentID: String?
    enum error: Error {
        case  noCameraAvailable
        case videoInputInitFail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try scanQRCode()
        }
        catch{
            print("Failed")
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        if(metadataObjects.count > 0) {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                avCaptureSession.stopRunning()
                studentID = Int(machineReadableCode.stringValue!)
                register(addressStudent: addressforStudent, studentID: studentID!)
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
    
    
    func scanQRCode() throws {
        
        
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("Failed to init camera")
            throw error.noCameraAvailable
        }
        
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to init camera")
            throw error.videoInputInitFail
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        
        avCaptureSession.startRunning()
        
    }
    
    func register(addressStudent: String, studentID: Int){
        let privateKeyData = Data.fromHex(privateKey)
        var option = Web3Options.defaultOptions()
        option.from = EthereumAddress(myAdd)
        option.gasLimit = gasLimit
        option.gasPrice = gasPrice
        option.value = BigUInt(0)
        let contract = web3.contract(contractSystemABI, at: EthereumAddress(contractAddress))
        let testParameters = [EthereumAddress(addressStudent), studentID] as [AnyObject]
        
        let intermediate = contract?.method("Register", parameters: testParameters, options: option)
        guard let nonce = web3.eth.getTransactionCount(address: option.from!).value else { return }
        try! intermediate?.setNonce(nonce)
        
        guard var transaction = intermediate?.transaction else {
            return
        }
        //        print("---")
        try! Web3Signer.EIP155Signer.sign(transaction: &transaction, privateKey: privateKeyData!)
        intermediate?.transaction = transaction
        intermediate?.sendSigned()
        print("---")
      //  self.txid = intermediate?.transaction.txid
        //        print(intermediate?.transaction.txid)
    }
   
}

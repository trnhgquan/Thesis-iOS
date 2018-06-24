//
//  QRLoginViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 6/20/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//


//
//  QRCodeScannerViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 6/16/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import AVFoundation

class QRLoginViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    
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
                print(machineReadableCode)
                //
                isTeacher = true
                let homeViewController = HomeViewController(user: "Home")
                self.navigationController?.pushViewController(homeViewController, animated: true)
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
    
    
    
}



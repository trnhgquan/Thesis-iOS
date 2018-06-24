//
//  ListQuestionViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 4/20/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import CoreData
import web3swift
import Alamofire
import SwiftyJSON
import BigInt
import Result
import Foundation
import AVFoundation
class ListQuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var scanBtn: UIButton!
    var videoPreview = UIView()
    @IBOutlet weak var studentListBtn: UIButton!
    @IBOutlet weak var listQCTableView: UITableView!
    
    var user: String!
    var studentList  = [String]()
    var lessonName: String!
    var listOfQC = [NSManagedObject]()
    var answerQC: String!
//    var web3 = Web3.InfuraRopstenWeb3(accessToken: "VKIfNFfyGp3cwoGxqGyZ")
//    //    let apiKeyEtherscan = "PPID5QSTBF5Z162PR2BTUNUDZX1I19S4SY"
//    let contractAddress = "0x0b8f935f673b7292f2ed39360172d850a2500234"
//    let myAdd = "0xEBc3D75CCB8325Cb016af7d1A46e0458A48d7a44"
//    let privateKey = "d004f31c82b084cd48d3be495f26a56a847913794223027fceb7db805bf3b7d9"
//    let gasPrice = BigUInt(45000000000)
//    let gasLimit = BigUInt(3300000)
//    let value = BigUInt(0)
//    var nonce: Int?
//    let contractSystemABI = "[{\"constant\": true,\"inputs\": [],\"name\": \"name\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"addr\",\"type\": \"address\"}],\"name\": \"studentsInfo\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"_id\",\"type\": \"uint256\"},{\"name\": \"_class\",\"type\": \"string\"},{\"name\": \"_lesson\",\"type\": \"string\"}],\"name\": \"Register\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"question\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"content\",\"type\": \"string\"}],\"name\": \"transferQuestion\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"result\",\"outputs\": [{\"name\": \"lesson\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"key\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"teacher\",\"type\": \"address\"},{\"name\": \"question\",\"type\": \"uint256\"}],\"name\": \"transferQuestionFrom\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"addr\",\"type\": \"address\"}],\"name\": \"changeAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"system\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"limit\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"students\",\"outputs\": [{\"name\": \"id\",\"type\": \"uint256\"},{\"name\": \"class\",\"type\": \"string\"},{\"name\": \"lesson\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"questionS\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"teacher\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"}],\"name\": \"getQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"les\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"answer\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"content\",\"type\": \"string\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"createQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"_addr\",\"type\": \"address\"},{\"name\": \"_name\",\"type\": \"string\"},{\"name\": \"_id\",\"type\": \"uint256\"}],\"name\": \"addTeacher\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lessons\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"teachers\",\"outputs\": [{\"name\": \"name\",\"type\": \"string\"},{\"name\": \"id\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"admin\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"total\",\"outputs\": [{\"name\": \"True\",\"type\": \"uint256\"},{\"name\": \"False\",\"type\": \"uint256\"},{\"name\": \"total\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"anonymous\": false,\"inputs\": [],\"name\": \"Answer\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"newQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"index\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"content\",\"type\": \"string\"}],\"name\": \"TransferQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"result\",\"type\": \"bool\"}],\"name\": \"TransferLesson\",\"type\": \"event\"}]"
//
//
//
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        listQCTableView.tableFooterView = UIView(frame: .zero )
        let nibName = UINib(nibName: "LessonTableViewCell", bundle: nil)
        listQCTableView.register(nibName, forCellReuseIdentifier: "lessonCell")
        self.title = lessonName
        listQCTableView.delegate = self
        listQCTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listOfQC.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  listQCTableView.dequeueReusableCell(withIdentifier: "lessonCell", for: indexPath) as! LessonTableViewCell
        let item = listOfQC[indexPath.row]
        cell.lessonNameLabel.text = item.value(forKey: "nameOfQC") as? String
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    func setUpView(){
        if(!isTeacher!){
            scanBtn.setTitle("Generate QRCode", for: UIControlState.normal)
        }
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(addTapped))
        scanBtn.layer.cornerRadius = 10
        studentListBtn.layer.cornerRadius = 10
        self.navigationItem.rightBarButtonItem = addBtn
        self.listQCTableView.reloadData()
        self.view.backgroundColor = DVAColor.backgrColor
        self.listQCTableView.backgroundColor = DVAColor.backgrColor
    }
    
    @objc func addTapped(){
        let alert = UIAlertController(title: "New Question",
                                      message: "Add a new question",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Question Name"
        }
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Answer"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            let firstTextField = alert.textFields![0] as UITextField
            let secondTextField = alert.textFields![1] as UITextField
            
            let nameToSave = alert.textFields![0].text
            self.answerQC = alert.textFields![1].text
        
            
            self.save(nameToSave!)
            self.setUpView()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(_ itemName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Question", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "nameOfQC")
        
        do {
            try managedContext.save()
            listOfQC.append(item)
        } catch {
            print("Error to save")
        }
//        let numberOfQuestion = 0
//
//        let privateKeyData = Data.fromHex(self.privateKey)
//        var option = Web3Options.defaultOptions()
//        option.from = EthereumAddress(myAdd)
//        option.gasLimit = gasLimit
//        option.gasPrice = gasPrice
//        option.value = BigUInt(0)
//        let contract = web3.contract(contractSystemABI, at: EthereumAddress(contractAddress))
//        let testParameters = ["Question \(numberOfQuestion)",""] as [AnyObject]
////
//        let intermediate = contract?.method("createQuestion", parameters: testParameters, options: option)
//        guard let nonce = web3.eth.getTransactionCount(address: option.from!).value else { return }
//        try! intermediate?.setNonce(nonce)
////
//        guard var createQuestionTransaction = intermediate?.transaction else {
//            return
//        }
//        print(createQuestionTransaction)
//        print("---")
//        try! Web3Signer.EIP155Signer.sign(transaction: &createQuestionTransaction, privateKey: privateKeyData!)
//        intermediate?.transaction = createQuestionTransaction
//        intermediate?.sendSigned()
//
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isTeacher)!{
            let questionResultViewController = QuestionResultViewController(user: "QRVC")
            questionResultViewController.nameOfQC = listOfQC[indexPath.row].value(forKey: "nameOfQC") as! String
            questionResultViewController.answerOfQC = answerQC
            self.navigationController?.pushViewController(questionResultViewController, animated: true)
        }
        else {
            let questionViewController = QuestionViewController(user: "QVC")
            questionViewController.nameOfQC = listOfQC[indexPath.row].value(forKey: "nameOfQC") as! String
            self.navigationController?.pushViewController(questionViewController, animated: true)
        }
        
    }
    @IBAction func scanAction(_ sender: UIButton) {
        if(isTeacher)!{
            let QRCodeScanVC = QRCodeScannerViewController()
            self.navigationController?.pushViewController(QRCodeScanVC, animated: true)
        }
        else {
            let QRCodeVC = QRCodeViewController(user: "QRCodeVC")
            self.navigationController?.pushViewController(QRCodeVC, animated: true)
        }
    }
    @IBAction func studentListAction(_ sender: UIButton) {
        let studentListViewController = StudentListViewController(user: "StudentListVC")
        self.navigationController?.pushViewController(studentListViewController, animated: true)
    }
    
    
}

//extension ListQuestionViewController{
//
//
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
//        if(metadataObjects.count > 0) {
//            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//
//            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
//                studentID = machineReadableCode.stringValue!
//                self.studentList.append(studentID)
//                print(studentList)
//            }
//        }
//    }
//
//
//    func scanQRCode() throws {
//
//
//        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
//            print("Failed to init camera")
//            throw error.noCameraAvailable
//        }
//
//        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
//            print("Failed to init camera")
//            throw error.videoInputInitFail
//        }
//
//        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
//        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//
//        avCaptureSession.addInput(avCaptureInput)
//        avCaptureSession.addOutput(avCaptureMetadataOutput)
//
//        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
//        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
//        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
//
//        avCaptureSession.startRunning()
//    }
//
//}

//
//  QuestionResultViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 5/8/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import web3swift
import BigInt
import Result
import Foundation
import CryptoSwift
import SwiftyRSA
class QuestionResultViewController: UIViewController {
    //-- UIView
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var questionNameLabel: UILabel!
    @IBOutlet weak var sendBtnAction: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    
    
    //-- Variable
    
    


    var nameOfQC: String!
    var answerOfQC: String!
    var sent = false
    var user :String!
//    var web3 = Web3.InfuraRopstenWeb3(accessToken: "VKIfNFfyGp3cwoGxqGyZ")
//    let contractAddress = "0x0b8f935f673b7292f2ed39360172d850a2500234"
//    let myAdd = "0xEBc3D75CCB8325Cb016af7d1A46e0458A48d7a44"
//    let privateKey = "d004f31c82b084cd48d3be495f26a56a847913794223027fceb7db805bf3b7d9"
//    let gasPrice = BigUInt(45000000000)
//    let gasLimit = BigUInt(3300000)
//    let value = BigUInt(0)
//    var nonce: Int?
//    let contractSystemABI = "[{\"constant\": false,\"inputs\": [{\"name\": \"student\",\"type\": \"address\"},{\"name\": \"_id\",\"type\": \"uint256\"}],\"name\": \"Register\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"name\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"question\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"sendResultQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"content\",\"type\": \"string\"}],\"name\": \"transferQuestion\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"result\",\"outputs\": [{\"name\": \"lesson\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"_id\",\"type\": \"uint256\"},{\"name\": \"les\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"answer\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"addr\",\"type\": \"address\"}],\"name\": \"changeAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"les\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"std\",\"type\": \"address\"},{\"name\": \"res\",\"type\": \"string\"}],\"name\": \"sendResultStudent\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"answers\",\"outputs\": [{\"name\": \"lesson\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"publickey\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"limit\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"content\",\"type\": \"string[]\"},{\"name\": \"answer\",\"type\": \"string[]\"}],\"name\": \"createQuestions\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"teacher\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"check_list\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"content\",\"type\": \"string\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"createQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lessons\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"teachers\",\"outputs\": [{\"name\": \"name\",\"type\": \"string\"},{\"name\": \"id\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"admin\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"total\",\"outputs\": [{\"name\": \"True\",\"type\": \"uint256\"},{\"name\": \"False\",\"type\": \"uint256\"},{\"name\": \"total\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"inputs\": [{\"name\": \"key\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"_id\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"les\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"index\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"Answer\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"newQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"index\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"content\",\"type\": \"string\"}],\"name\": \"TransferQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"result\",\"type\": \"bool\"}],\"name\": \"TransferLesson\",\"type\": \"event\"}]"
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.view.backgroundColor = DVAColor.backgrColor
    }
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    func getTotalResult(){
        
        let privateKeyData = Data.fromHex(privateKey)
        var option = Web3Options.defaultOptions()
        option.from = EthereumAddress(myAdd)
        option.gasLimit = gasLimit
        option.gasPrice = gasPrice
        option.value = BigUInt(0)
        
        let contract = web3.contract(contractSystemABI, at: EthereumAddress(contractAddress))
        let testParameters = [0] as [AnyObject]
        
        let intermediate = contract?.method("getResult", parameters: testParameters, options: option)
        let result = intermediate?.call(options: nil)
//        print(result)
        print("------")
        switch result {
        case .success (let payload)?:
            for (key, value) in payload {
                let valueArrayString = value as! [String]
                resultForTeacher(valueArrayString: valueArrayString)
                
//
//                let privateKeyDecrypted = try? PrivateKey(pemEncoded: privateKeyOwner)
//                let encryptedEncode = try? EncryptedMessage(base64Encoded: valueArrayString[0])
//                let clearDecrypt = try? encryptedEncode?.decrypted(with: privateKeyDecrypted!, padding: .PKCS1)
//                let stringAnswer = try? clearDecrypt??.string(encoding: .utf8)
//                print(stringAnswer!)
            }
        case .failure (let error)?:
            showNotification(message: "Can not get result at this time, please try again!")
        case .none:
            print("Nothing")
        }
    }
    
    func resultForTeacher(valueArrayString: [String]){
        var trueAnswer = 0;
        var falseAnswer = 0;
        let privateKeyDecrypted = try? PrivateKey(pemEncoded: privateKeyOwner)
        for element in valueArrayString{
            let encryptedEncode = try? EncryptedMessage(base64Encoded: element)
            let clearDecrypt = try? encryptedEncode?.decrypted(with: privateKeyDecrypted!, padding: .PKCS1)
            let stringAnswer = try? clearDecrypt??.string(encoding: .utf8)
            print(stringAnswer)
            if(stringAnswer!! == self.answerOfQC){
                trueAnswer += 1
            }
            else{
                falseAnswer += 1
            }
        }
        trueLabel.text = "True: \(trueAnswer)"
        falseLabel.text = "False: \(falseAnswer)"
        totalLabel.text = "Total: \(trueAnswer+falseAnswer)"
        
    }
    @IBAction func resultBtnAction(_ sender: Any) {
        self.getTotalResult()
    }
    
    func showNotification(message: String){
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func sendBtnAction(_ sender: Any) {
        if(!sent){
            sent = true
            var content  = nameOfQC.sha256()
            let publicKeyEncrypted = try? PublicKey(pemEncoded: publicKeyOwner)
            let clear = try? ClearMessage(string: answerOfQC, using: .utf8)
            let encrypted = try? clear?.encrypted(with: publicKeyEncrypted!, padding: .PKCS1)
            let data = encrypted??.data
            let answerBase64String = encrypted??.base64String
            //-----
            let privateKeyData = Data.fromHex(privateKey)
            var option = Web3Options.defaultOptions()
            option.from = EthereumAddress(myAdd)
            option.gasLimit = gasLimit
            option.gasPrice = gasPrice
            option.value = BigUInt(0)
            let contract = web3.contract(contractSystemABI, at: EthereumAddress(contractAddress))
            let testParameters = [content,answerBase64String!] as [AnyObject]
            
            let intermediate = contract?.method("createQuestion", parameters: testParameters, options: option)
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
//            print(data)
//            print("---")
//            print(base64String)
//
//            let privateKey = try? PrivateKey(pemEncoded: privateKeyOwner)
//            let encryptedEncode = try? EncryptedMessage(base64Encoded: base64String!)
//            let clearDecrypt = try? encryptedEncode?.decrypted(with: privateKey!, padding: .PKCS1)
//            let stringAnswer = try? clearDecrypt??.string(encoding: .utf8)
//            print(stringAnswer)

        }
        else{
            sendBtn.isEnabled = false
        }
    }
    
    func setUpView(){
        A.layer.cornerRadius = 10
        B.layer.cornerRadius = 10
        C.layer.cornerRadius = 10
        D.layer.cornerRadius = 10
        sendBtn.layer.cornerRadius = 10
        questionNameLabel.text = nameOfQC
        A.isEnabled = false
        B.isEnabled = false
        C.isEnabled = false
        D.isEnabled = false
        resultBtn.layer.cornerRadius = 10
        totalLabel.layer.masksToBounds = true
        trueLabel.layer.masksToBounds = true
        falseLabel.layer.masksToBounds = true
        totalLabel.layer.cornerRadius = 10
        trueLabel.layer.cornerRadius = 10
        falseLabel.layer.cornerRadius = 10
    }
}

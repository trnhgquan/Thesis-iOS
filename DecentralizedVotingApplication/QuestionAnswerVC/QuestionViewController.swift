//
//  QuestionViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 4/11/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import web3swift
import BigInt
import Result
import Foundation
import SwiftyRSA
class QuestionViewController: UIViewController {
    
    var user :String!
    var answer: String?
    var isChecked = false
    var nameOfQC:String!
    var web3 = Web3.InfuraRopstenWeb3(accessToken: "VKIfNFfyGp3cwoGxqGyZ")
    let addressLesson = "0xebc3d75ccb8325cb016af7d1a46e0458a48d7a44"
    

    var txid: String?
    
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resultBtn: UIButton!
    @IBOutlet weak var etherSBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.nameOfQC
        setUpView()
    }
    
    @IBAction func etherScanBtnAction(_ sender: Any) {
        if(txid == nil){
            showNotification(message: "It is not available now, please submit your answer first!")
        }
        else {
            if let url = URL(string: "https://ropsten.etherscan.io/tx/\(txid!)"){
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    @IBAction func submitBtnAction(_ sender: Any) {
        if(!isChecked){
            showNotification(message: "Please choose an answer!")
        }
        else {
            self.createRawTx(answer: self.answer!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    
    //uint256 _id,address les,uint index, string answer
    func createRawTx(answer: String)  {
        let privateKeyData = Data.fromHex(privateKeyForStudent)
        var option = Web3Options.defaultOptions()
        option.from = EthereumAddress(addressforStudent)
        option.gasLimit = gasLimit
        option.gasPrice = gasPrice
        option.value = BigUInt(0)
        let contract = web3.contract(contractSystemABI, at: EthereumAddress(contractAddress))
       
        
        let publicKeyEncrypted = try? PublicKey(pemEncoded: publicKeyOwner)
        let clear = try? ClearMessage(string: answer, using: .utf8)
        let encrypted = try? clear?.encrypted(with: publicKeyEncrypted!, padding: .PKCS1)
        let data = encrypted??.data
        let answerBase64String = encrypted??.base64String
        print(answerBase64String)
        
        let testParameters = [1413159 , EthereumAddress(myAdd), 0 , answerBase64String] as [AnyObject]
        let intermediate = contract?.method("answer", parameters: testParameters, options: option)
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
        self.txid = intermediate?.transaction.txid
    }
    
    func showNotification(message: String){
        let alertController = UIAlertController(title: "Answer", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func chooseA(_ sender: Any) {
        if(isChecked && answer != "A"){
            showNotification(message: "You only have the right to choose only one answer")
        }
        else if(isChecked && answer == "A"){
            isChecked = false
            self.answer = ""
            A.backgroundColor? = UIColor.white
        }
        else {
            isChecked = true
            self.answer = "A"
            A.backgroundColor? = UIColor.gray
        }
    }
    
    @IBAction func chooseB(_ sender: Any) {
        if(isChecked && answer != "B"){
            showNotification(message: "You only have the right to choose only one answer")
        }
        else if(isChecked && answer == "B"){
            isChecked = false
            self.answer = ""
            B.backgroundColor? = UIColor.white
        }
        else {
            isChecked = true
            self.answer = "B"
            B.backgroundColor? = UIColor.gray
        }
    }
    
    @IBAction func chooseC(_ sender: Any) {
        if(isChecked && answer != "C"){
            showNotification(message: "You only have the right to choose only one answer")
        }
        else if(isChecked && answer == "C"){
            isChecked = false
            self.answer = ""
            C.backgroundColor? = UIColor.white
        }
        else {
            isChecked = true
            self.answer = "C"
            C.backgroundColor? = UIColor.gray
        }
    }
    
    @IBAction func chooseD(_ sender: Any) {
        if(isChecked && answer != "D"){
            showNotification(message: "You only have the right to choose only one answer")
        }
        else if(isChecked && answer == "D"){
            isChecked = false
            self.answer = ""
            D.backgroundColor? = UIColor.white
        }
        else {
            isChecked = true
            self.answer = "D"
            D.backgroundColor? = UIColor.gray
        }
    }
    
    
    func setUpView(){
        self.view.backgroundColor = DVAColor.backgrColor
        A.layer.cornerRadius = 10
        B.layer.cornerRadius = 10
        C.layer.cornerRadius = 10
        D.layer.cornerRadius = 10
        submitBtn.layer.cornerRadius = 10
        resultBtn.layer.cornerRadius = 10
        etherSBtn.layer.cornerRadius = 10
    }
    
    
}

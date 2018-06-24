import UIKit
import UIKit
import Alamofire
import SwiftyJSON
import web3swift
import BigInt
import Result
import Foundation
import CryptoSwift
import SwiftyRSA
var isTeacher: Bool?
var studentID: Int?

var privateKeyOwner  = "MIIBOwIBAAJBAIO1Kk95q6h/71X/GUhru9iq9IHVdC/NGVz24/dY+0IfVHTsAxiMkul5Wua68IY3zDKaypw1aOHRlNHpmB7dlD8CAwEAAQJAVIdYEUvIRMtfArVHN7iVBbiqVg11lRwv0/9MTboY/9UI04b4cAbkygDiS01A4X4kZL3eACRUgS0gbE/bl9IR8QIhAMrfuQ79RxLxgUykfqdmXHN3jqSM8Wo+Cf3KoVsDLElJAiEApjKYM3Qq2tCZGZi4Se97Y56zlkljgZE5dntXjXskOUcCIQCcx+6FBfliS18IMutqRPHXjiKfSgjbeRxRlMHDyxzzeQIhAKFCmlfisepbWRJzEu36hvkkdhCu6PRBW0ZRa6SGBaHlAiBiFeRIisN/EZhSvSEa68OgViMJJWgTYQoFCc/+R9uy4w=="

var publicKeyOwner = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIO1Kk95q6h/71X/GUhru9iq9IHVdC/NGVz24/dY+0IfVHTsAxiMkul5Wua68IY3zDKaypw1aOHRlNHpmB7dlD8CAwEAAQ=="


var web3 = Web3.InfuraRopstenWeb3(accessToken: "VKIfNFfyGp3cwoGxqGyZ")
let contractAddress = "0x7ba78023aedece8e6de01bb5992f6bce1559aeed"
let myAdd = "0xEBc3D75CCB8325Cb016af7d1A46e0458A48d7a44"
let privateKey = "d004f31c82b084cd48d3be495f26a56a847913794223027fceb7db805bf3b7d9"
let gasPrice = BigUInt(55000000000)
let gasLimit = BigUInt(3300000)
let value = BigUInt(0)
var nonce: Int?
let contractSystemABI = "[{\"constant\": false,\"inputs\": [{\"name\": \"_id\",\"type\": \"uint256\"},{\"name\": \"les\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"answer\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"addr\",\"type\": \"address\"}],\"name\": \"changeAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"content\",\"type\": \"string\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"createQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"content\",\"type\": \"string[]\"},{\"name\": \"answer\",\"type\": \"string[]\"}],\"name\": \"createQuestions\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"id\",\"type\": \"uint256\"}],\"name\": \"getResult\",\"outputs\": [{\"name\": \"\",\"type\": \"string[]\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"id\",\"type\": \"uint256\"}],\"name\": \"getStudent\",\"outputs\": [{\"name\": \"\",\"type\": \"address[]\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"index\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"content\",\"type\": \"string\"}],\"name\": \"TransferQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"newQuestion\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"_id\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"les\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"index\",\"type\": \"uint256\"},{\"indexed\": false,\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"Answer\",\"type\": \"event\"},{\"constant\": false,\"inputs\": [{\"name\": \"student\",\"type\": \"address\"},{\"name\": \"_id\",\"type\": \"uint256\"}],\"name\": \"Register\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": false,\"name\": \"result\",\"type\": \"bool\"}],\"name\": \"TransferLesson\",\"type\": \"event\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"name\": \"sendResultQuestion\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"les\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"std\",\"type\": \"address\"},{\"name\": \"res\",\"type\": \"string\"}],\"name\": \"sendResultStudent\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [],\"name\": \"teacher\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"content\",\"type\": \"string\"}],\"name\": \"transferQuestion\",\"outputs\": [{\"name\": \"\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"inputs\": [{\"name\": \"key\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"constant\": true,\"inputs\": [],\"name\": \"admin\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"answers\",\"outputs\": [{\"name\": \"lesson\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"check_list\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lessons\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"limit\",\"outputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"list_answers\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"list_students\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"name\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"publickey\",\"outputs\": [{\"name\": \"\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"question\",\"outputs\": [{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"contents\",\"type\": \"string\"},{\"name\": \"answers\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"result\",\"outputs\": [{\"name\": \"lesson\",\"type\": \"address\"},{\"name\": \"index\",\"type\": \"uint256\"},{\"name\": \"answer\",\"type\": \"string\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"}],\"name\": \"teachers\",\"outputs\": [{\"name\": \"name\",\"type\": \"string\"},{\"name\": \"id\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"address\"},{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"total\",\"outputs\": [{\"name\": \"True\",\"type\": \"uint256\"},{\"name\": \"False\",\"type\": \"uint256\"},{\"name\": \"total\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"}]"



var addressforStudent = "0x73eb5c9d37b1f79Cf2af5F65b4Fcf5F898196195"
var privateKeyForStudent = "1ec090af269e42010eddc852213ce4ffe3c2214f0831ebeca29707c91d6d9cab"

class AMSUtils  {
    
    
    class func toString(obj: Any?) -> String {
        if (obj == nil || obj is NSNull) {
            return ""
        }
        
        if let str = obj as? String {
            return str
        }
        
        return "\(obj!)"
    }
    
    class func toInt(obj: Any?) -> Int {
        if (obj == nil || obj is NSNull) {
            return 0
        }
        
        if let str = obj as? Int {
            return str
        }
        
        return 0
    }
    class func toFloat(obj: Any?) -> CGFloat {
        if (obj == nil || obj is NSNull) {
            return 0
        }
        
        if let str = obj as? CGFloat {
            return str
        }
        if let str = obj as? Double {
            return CGFloat(str)
        }
        
        return 0
    }
    
    class func toDouble(obj: Any?) -> Double {
        if (obj == nil || obj is NSNull) {
            return 0
        }
        
        if let str = obj as? Double {
            return str
        }
        
        return 0
    }
    
    class func toBool(obj: Any?) -> Bool {
        if (obj == nil || obj is NSNull) {
            return false
        }
        //kai add
        if let value = obj as? String {
            if value == "1" {
                return true
            }
            else if value == "0" {
                return false
            }
        }
        
        //---end kai Add
        
        if let value = obj as? Bool {
            return value
        }
        
        return false
    }
    
    class func estimateHeight(width: CGFloat, customFont: UIFont, str: String) -> CGFloat{
        let size = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [kCTFontAttributeName as NSAttributedStringKey: customFont], context: nil)
        return estimateFrame.height
    }
    
    class func estimateWidth(height: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: 1000, height: height)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [kCTFontAttributeName as NSAttributedStringKey as NSAttributedStringKey: customFont], context: nil)
        return estimateFrame.width
    }
    
}

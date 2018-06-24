//
//  LoginVC.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 2/20/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class LoginVC: UIViewController , UITextFieldDelegate{
    
    var user: String!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var loginButton: UIView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
        self.view.backgroundColor = DVAColor.backgrColor
        self.usernameTF.delegate = self
        self.passwordTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if(usernameTF.text == "" || passwordTF.text == ""){
            showNotification(message: "Email or Password incorrect! Please input again")
        }
        else{
            if(usernameTF.text == "Teacher"){
                isTeacher = true
                let dictionary = ["privateKey":"d004f31c82b084cd48d3be495f26a56a847913794223027fceb7db805bf3b7d9","address":"0xEBc3D75CCB8325Cb016af7d1A46e0458A48d7a44","role":"teacher","id":"CSE123456789","card":""]
                var result = dictionary.description
                result.removeFirst()
                result.removeLast()
                let text  = "{" + result + "}"
                let user = User(text: text)
                let homeViewController = HomeViewController(user: "Home")
                homeViewController.userInfor = user
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
            else {
                isTeacher = false
            }

        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let registerViewController = RegisterViewController(user: "Register")
        self.present(registerViewController, animated: true)
    }
    
    func showNotification(message: String){
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

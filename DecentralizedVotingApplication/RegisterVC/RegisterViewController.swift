//
//  RegisterViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 3/14/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var user: String!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = DVAColor.backgrColor
    }
    
    @IBAction func xButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func registerBtnAction(_ sender: Any) {
    }
}

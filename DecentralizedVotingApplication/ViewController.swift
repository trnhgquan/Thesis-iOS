//
//  ViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 2/12/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.image = UIImage(named: "logo")
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = DVAColor.backgrColor
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func startBtnAction(_ sender: Any) {
        
//        let QRLoginVC = QRLoginViewController()
//        self.navigationController?.pushViewController(QRLoginVC, animated: true)
        let loginViewController = LoginVC(user: "Quan")
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


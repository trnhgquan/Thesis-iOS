//
//  CourseViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 5/9/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var mssvTextField: UITextField!
    @IBOutlet weak var codeSelector: UISegmentedControl!
    @IBOutlet weak var imageCodeView: UIImageView!
    @IBOutlet weak var generatorBtn: UIButton!
    var filter:CIFilter!
    var user :String!
    
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    convenience init(user: String) {
        self.init()
        self.user = user
    }
    
    @IBAction func generateCode(_ sender: UIButton) {
        if let text = mssvTextField.text {
            if text == "" {
                showNotification(message: "Please insert your id!")
            } else {
                let data = text.data(using: .ascii,allowLossyConversion:  false)
                //studentID = Int(text)
                if codeSelector.selectedSegmentIndex == 0 {
                    
                    filter = CIFilter(name: "CICode128BarcodeGenerator")
                    
                } else {
                    
                    filter = CIFilter(name:"CIQRCodeGenerator")
                }
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                let image = UIImage(ciImage: filter.outputImage!.transformed(by: transform))
                imageCodeView.image = image
            }
        }
    }
    
    func showNotification(message: String){
        let alertController = UIAlertController(title: "ID", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel , handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setUpView(){
        self.view.backgroundColor = DVAColor.backgrColor
        generatorBtn.layer.cornerRadius = 10 
    }
}

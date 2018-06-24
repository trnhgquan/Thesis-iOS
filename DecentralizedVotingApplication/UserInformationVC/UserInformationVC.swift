//
//  UserInformationVC.swift
//  DecentralizedVotingApplication
//
//  Created by Tang Tuan on 6/24/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class UserInformationVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var nameOfUserLabel: UILabel!
    @IBOutlet weak var roleOfUserLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    var user: User!
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(handleHiddenViewTap))
        hiddenView.addGestureRecognizer(hideTap)
    
        setUpUserInfor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }

    func showAnimation() {
        let widthContentView = contentView.bounds.width
        contentView.transform = CGAffineTransform(translationX: -widthContentView, y: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
                self.contentView.transform = .identity
            })
        }
    }
    
    func hideAnimation(completion: (() -> Void)?) {
        let widthContentView = contentView.bounds.width
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform(translationX: -widthContentView, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.3, animations: {
               self.view.alpha = 0
            }, completion: { (true) in
                self.dismiss(animated: false, completion: nil)
                completion?()
            })
        }
    }
    
    @objc func handleHiddenViewTap() {
        hideAnimation(completion: nil)
    }
    
    func setUpUserInfor(){
        self.userAddressLabel.text = "Address: \(user.userAddress ?? "")"
        self.userIDLabel.text = "ID: \(user.id ?? "")"
        self.roleOfUserLabel.text = user.role ?? ""
        
    }

}

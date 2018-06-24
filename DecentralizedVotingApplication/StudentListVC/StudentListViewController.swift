//
//  StudentListViewController.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 6/15/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {
    var user: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    convenience init(user: String) {
        self.init()
        self.user = user
    }

}

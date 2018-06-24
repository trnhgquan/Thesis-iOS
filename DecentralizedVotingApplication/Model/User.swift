//
//  User.swift
//  DecentralizedVotingApplication
//
//  Created by Tang Tuan on 6/24/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import Foundation

struct User {
    var privateKeyString: String?
    var userAddress: String?
    var role: String?
    var id: String?
    var card: String?
    
    init(privateKeyString: String?, userAddress: String?, role: String?, id: String?, card: String?) {
        self.privateKeyString = privateKeyString
        self.userAddress = userAddress
        self.role = role
        self.id = id
        self.card = card
    }
    
    init?(text: String) {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                guard let privateKeyString = json["privateKey"] as? String,
                    let userAddress = json["address"] as? String,
                    let role = json["role"] as? String,
                    let id = json["id"] as? String,
                    let card = json["card"] as? String else {
                        return nil
                }
                self.privateKeyString = privateKeyString
                self.userAddress = userAddress
                self.role = role
                self.id = id
                self.card = card
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

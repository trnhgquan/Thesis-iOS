//
//  LessonTableViewCell.swift
//  DecentralizedVotingApplication
//
//  Created by Hoang Quan Tran on 5/14/18.
//  Copyright © 2018 Hoang Quan Tran. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    @IBOutlet weak var lessonNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.clear
        self.lessonNameLabel.backgroundColor = DVAColor.backgrColor
        self.lessonNameLabel.layer.masksToBounds = true
        self.lessonNameLabel.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

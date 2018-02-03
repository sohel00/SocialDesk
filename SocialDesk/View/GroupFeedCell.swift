//
//  GroupFeedCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 03/02/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(image: UIImage, username: String, content: String) {
        self.profileImg.image = image
        self.userNameLbl.text = username
        self.contentLbl.text = content
    }
    
}

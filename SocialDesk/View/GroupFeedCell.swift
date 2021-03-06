//
//  GroupFeedCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 03/02/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Kingfisher

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(image: URL?, username: String, content: String) {
        if image != nil {
            self.profileImg.kf.setImage(with: image)
        } else {
            self.profileImg.image = UIImage(named: "defaultProfileImage")
        }
        self.userNameLbl.text = username
        self.contentLbl.text = content
    }
    
}

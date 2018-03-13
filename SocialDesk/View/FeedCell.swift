//
//  FeedCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 20/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    func configureCell(image:URL?, email: String, message:String){
        if image != nil {
             self.userImg.kf.setImage(with: image)
        } else {
            self.userImg.image = UIImage(named: "defaultProfileImage")
        }
       
        self.emailLbl.text = email
        self.messageLbl.text = message
    }
    

}

//
//  FeedCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 20/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    func configureCell(image:UIImage, email: String, message:String){
        self.userImg.image = image
        self.emailLbl.text = email
        self.messageLbl.text = message
    }
    

}

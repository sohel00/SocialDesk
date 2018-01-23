//
//  UserCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 23/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {


    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var checkImg: UIImageView!
    
    func configureCell(forImage image:UIImage, withEmail email:String, isSelected:Bool){
        self.profileImg.image = UIImage(named: "defaultProfileImage")
        self.emailLbl.text = email
        if isSelected {
            checkImg.isHidden = false
        } else{
            checkImg.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

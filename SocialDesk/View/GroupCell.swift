//
//  GroupCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 25/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    
    func configureCell(title: String, description: String, members: Int){
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.groupMembersLbl.text = "\(members) members."
    }
    
}

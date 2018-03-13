//
//  MeCell.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 12/03/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

   
    @IBOutlet weak var groupCell: UILabel!
    
    func configureCell(labelData: String){
        self.groupCell.text = labelData
    }
    
}

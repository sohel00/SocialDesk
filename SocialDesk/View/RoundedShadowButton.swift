//
//  RoundedShadowButton.swift
//  Vision_iOS
//
//  Created by Sohel Dhengre on 07/02/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    override func awakeFromNib() {
    
        self.layer.cornerRadius = self.frame.height/2
    }

}

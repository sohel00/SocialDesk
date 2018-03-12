//
//  CircleImage.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 11/03/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

}

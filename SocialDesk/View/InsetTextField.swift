//
//  InsetTextField.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {
    
    override func awakeFromNib() {
        setUpView()
        super.awakeFromNib()
    }

    private var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    func setUpView(){
    
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        self.attributedPlaceholder = placeholder
    }
}

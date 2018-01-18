//
//  LoginVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signInPressed(_ sender: Any) {
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  AuthVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginWithFBPressed(_ sender: Any) {
    }
    @IBAction func loginWithGooglePressed(_ sender: Any) {
    }
    @IBAction func loginWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
}

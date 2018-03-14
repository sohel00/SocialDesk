//
//  LoginVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.isHidden = true
       emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func signInPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, completion: { (success, loginError) in
                if success {
                    self.spinner.isHidden = false
                    self.spinner.startAnimating()
                    NotificationCenter.default.post(name: USER_DATA_LOADED, object: nil)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing : loginError?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, completion: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, completion: { (success, nil) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.dismiss(animated: true, completion: nil)
                                print("SuccessFully Registered User")
                                
                            } else {
                                print(String(describing: registrationError?.localizedDescription))
                            }
                        })
                    }
                })
            })
        }
    
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate{}

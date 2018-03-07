//
//  AuthVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class AuthVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func loginWithFBPressed(_ sender: Any) {
    }
    @IBAction func loginWithGooglePressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            debugPrint(error)
            return
        }
        
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                debugPrint(error)
                return
            }
            print(user ?? "")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "feedVC")
            self.presentVC(vc!)
            
        }
    }
    
    
    @IBAction func loginWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
}

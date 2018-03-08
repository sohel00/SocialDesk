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
import FBSDKLoginKit
import FBSDKCoreKit



class AuthVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
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
        
        var loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email"]
        loginButton.delegate = self
        loginButton.sendActions(for: .touchUpInside)
        
       
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
            let userdata = ["provider":"Google", "email": Auth.auth().currentUser?.email]
            DataService.instance.createUser(uid: (Auth.auth().currentUser?.uid)!, userData: userdata)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "feedVC")
            self.presentVC(vc!)
            
        }
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Something went wrong", error)
        }

        
        guard let accessToken = FBSDKAccessToken.current() else {return}
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil {
                print("@@@@@@@", error ?? "")
            }
            
            let userdata = ["provider":"Facebook", "email": Auth.auth().currentUser?.email]
            DataService.instance.createUser(uid: (Auth.auth().currentUser?.uid)!, userData: userdata)
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "feedVC")
            self.presentVC(vc!)
            print("sucessful", user ?? "")
        }
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id,email,name"]).start { (connection, result, error) in
            if error != nil{
                print("abcd")
            }
            
            print("sucessfull", result ?? "")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out of facebook")
    }
    
    func fbFirebaseAuthentication(){
        
    }
    
    
    @IBAction func loginWithEmailPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
}

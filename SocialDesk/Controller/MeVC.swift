//
//  MeVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 18/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class MeVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userEmail.text = Auth.auth().currentUser?.email
    }
    
    fileprivate func logoutOfFacebook() {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        FBSDKAccessToken.setCurrent(nil)
    }

    
    @IBAction func signOutPressed(_ sender: Any) {
        let logOutPopUp = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logOutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance().signOut()
                self.logoutOfFacebook()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logOutPopUp.addAction(logOutAction)
        present(logOutPopUp, animated: true, completion: nil)
    }
    
}

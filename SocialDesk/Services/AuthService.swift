//
//  AuthService.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 17/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    static let instance = AuthService()
    
    func registerUser(withEmail email:String, andPassword password:String, completion: @escaping (_ status:Bool, _ error:Error?)->()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
               completion(false, error)
                return
            }
            
            let userData = ["provider":user.providerID, "email":user.email]
            DataService.instance.createUser(uid: user.uid, userData: userData as! [String : String])
            completion(true, nil)
        }
    }
    
    func loginUser(withEmail email:String, andPassword password:String, completion: @escaping (_ status:Bool, _ error:Error?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
}

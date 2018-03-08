//
//  DataService.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 12/01/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService{
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference{
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference{
        return _REF_FEED
    }
    
    func createUser(uid:String, userData:[String:Any]){
    REF_USERS.child(uid).updateChildValues(userData)
    }
 
    func uploadPost(withMessage message:String, forUID uid:String, withGroupKey groupKey:String?, completion: @escaping (_ status:Bool)->()){
        if groupKey != nil{
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderID": uid])
            completion(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content":message, "senderID":uid])
            completion(true)
        }
    }
    
    func getUserName(forUID uid:String, handler: @escaping (_ username:String)->()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid{
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getAllMessages(message: @escaping (_ message:[Message])->()){
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderID = message.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderID: senderID)
                messageArray.append(message)
                
            }
            message(messageArray)
            
        }
    }
    
    
    
    func getAllGroupMessages(group: Group, handler: @escaping (_ messagesArray:[Message])->()){
        var groupMessageArray = [Message]()
        REF_GROUPS.child(group.groupKey).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value  as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderID: senderId)
                groupMessageArray.append(message)
            }
            handler(groupMessageArray)
        }
    }
    
    func getEmail(forSearchQuery query:String, handler: @escaping (_ email:[String])->()){
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email{
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getIds(forUsername username: [String], handler: @escaping (_ uidArray: [String])->()){
        var uidArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot{
               let email = user.childSnapshot(forPath: "email").value as! String
                if username.contains(email) {
                    uidArray.append(user.key)
                }
            }
            handler(uidArray)
        }
    
    }
    
    func getEmailsFor(group:Group, handler:@escaping (_ emailArray:[String])->()){
        var emails = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapshot{
                if group.members.contains(user.key){
                let email = user.childSnapshot(forPath: "email").value as! String
                emails.append(email)
            }
        }
        handler(emails)
    }
   }
    
    func createGroup(forTitle title: String, withDescription description: String,forUserIds uids: [String], handler:(_ status:Bool)->()){
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": uids])
        handler(true)
    }
    
    
    
    func getAllGroups(handler:@escaping (_ groups:[Group])->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for groups in groupSnapshot{
                let group = groups.childSnapshot(forPath: "members").value as! [String]
                if group.contains((Auth.auth().currentUser?.uid)!){
                    let title = groups.childSnapshot(forPath: "title").value as! String
                    let desc = groups.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, desc: desc, key: groups.key, memberCount: group.count, members:group )
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
}










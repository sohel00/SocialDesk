//
//  CreateGroupsVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 23/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
       emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        doneBtn.isHidden = true
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidChange(){
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTextField.text != "" && descTextField.text != "" {
            DataService.instance.getIds(forUsername: chosenUserArray, handler: { (returndedUids) in
                var uids = returndedUids
                uids.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(forTitle: self.titleTextField.text!, withDescription: self.descTextField.text!, forUserIds: uids, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            })
        }
    }
    
   
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        if chosenUserArray.contains(emailArray[indexPath.row]){
             cell.configureCell(forImage: profileImage!, withEmail: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(forImage: profileImage! , withEmail: emailArray[indexPath.row], isSelected: false)
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
           chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text})
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "Add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}








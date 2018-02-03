//
//  GroupFeedVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 03/02/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupMembersLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendBtnView: UIView!
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendBtnView.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.groupTitleLbl.text = group?.groupTitle
        self.groupMembersLbl.text = group?.members.joined(separator: ", ")
    }
    
    func initData(forGroup group: Group){
        self.group = group
    }

    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnpressed(_ sender: Any) {
    }
    
}

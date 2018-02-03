//
//  SecondViewController.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 11/01/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    var groups = [Group]()
    @IBOutlet weak var groupsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (groupsData) in
                self.groups = groupsData
                self.groupsTableView.reloadData()
            }
        }
    }
}

extension GroupsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, members: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else {return}
        present(groupFeedVC, animated: true, completion: nil)
    }
}

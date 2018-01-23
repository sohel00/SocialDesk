//
//  FirstViewController.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 11/01/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    var Messages = [Message]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataService.instance.getAllMessages { (returnedMessages) in
            self.Messages = returnedMessages.reversed()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

    extension FeedVC: UITableViewDelegate, UITableViewDataSource{

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else {return UITableViewCell()}
            let image = UIImage(named: "defaultProfileImage")
            let message = Messages[indexPath.row]
            DataService.instance.getUserName(forUID: message.senderID) { (returnedUsername) in
                cell.configureCell(image: image!, email: returnedUsername , message: message.content)
            }
            
            return cell
        }
     }




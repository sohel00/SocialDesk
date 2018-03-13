//
//  FirstViewController.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 11/01/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
class FeedVC: UIViewController {

    var Messages = [Message]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        DataService.instance.REF_FEED.observe(.value) { (snapShot) in
            DataService.instance.getAllMessages { (returnedMessages) in
                self.Messages = returnedMessages.reversed()
                self.tableView.reloadData()
            }
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else {return UITableViewCell()}
            
            let message = Messages[indexPath.row]
            DataService.instance.getUserName(forUID: message.senderID) { (returnedUsername) in
                DataService.instance.getProfleImg(forUID: message.senderID, handler: { (returnedURL) in
                    if returnedURL != nil {
                        cell.configureCell(image: returnedURL, email: returnedUsername, message: message.content)
                    }                                        
                })
            }

            
            return cell
}

}

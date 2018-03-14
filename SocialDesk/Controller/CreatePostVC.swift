//
//  CreatePostVC.swift
//  SocialDesk
//
//  Created by Sohel Dhengre on 20/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadProfileImage()
        
        textView.delegate = self

        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
     func LoadProfileImage(){
        DataService.instance.getProfleImg(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUrl) in
            let image = UIImage(named: "defaultProfileImage")
            self.profileImg.kf.setImage(with: returnedUrl, placeholder: image)
        }
    }
    
    @objc func handleTap(){
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.userEmailLbl.text = Auth.auth().currentUser?.email
    }

    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != "" && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, completion: { (success) in
                if success {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("there was an error")
                }
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
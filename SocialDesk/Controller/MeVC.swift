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
import FirebaseStorage
import Kingfisher

class MeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    var groups = [Group]()
    
    
    
    
    let DB = Database.database().reference()
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadProfileImage()
        LoadGroups()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        profileImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage(_:)))
        profileImg.addGestureRecognizer(tap)
    }
    
    func LoadProfileImage(){
        DataService.instance.getProfleImg(forUID: (Auth.auth().currentUser?.uid)!) { (returnedUrl) in
            let image = UIImage(named: "defaultProfileImage")
            self.profileImg.kf.setImage(with: returnedUrl, placeholder: image)
        }
    }
    
    func LoadGroups(){
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (groupsData) in
                self.groups = groupsData
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func didTapProfileImage(_ sender: UITapGestureRecognizer) {
        
        let myActionSheet = UIAlertController(title: "Profile Picture", message: "", preferredStyle: .actionSheet)
        
        let viewPicture = UIAlertAction(title: "View Picture", style: .default) { (action) in
            
            let imageView = sender.view as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
        
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullScreenImage(sender:)))
            
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            
        }
        
        let photoGallery = UIAlertAction(title: "Photos", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.allowsEditing = true
                
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }
            
        }
        
        
        
        myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(camera)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    @objc func dismissFullScreenImage(sender: UITapGestureRecognizer){
        
        sender.view?.removeFromSuperview()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.profileImg.image = image
        
        
        let uploadData = UIImageJPEGRepresentation(image!, 0.8)
            let imgUid = Auth.auth().currentUser?.uid
        DataService.instance.REF_STORAGE.child(imgUid!).putData(uploadData!, metadata:nil , completion: { (metaData, error) in
                if error != nil {
                    print("khfk")
                } else {
                    print("sucessfully uploaded image")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        let profileImage = ["ProfileImage":url]
                        DataService.instance.uploadProfileImage(forUid: (Auth.auth().currentUser?.uid)!, userData: profileImage, handler: { (status) in
                            if status {
                                print("sucessfull")
                            } else {
                                print("unsucessfull")
                            }
                        })
                    }
                }
            })
        
        picker.dismiss(animated: true, completion: nil)
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
                self.profileImg.image = UIImage(named: "defaultProfileImage")
            } catch {
                print(error)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alertAction: UIAlertAction!) in
            logOutPopUp.dismiss(animated: true, completion: nil)
        })
        logOutPopUp.addAction(logOutAction)
        logOutPopUp.addAction(cancel)
        present(logOutPopUp, animated: true, completion: nil)
    }
    
}

extension MeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "meCell", for: indexPath) as? MeCell else { return UITableViewCell() }
        let group = groups[indexPath.row]
        cell.configureCell(labelData: group.groupTitle)
        return cell
    }
    
}





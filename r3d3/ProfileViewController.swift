//
//  ProfileViewController.swift
//  r3d3
//
//  Created by HG on 2/6/17.
//  Copyright © 2017 HG. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {


    @IBOutlet weak var userImageView: UIImageView!
    
    
        var dataBaseRef: FIRDatabaseReference! {
            return FIRDatabase.database().reference()
        }
        
        var storageRef: FIRStorage {
            
            return FIRStorage.storage()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadUserInfo()
                
        }
        
        func loadUserInfo(){
            
            let userRef = dataBaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)")
            userRef.observe(.value, with: { (snapshot) in
                
                let user = User(snapshot: snapshot)
              
                let imageURL = user.photoURL!
                
                self.storageRef.reference(forURL: imageURL).data(withMaxSize: 1 * 1024 * 1024, completion: { (imgData, error) in
                    
                    if error == nil {
                        DispatchQueue.main.async {
                            if let data = imgData {
                                self.userImageView.image = UIImage(data: data)
                            }
                        }
                        
                        
                        
                        
                        
                    }else {
                        print(error!.localizedDescription)
                        
                    }
                    
                    
                })
                
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            
            
            
    }
            
}

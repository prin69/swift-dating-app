

import UIKit
import Firebase
import Photos
import MobileCoreServices
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SDWebImage


class Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var userImageView: UIImageView!
    
        
        var databaseRef: FIRDatabaseReference!
        var storageRef: FIRStorageReference!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            
            userImageView.layer.borderWidth = 1
            userImageView.layer.masksToBounds = false
            userImageView.layer.borderColor = UIColor.black.cgColor
            userImageView.layer.cornerRadius = userImageView.frame.height/1.95
            userImageView.clipsToBounds = true
            
            
            
            
            
            databaseRef = FIRDatabase.database().reference()
            storageRef = FIRStorage.storage().reference()
            
            loadProfileData()
          
    }
    
    @IBOutlet weak var firstLastName: UILabel!
    
    
    @IBAction func logOut(_ sender: Any) {
        
        
        
            if FIRAuth.auth()!.currentUser != nil {
            // there is a user signed in
            do {
                try? FIRAuth.auth()!.signOut()
                
                if FIRAuth.auth()?.currentUser == nil {
                    self.performSegue(withIdentifier: "logOut", sender: nil)
                }
                
            }
        }
        
        
        
    }
            func loadProfileData(){
            
            //if the user is logged in get the profile data
            
            if let userID = FIRAuth.auth()?.currentUser?.uid{
                databaseRef.child("users").child(userID).observe(.value, with: { (snapshot) in
                    
                    //create a dictionary of users profile data
                    let values = snapshot.value as? NSDictionary
                    
                    //if there is a url image stored in photo
                    if let profileImageURL = values?["photoURL"] as? String{
                        //using sd_setImage load photo
                        self.userImageView.sd_setImage(with: URL(string: profileImageURL))
                    }
                                       
                    self.firstLastName.text = values?["firstLastName"] as? String
                })
                
            }
        }
        
}

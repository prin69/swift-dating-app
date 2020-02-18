
import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

struct AuthService {
    
    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    
    // 1 - Creating the Signup function
    
    func signUp (firstLastName: String,username: String, email: String, country: String, biography: String, password: String, pictureData: NSData!) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(firstLastName:firstLastName,user: user, username: username, country: country, biography: biography, password: password, pictureData: pictureData)
            } else {
                print(error!.localizedDescription)
                print("error")
            }
        })
        
        
    }
    
    
    // 2 - Save the User Profile Picture to Firebase Storage, Assign to the new user a username and Photo URL
    
    private func setUserInfo(firstLastName: String,user: FIRUser!, username: String, country: String, biography: String, password: String, pictureData: NSData!){
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(pictureData as Data, metadata: metaData) { (newMetaData, error) in
            
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                
                if let photoURL = newMetaData!.downloadURL() {
                    changeRequest.photoURL = photoURL
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveUserInfo(firstLastName: firstLastName,user:user, username: username, country: country, biography: biography, password: password)
                        
                        
                    }else{
                        print(error!.localizedDescription)
                        
                    }
                })
                
                
            }
            else {
                print(error!.localizedDescription)
            }
            
        }
        
        
        
    }
    
    // 3 - Save the User Info to Firebase Database
    
    private func saveUserInfo(firstLastName: String,user: FIRUser!, username: String, country: String, biography: String, password: String){
        
        let userInfo = ["firstLastName":firstLastName,"email": user.email!, "username": username, "country": country, password: "password", "biography":biography, "uid": user.uid, "photoURL": String(describing: user.photoURL!)]
        
        let userRef = dataBaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo) { (error, ref) in
            if error == nil {
                print("user info saved successfully")
                self.logIn(email: user.email!, password: password)
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
        
    }
    
    
    // 4 - Logging the user in function
    
    
    func logIn(email: String, password: String){
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    
                    print("\(user.displayName!) has logged in successfully")
                    
                }
                
                
            }
            else {
                print(error!.localizedDescription)
                
            }
        })
        
    }
    
    
    
    
    
}

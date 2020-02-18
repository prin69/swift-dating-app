

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class UserPage: UIViewController {
    

    
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    
    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
                            self.userImage.image = UIImage(data: data)
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

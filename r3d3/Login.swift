import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class Login: UIViewController {

    var ref : FIRDatabaseReference!
    
    
    
    
    
    
    
    @IBOutlet weak var emailText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loggedIn(_ sender: Any) {
        login()
    }
    
    func login(){
        
        guard let email = emailText.text else {
            print("error")
            return
            
        }
        guard let password = passwordText.text else{
            print("error")
            return
        }
            
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                return
            }
          self.performSegue(withIdentifier: "loginToProfile", sender: nil)
        })
        
        
        
        
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dismiss keyboard
       
        //dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        
          ref =  FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
    }

  
}


















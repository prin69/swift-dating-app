////
////  Register.swift
////  r3d3
////
////  Created by HG on 2/2/17.
////  Copyright © 2017 HG. All rights reserved.
////
//



import UIKit

class Register: UIViewController {
    
       var pickerView: UIPickerView!
   
    var authService = AuthService()
    
    
    
    
    
    
    @IBOutlet weak var countryTextField: UITextField!
    
    
    
    @IBOutlet weak var userImage: UIImageView!{
    didSet {
    userImage.layer.cornerRadius = 5
    userImage.isUserInteractionEnabled = true
    }
    }
    
    @IBOutlet weak var firstLastNameTextField: UITextField!
    
    @IBOutlet weak var biographyTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    @IBAction func registerButton(_ sender: Any) {
        signUp()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        setGestureRecognizersToDismissKeyboard()

        
        
    }
    
    
    func showMessage() {
        
        let alertController = UIAlertController(title: "OOPS", message: "A user with the same username already exists. Please choose another one", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    func signUp() {
        
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
      let country = countryTextField.text!
        let biography = biographyTextField.text!
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let firstLastName = firstLastNameTextField.text!
        let pictureData = UIImageJPEGRepresentation(self.userImage.image!, 0.70)
        
        if finalEmail.isEmpty || country.isEmpty || biography.isEmpty || username.isEmpty || password.isEmpty {
            self.view.endEditing(true)
            let alertController = UIAlertController(title: "OOPS", message: "hEY MAN, You gotta fill all the fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }else {
            self.view.endEditing(true)
            authService.signUp(firstLastName: firstLastName,username: username, email: finalEmail, country: country, biography: biography, password: password, pictureData: pictureData as NSData!)
            
        }
         self.performSegue(withIdentifier: "regPageToProfile", sender: nil)
    }

}



extension Register: UITextFieldDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func setGestureRecognizersToDismissKeyboard(){
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(Register.choosePictureAction(sender:)))
        imageTapGesture.numberOfTapsRequired = 1
        userImage.addGestureRecognizer(imageTapGesture)
        
           }
    
      func choosePictureAction(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Profile Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage]  as? UIImage{
            self.userImage.image = image
        }else if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.userImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    


















}

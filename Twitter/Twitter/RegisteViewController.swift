//
//  RegisteViewController.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/12/21.
//

import UIKit

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class RegisteViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        if (email != "" && password != ""){
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!) {[weak self](result, error) in
                self?.indicator.stopAnimating()
                
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                let user = TwitterUser((self?.nameField?.text)!,(self?.surnameField.text)!,(self?.dateOfBirth.text)!,(self?.emailField.text)!,(self?.passwordField.text)!, (result?.user.uid)!)
                Database.database().reference().child("users").child((result?.user.uid)!).setValue(user.dict)
                if error  == nil{
                    self?.showMessage(title: "Succes", message: "Please verify yout email")
                }
                else {
                    self?.showMessage(title: "Error", message: error.debugDescription)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
           
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showMessage(title: String, message:String){
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title:"OK", style: .default){
            (UIAlertAction) in
            if (title != "Error") {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUsersPhotoURL(withImage: UIImage, andFileName: String) {
        guard let imageData = withImage.jpegData(compressionQuality: 0.3) else { return }
        let storageRef = Storage.storage().reference()
        let thisUserPhotoStorageRef = storageRef.child("this users uid").child(andFileName)

        let uploadTask = thisUserPhotoStorageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("error while uploading")
                return
            }

            thisUserPhotoStorageRef.downloadURL { (url, error) in
                print(metadata.size) // Metadata contains file metadata such as size, content-type.
                thisUserPhotoStorageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("an error occured after uploading and then getting the URL")
                        return
                    }

                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = downloadURL
                    changeRequest?.commitChanges { (error) in
                        //handle error
                    }
                }
            }
        }
    }
}



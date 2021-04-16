//
//  EditViewController.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/16/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
class EditViewController: UIViewController {
    var currentUser : User?;
    
    var name:String?
    var surname:String?
    var dateOfBirth:String?
    var delegate: UpdateProtocol?
    var image : UIImage?
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        nameField.text = name
        surnameField.text = surname
        dateOfBirthField.text = dateOfBirth
        photo.image = image
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        currentUser = Auth.auth().currentUser
        let ref = Database.database().reference().child("users").child(currentUser!.uid)
        ref.updateChildValues(["name": nameField.text!,
                               "surname": surnameField.text!,
                               "dateOfBirth": dateOfBirthField.text!])
        dismiss(animated: true, completion: nil)
        delegate!.updateInfo(nameField.text!, surnameField.text!, dateOfBirthField.text!,photo.image!);
    }
    
    @IBAction func uploadPhotoPressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
               vc.sourceType = .photoLibrary
               vc.delegate = self
               vc.allowsEditing = true
               present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func uploadProfileImage (_ image: UIImage, completion: @escaping ((_ url: URL?) -> ())) {
            let data = image.pngData()
            let storageRef = Storage.storage().reference().child("images/\(currentUser!.uid).jpg")
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            storageRef.putData(data!, metadata: metaData) { [self] (metadata, error) in
                Storage.storage().reference().child("images/\(self.currentUser!.uid).jpg").downloadURL { (url, error) in
                    if let URL = url {
                        completion(URL)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            photo.image = image
            uploadProfileImage(image){url in }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

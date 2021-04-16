//
//  UserViewController.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/16/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class UserViewController: UIViewController, UpdateProtocol{
    func updateInfo(_ name: String, _ surname: String, _ dateOfBirth: String, _ photo: UIImage) {
        userName.text = name
        userSurname.text = surname
        UserDateOfBirth.text = dateOfBirth
        userPhoto.image = photo
    }
    
    @IBOutlet weak var userPhoto: UIImageView!
    var currentUser: User?
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userSurname: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var UserDateOfBirth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        // Do any additional setup after loading the view.
        let ref = Database.database().reference().child("users").child(currentUser!.uid)

        ref.observeSingleEvent(of: .childAdded, with: { [weak self] (snapshot) in
            let user = TwitterUser(snapshot)
            self?.userName.text = user.name
            self?.userSurname.text = user.surname
            self?.userEmail.text = user.email
            self?.UserDateOfBirth.text = user.dateOfBirth
        })
        
        
       
        let reference = Storage.storage().reference().child("images/\(currentUser!.uid).jpg")
        reference.getData(maxSize: 2 * 1024 * 1024) { data, error in
            if error != nil {
                print(error as Any)
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
            self.userPhoto.image = image
          }
        }
            
            
    }
    override func viewWillAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        // Do any additional setup after loading the view.
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .childAdded, with: { [weak self] (snapshot) in
            print(snapshot.children.allObjects)
            let user = TwitterUser(snapshot)
            self?.userName.text = user.name
            self?.userSurname.text = user.surname
            self?.userEmail.text = user.email
            self?.UserDateOfBirth.text = user.dateOfBirth
        })
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch{
            print("Error message")
        }
        self.dismiss(animated: true, completion: nil )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editSegue"){
            let destination = segue.destination as! EditViewController
            destination.name = userName.text
            destination.dateOfBirth = UserDateOfBirth.text
            destination.surname = userSurname.text
            destination.image = userPhoto.image
            destination.delegate = self
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

protocol UpdateProtocol {
    func updateInfo(_ name: String,_ surname: String, _ dateOfBirth: String, _ photo: UIImage)
}


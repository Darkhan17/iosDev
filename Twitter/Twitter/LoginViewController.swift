//
//  LoginViewController.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/12/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    var currentUser:User?
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginClicked(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        indicator.startAnimating()
        if (email != "" && password != ""){
            Auth.auth().signIn(withEmail: email!, password: password!) {
                [weak self](result,error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        self?.goToUserPage()
                    }
                    else {
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
                }
                else {
                    
                }
            }
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser

        if (currentUser != nil && currentUser!.isEmailVerified){
            goToUserPage()
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

    func goToUserPage(){
        let storyboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "UserViewController") as? UserViewController{
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
            }
        }
}

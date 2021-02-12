//
//  DetailViewController.swift
//  PhoneBook
//
//  Created by Khamitov Darkhan on 2/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    var nameSurname:String?
    var phoneNumber:String?
    var gender : String?
    var image : UIImage?
    var index : Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameAndSurnameLabel.text = nameSurname
        phoneNumberLabel1.text = phoneNumber
        genderLabel.text = gender
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameAndSurnameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel1: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func deleteContact(_ sender: UIButton) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.index = index
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

//
//  CreateViewController.swift
//  PhoneBook
//
//  Created by Khamitov Darkhan on 2/12/21.
//

import UIKit

class CreateViewController: UIViewController {
    var contact:Contact?
    var listOfgender = ["male", "female"]
    var gender : String?
    var image :UIImage?
    
    
    @IBOutlet weak var name: UITextField!
    
    
    @IBOutlet weak var phoneNumber:
        UITextField!
    
    
    @IBOutlet weak var gendePicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gendePicker.dataSource = self
        gendePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.name = name.text
        destination.phoneNumber = phoneNumber.text
        destination.gender =  gender ?? "male"
        destination.image = UIImage.init(named: destination.gender!)
        
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

extension CreateViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfgender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = listOfgender[row]
    }
}

extension CreateViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfgender[row]
    }
}

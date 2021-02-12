//
//  ViewController.swift
//  PhoneBook
//
//  Created by Khamitov Darkhan on 2/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var name : String?
    var phoneNumber : String?
    var image : UIImage?
    var gender : String?
    var index : Int?
    
    
    
    
    var contacts = [Contact.init("Wasya Pupkin", "877733", UIImage.init(named: "female")!,"female"),
                    Contact.init("Darkhan Khamitov","870544444", UIImage.init(named: "male")!,"male")]
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTCell
        cell?.studentName.text = contacts[indexPath.row].nameSurname
        cell?.studentGpa.text = contacts[indexPath.row].phoneNumber
        cell?.imageView?.image = contacts[indexPath.row].image
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableView.deselectRow(at: indexPath, animated: true)
    }
    @IBOutlet weak var TableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any? ) {
        if (segue.identifier=="Detailed"){
            let index = (TableView.indexPathForSelectedRow?.row)!
            let destination = segue.destination as! DetailViewController
            destination.nameSurname = contacts[index].nameSurname
            destination.phoneNumber = contacts[index].phoneNumber
            destination.gender = contacts[index].gender
            destination.image = contacts[index].image
            destination.index = index
        }
    }
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue){
        if (self.name != nil){
        let contact = Contact.init(name!, phoneNumber!, image!, gender!)
        contacts.append(contact)
            name = nil
        }
        else if ((index!) != 0){
            contacts.remove(at: index!)
            index=nil
        }
        TableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


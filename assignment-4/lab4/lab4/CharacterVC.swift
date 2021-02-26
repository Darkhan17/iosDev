//
//  CharacterVC.swift
//  lab4
//
//  Created by Khamitov Darkhan on 2/25/21.
//

import UIKit

class CharacterVC: UITableViewController {
    var name: String?
    var url: String?
    
    
    
   
   
    @IBAction func didChangePressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            characters = websites
        }
        else
        {
         characters = favourites
        }
        tableView.reloadData()
    }
    

    @IBAction func addPressed(_ sender: Any) {
    }
    
    
    private var favourites : [Character] = []
    private var  websites : [Character] = [Character.init(name: "Google", url: "https://www.google.com")]
    private var characters : [Character] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Websites"
        characters = websites
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       
    }

    // MARK: - Table view data source

    
 
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.row].name

        return cell
    }


   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            if let navcon = segue.destination as? UINavigationController {
                if let destination = navcon.visibleViewController as? infoVC{
                    if let row = tableView.indexPathForSelectedRow?.row{
                        destination.my_url = characters[row].url
                        destination.navigationItem.title = characters[row].name
                    }
                }
            }
        }
    }
    
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {
        if name != nil {
            characters.append(Character(name: name!, url: url!))
        }
        tableView.reloadData()
    }

}
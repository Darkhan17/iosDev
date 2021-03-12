//
//  EventsVC.swift
//  KBTU
//
//  Created by Khamitov Darkhan on 3/12/21.
//

import UIKit

class EventsVC: UITableViewController{

    
    private var events = [Event](arrayLiteral: Event.init(title: "Covid", information: "new virus"), Event.init(title: "Holidays", information: "new dates"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row].title;
        cell.detailTextLabel?.text = events[indexPath.row].information;
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any? ) {
            let destination = segue.destination as! DetailViewController
            if let row = tableView.indexPathForSelectedRow?.row{
                destination.title = events[row].title
                destination.title1 = events[row].title
                destination.myInformation = events[row].information
        }
    }
}

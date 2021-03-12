//
//  DetailViewController.swift
//  KBTU
//
//  Created by Khamitov Darkhan on 3/12/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myTitle: UILabel!
    
    
    @IBOutlet weak var information: UILabel!
    
    var title1: String?
    var myInformation: String?
    override func viewDidLoad(){
        super.viewDidLoad()
        myTitle.text = title1
        information.text = myInformation
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

}

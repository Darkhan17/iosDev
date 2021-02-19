//
//  ViewController.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/18/21.
//

import UIKit

class ViewController: UIViewController {
    var  shape:String?
    
    @IBAction func circleButton(_ sender: Any) {
        shape = "circle"
    }
    
    
    @IBAction func rectangle(_ sender: Any) {
        shape = "rectangle"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


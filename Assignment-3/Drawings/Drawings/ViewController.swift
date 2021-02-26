//
//  ViewController.swift
//  Drawings
//
//  Created by Khamitov Darkhan on 2/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var customView: CustomView!
    
    @IBOutlet weak var button: UIButton!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func shapePressed(_ sender: UIButton) {
        customView.shape = sender.currentTitle!
    }
    
    @IBAction func filledPressed(_ sender: UISwitch){
        customView.filled = sender.isOn
    }
    @IBAction func colorPressed(_ sender: UIButton) {
        customView.colorButton = sender.currentTitle!
    }
    
override func viewDidLoad() {
        super.viewDidLoad()
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Tap))
    let holdGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(Hold))
        deleteButton.addGestureRecognizer(tapGestureRecognizer)
        deleteButton.addGestureRecognizer(holdGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    @objc func Tap(){
        if (!customView.drawings.isEmpty){
            customView.drawings.removeLast()
        }
        customView.setNeedsDisplay()
    }
    
    @objc func Hold(){
        if (!customView.drawings.isEmpty){
            customView.drawings.removeAll()
        }
        customView.setNeedsDisplay()
    }


}


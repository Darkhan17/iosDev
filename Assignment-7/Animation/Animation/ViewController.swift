//
//  ViewController.swift
//  Animation
//
//  Created by Khamitov Darkhan on 4/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var firstTextField: UIView!
    
    @IBOutlet var secondTextField: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var firstTextFieldConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var secondTextFieldConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.alpha = 0
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = UIColor.white.cgColor
        firstTextFieldConstraint.constant -= view.bounds.width
        secondTextFieldConstraint.constant +=
                view.bounds.width
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.firstTextFieldConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    
    
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        self.secondTextFieldConstraint.constant -= self.view.bounds.width
        self.view.layoutIfNeeded()
    }, completion: nil)
        
        
        UIView.animate(withDuration: 1, delay: 0.2){
            self.nextButton.alpha = 1
        }
}
    override func viewDidDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.firstTextFieldConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    
    
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        self.secondTextFieldConstraint.constant += self.view.bounds.width
        self.view.layoutIfNeeded()
    }, completion: nil)
        
        
        UIView.animate(withDuration: 1, delay: 0.2){
            self.nextButton.alpha = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewDidDisappear(true)
    }
    
    


}


//
//  homeVC.swift
//  KBTU
//
//  Created by Khamitov Darkhan on 3/11/21.
//

import UIKit

class homeVC: UIViewController {
    
    @IBOutlet weak var newsButton: UIButton!
    
    @IBOutlet weak var eventsButton: UIButton!
    
    @IBOutlet weak var facultiesButton: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        
 
    }
    

    func setButtons(){
        newsButton.layer.cornerRadius = 10
        newsButton.layer.borderWidth = 1
        newsButton.layer.borderColor = UIColor.white.cgColor
        
        eventsButton.layer.cornerRadius = 10
        eventsButton.layer.borderWidth = 1
        eventsButton.layer.borderColor = UIColor.white.cgColor
        
        facultiesButton.layer.cornerRadius = 10
        facultiesButton.layer.borderWidth = 1
        facultiesButton.layer.borderColor = UIColor.white.cgColor
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

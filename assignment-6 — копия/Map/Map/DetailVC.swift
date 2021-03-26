//
//  DetailVC.swift
//  Map
//
//  Created by Khamitov Darkhan on 3/24/21.
//

import UIKit
import MapKit

protocol ChangeLocation {
    func change(annotation: MKAnnotation, title: String, subtitle: String)
}


class DetailVC: UIViewController {
    var myTitle: String?
    var mySubtitle: String?
    var index: Int?
    var delegate: ChangeLocation?
    var annotation : MKAnnotation?
    
    @IBOutlet weak var locationTitle: UITextField!
    
    @IBOutlet weak var locationSubtitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTitle.text = myTitle
        locationSubtitle.text = mySubtitle
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.change(annotation: annotation!, title: locationTitle.text!, subtitle: locationSubtitle.text!)
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

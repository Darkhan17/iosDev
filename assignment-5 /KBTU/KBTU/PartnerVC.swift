//
//  PartnerVC.swift
//  KBTU
//
//  Created by Khamitov Darkhan on 3/12/21.
//

import UIKit

class PartnerVC: UIViewController {

    @IBOutlet weak var mainScroll: UIScrollView!

    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images  = [#imageLiteral(resourceName: "part35-min"),#imageLiteral(resourceName: "part28-min"),#imageLiteral(resourceName: "part36-min"),#imageLiteral(resourceName: "part46-min")]
        // Do any additional setup after loading the view.
        mainScroll.frame = view.frame
        for i in 0..<images.count{
            let imageView = UIImageView()
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.view.frame.height )
            
            mainScroll.contentSize.width = mainScroll.frame.width * CGFloat(i + 1)
            
            mainScroll.addSubview(imageView)
            
        }
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

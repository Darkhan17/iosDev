//
//  CustomCell.swift
//  Animation
//
//  Created by Khamitov Darkhan on 4/3/21.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var main: UIView!
    
    @IBOutlet weak var detail: UIView!
    
    
    @IBOutlet weak var phoneName: UILabel!
    
    @IBOutlet weak var phonePrice: UILabel!
    
    @IBAction func detailButtonPressed(_ sender: Any){
        self.detail.alpha = 1.0
        self.main.alpha = 0
        self.detail.center.x = self.contentView.frame.width/2
        UIView.transition(with: detail, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            self.detail.isHidden = false
            self.contentView.bringSubviewToFront(self.detail)
        }, completion: nil)
    }
    
    @IBOutlet weak var phoneProcessor: UILabel!
    
    @IBOutlet weak var phoneCamera: UILabel!
    
    @IBAction func hideButtonPressed(_ sender: Any) {
        self.main.alpha = 1.0
        UIView.transition(with: detail, duration: 0.5, options: .allowAnimatedContent, animations: {
            self.detail.alpha = 0
            self.detail.center.x = self.contentView.frame.width + self.contentView.frame.width / 2
        }, completion: nil)
    }
    
    @IBOutlet weak var hideButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideButton.layer.cornerRadius = 10
       hideButton.layer.borderWidth = 2
       hideButton.layer.borderColor = UIColor.white.cgColor
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

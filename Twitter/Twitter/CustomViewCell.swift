//
//  CustomViewCell.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/16/21.
//

import UIKit

class CustomViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var hashtag: UILabel!
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

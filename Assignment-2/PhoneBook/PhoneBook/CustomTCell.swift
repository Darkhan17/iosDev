//
//  CustomTCell.swift
//  PhoneBook
//
//  Created by Khamitov Darkhan on 2/11/21.
//

import UIKit

class CustomTCell: UITableViewCell {


    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImageView: UIImageView!
    @IBOutlet weak var studentGpa: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

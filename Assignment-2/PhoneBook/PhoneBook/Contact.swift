//
//  Student.swift
//  PhoneBook
//
//  Created by Khamitov Darkhan on 2/11/21.
//

import Foundation
import UIKit
class Contact {
    
    
    var nameSurname:String?
    var phoneNumber:String?
    var image : UIImage?
    var gender : String?

    init(_ nameSurname:String, _ phoneNumber:String, _ image :UIImage, _ gender:String) {
        self.nameSurname=nameSurname
        self.phoneNumber=phoneNumber
        self.image=image
        self.gender=gender
    }
    
}

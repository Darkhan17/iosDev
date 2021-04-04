//
//  Phone.swift
//  Animation
//
//  Created by Khamitov Darkhan on 4/3/21.
//

import Foundation

class Phone {
    var name: String?
    var price: String?
    var processor: String?
    var camera: String?
    
    init(_ name: String, _ price: String,_ processor: String,_ camera:String) {
        self.name = name
        self.price = price
        self.camera = camera
        self.processor = processor
    }
}

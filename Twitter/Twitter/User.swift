//
//  User.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/16/21.
//

import Foundation

import FirebaseDatabase

struct TwitterUser {
    var name: String?
    var surname: String?
    var dateOfBirth:String?
    var email: String?
    var password: String?
    var uid: String?
    
    var dict: [String: String]{
        return["name":name!,
               "surname":surname!,
               "dateOfBirth":dateOfBirth!,
               "email":email!,
               "uid":uid!
            ]
    }
    
    init(_ name: String, _ surname : String, _ dateOfBirth : String, _ email: String, _ password: String, _ uid:String) {
        self.name = name
        self.surname = surname
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.password = password
        self.uid = uid
    }
    init(_ snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String :String]{
            name = value["name"]
            surname = value["surname"]
            email = value["email"]
            dateOfBirth = value["dateOfBirth"]
        }
    }
    
    
}

//
//  Contact.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import Foundation

struct Contact {
    static var countObjects = 0
    
    let id: Int
    var name: String
    var surname: String
    var phone: Int
    var email: String
    
    init(name: String, surname: String, phone: Int, email: String) {
        Contact.countObjects += 1
        id = Contact.countObjects
        
        self.name = name
        self.surname = surname
        self.phone = phone
        self.email = email
    }
}

extension Contact {
    
    var fullName: String {
        return surname + " " + name
    }
}

extension Contact: Hashable {
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var hashValue: Int {
        return id
    }
}

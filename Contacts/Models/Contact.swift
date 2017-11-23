//
//  Contact.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

struct Contact {
    static private var countObjects = 0
    
    let id: Int
    var name: String
    var surname: String
    var phone: String?
    var email: String?
    var image: UIImage?
    
    init(name: String, surname: String, phone: String?, email: String?, image: UIImage? = nil) {
        Contact.countObjects += 1
        id = Contact.countObjects
        
        self.name = name
        self.surname = surname
        self.phone = phone
        self.email = email
        self.image = image
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

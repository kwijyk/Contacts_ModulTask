//
//  DataManager.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import Foundation

final class DataManager {
    
    static let instance = DataManager()
    
    var contacts: [Contact] = []
    var currentContact: Contact?
    
    private init() {
        contacts.append(Contact(name: "Oleg", surname: "Dynnikov", phone: 3703166, email: "oleg@mail.com"))
        contacts.append(Contact(name: "Sergey", surname: "Gaponov", phone: 7701241, email: "sergey@mail.com"))
    }
    
    func addContact(name: String, surname: String, phone: Int, email: String) {
        contacts.append(Contact(name: name, surname: surname, phone: phone, email: email))
    }
    
    func editContact(contact: Contact) {
    
        for (index, item) in contacts.enumerated() where item.id == contact.id {
                contacts.remove(at: index)
                contacts.append(contact)
        }
    }
}

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

    private init() {
        
        contacts.append(Contact(name: "Alexey", surname: "Skutarenko", phone: 380661234434, email: "alex@mail.com"))
        contacts.append(Contact(name: "Sergey", surname: "Gaponov", phone: 380661339998, email: "sergey@mail.com"))
        contacts.append(Contact(name: "Oleg", surname: "Dynnikov", phone: 380933422256, email: "oleg@mail.com"))
        contacts.append(Contact(name: "Vladimer", surname: "Doronov", phone: 380963455656, email: "vlad@mail.com"))
        contacts.append(Contact(name: "Lesy", surname: "Samohina", phone: 380683455656, email: "lesy@mail.com"))
    }
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func editContact(_ contact: Contact) {
        for (index, item) in contacts.enumerated() where item.id == contact.id {
            contacts[index] = contact
        }
    }
    
    func deleteContact(_ contact: Contact) {
        for (index, item) in contacts.enumerated() where item.id == contact.id {
            contacts.remove(at: index)
        }
    }
}

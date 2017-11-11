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
    
    private var contacts: [Contact] = []

    private init() {
        contacts.append(Contact(name: "Oleg", surname: "Dynnikov", phone: 3703166, email: "oleg@mail.com"))
        contacts.append(Contact(name: "Sergey", surname: "Gaponov", phone: 7701241, email: "sergey@mail.com"))
    }
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
    }
    
    func editContact(_ contact: Contact) {
        for (index, item) in contacts.enumerated() where item.id == contact.id {
                contacts[index] = contact
        }
    }
    
    func generateSection(containedString serchText: String?) -> ([Character], [Character : [Contact]]) {
        
        var sectionsOfContacts: [Character : [Contact]] = [:]
        var contactsKeys: [Character] = []
        
        for objContact in contacts {
            if let optSerchText = serchText, !optSerchText.isEmpty,
                objContact.fullName.range(of: optSerchText) == nil {
                continue
            } else {
                guard let firstLetter = objContact.fullName.first else { continue }
                var newContacts = sectionsOfContacts[firstLetter] ?? []
                newContacts.append(objContact)
                sectionsOfContacts[firstLetter] = newContacts
            }
        }
        
        for objsContacts in sectionsOfContacts {
            let sortCntacts = objsContacts.value.sorted {$0.fullName < $1.fullName}
            sectionsOfContacts[objsContacts.key] = sortCntacts
        }
        
        contactsKeys = Array(sectionsOfContacts.keys)
        contactsKeys.sort()
        
        return (contactsKeys, sectionsOfContacts)
    }
}

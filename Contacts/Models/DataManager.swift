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
    
    init() {
       
        contacts.append(Contact(name: "Oleg", surname: "Dynnikov"))
        contacts.append(Contact(name: "Sergey", surname: "Gaponov"))
    }
}

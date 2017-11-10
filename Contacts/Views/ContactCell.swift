//
//  ContactCell.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        selectionStyle = .none
    }
    
    func updateContacts(name: String, surname: String) {
        
        nameLabel.text = name
        surnameLabel.text = surname
    }

}

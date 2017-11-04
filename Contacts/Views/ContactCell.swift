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
    
    var dataContact: Contact? = DataManager.instance.currentContact
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        nameLabel.text = dataContact?.name
        surnameLabel.text = dataContact?.surname
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

}

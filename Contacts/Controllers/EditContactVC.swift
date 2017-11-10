//
//  EditContactVC.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

class EditContactVC: UIViewController {

    @IBOutlet private weak var contactImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    var contact: Contact? = DataManager.instance.currentContact
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
        
        nameTextField.text = contact?.name
        surnameTextField.text = contact?.surname
    }
    
    // MARK: - Action bar button
    @objc func actionSave(sender: UIBarButtonItem) {
        
        contact?.name = nameTextField.text ?? ""
        contact?.surname = surnameTextField.text ?? ""
        
        DataManager.instance.editContact(contact: contact!)
    
    }
    
}

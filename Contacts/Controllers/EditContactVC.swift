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
    
    weak var delegate: EditContactDelegate?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
        
        nameTextField.text = contact?.name
        surnameTextField.text = contact?.surname
    }
    
    // MARK: - Action bar button
    @objc private func actionSave(sender: UIBarButtonItem) {
    
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let email = emailTextField.text else {
                
                showAlert(isSuccess: false)
                return
        }
        
        guard let optPhoneString = phoneTextField.text,
              let optPhoneInt = Int(optPhoneString) else {
                
                showAlert(isSuccess: false)
                return
        }
        
        if var optContact = contact {
            optContact.name = name
            optContact.surname = surname
            optContact.email = email
            optContact.phone = optPhoneInt
            DataManager.instance.editContact(optContact)
        } else {
            let contact = Contact(name: name, surname: surname, phone: optPhoneInt, email: email)
            DataManager.instance.addContact(contact)
        }
       
        delegate?.didSaveContact()
        showAlert(isSuccess: true)
    }
    
    // MARK: - Privat methods
    private func showAlert(isSuccess: Bool) {
        let message = isSuccess ? "Contact's data success saved" :
                                  "Fields are not correctly filled"
        
        guard let font = UIFont(name: "AmericanTypewriter", size: 20.0) else { return }
        
        let attributeString: [NSAttributedStringKey : Any] =
            [.foregroundColor: isSuccess ? UIColor.blue : UIColor.red,
                        .font: font]
        let attributeMessage = NSAttributedString(string: message, attributes: attributeString)
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

        alert.setValue(attributeMessage, forKey: "attributedMessage")
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

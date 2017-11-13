//
//  EditContactVC.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

class EditContactVC: UIViewController {

    @IBOutlet private weak var containerButtonImageView: UIView!
    @IBOutlet private weak var contactImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    weak var delegate: EditContactDelegate?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
    
        nameTextField.text = contact?.name
        surnameTextField.text = contact?.surname
        
        var stringPhone: String?
        if let intPhone = contact?.phone {
            stringPhone = String(intPhone)
        }
        phoneTextField.text = stringPhone
        
        emailTextField.text = contact?.email
        let image = contact?.image ?? #imageLiteral(resourceName: "placeHolder")
        contactImage.image = image
        contactImage.layer.cornerRadius = contactImage.frame.size.width / 2
    }
    
    // MARK: - Action bar button
    @objc private func actionSave(sender: UIBarButtonItem) {
    
        guard let name = nameTextField.text,
              let surname = surnameTextField.text else {
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
            optContact.email = emailTextField.text
            optContact.phone = optPhoneInt
            optContact.image = contactImage.image
            DataManager.instance.editContact(optContact)
        } else {
            let contact = Contact(name: name, surname: surname, phone: optPhoneInt, email: emailTextField.text, image: contactImage.image)
            DataManager.instance.addContact(contact)
        }
       
        delegate?.didSaveContact()
        showAlert(isSuccess: true)
    }
    
    // MARK: - Keyboard Notifications
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        UIView.animate(withDuration: 1.0) {
            self.containerButtonImageView.isHidden = true
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1.0) {
            self.containerButtonImageView.isHidden = false
        }
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

extension EditContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Actions
    @IBAction private func actionImagePickerButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        let alertController = UIAlertController(title: "Photo from:", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alertController.addAction(cameraAction)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            contactImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

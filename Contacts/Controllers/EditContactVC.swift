//
//  EditContactVC.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

class EditContactVC: UIViewController {

    @IBOutlet private weak var lcTopStackView: NSLayoutConstraint!
    @IBOutlet private weak var imageStackView: UIStackView!
    @IBOutlet private weak var containerButtonImageView: UIView!
    @IBOutlet private weak var contactImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    var arrayTextFieldOutlets: [UITextField] = []
    let notificationCenter = NotificationCenter.default
    weak var delegate: EditContactDelegate?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        arrayTextFieldOutlets = [nameTextField, surnameTextField, phoneTextField, emailTextField]
        
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
        containerButtonImageView.layer.cornerRadius = containerButtonImageView.frame.size.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        notificationCenter.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)

        notificationCenter.addObserver(self,
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Action barButton
    @objc private func actionSave(sender: UIBarButtonItem) {
    
        guard let name = nameTextField.text, name != "",
              let surname = surnameTextField.text, surname != "" else {
                showAlert(isSuccess: false)
                return
        }
        
        var optPhoneInt: Int?
        if let optPhoneString = phoneTextField.text {
            optPhoneInt = Int(optPhoneString)
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
        
        let originalTransform = self.containerButtonImageView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.05, y: 0.05)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: 0.0, y: 200.0)
        lcTopStackView.constant = 10
        
        UIView.animate(withDuration: 1.0) {
            self.containerButtonImageView.transform = scaledAndTranslatedTransform
            self.imageStackView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
         lcTopStackView.constant = 60
        UIView.animate(withDuration: 1.0) {
            
            self.containerButtonImageView.transform = .identity
            self.imageStackView.isHidden = false
            self.view.layoutIfNeeded()
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditContactVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

// MARK: - UITextFieldDelegate
extension EditContactVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setup()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let indexTxtFld = arrayTextFieldOutlets.index(of: textField) else { return false }
        
        if arrayTextFieldOutlets[indexTxtFld] != arrayTextFieldOutlets.last {
            arrayTextFieldOutlets[indexTxtFld + 1].becomeFirstResponder()
        } else {
            arrayTextFieldOutlets[indexTxtFld].resignFirstResponder()
        }
        return true
    }
}

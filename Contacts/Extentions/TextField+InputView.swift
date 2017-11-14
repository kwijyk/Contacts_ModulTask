//
//  TextField+InputView.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/14/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setup() {
        let bounds = UIScreen.main.bounds
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 0))
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneKeyboard))
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.blue], for: .normal)
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    
    @objc private func doneKeyboard() {
        self.resignFirstResponder()
    }
}

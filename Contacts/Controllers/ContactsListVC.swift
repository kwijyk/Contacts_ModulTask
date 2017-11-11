//
//  ContactsListVC.swift
//  Contacts
//
//  Created by Sergey Gaponov on 11/4/17.
//  Copyright © 2017 Sergey Gaponov. All rights reserved.
//

import UIKit

class ContactsListVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var sectionOfContacts: [Character : [Contact]] = [:]
    var contactsKeys: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
       
        (contactsKeys, sectionOfContacts) = DataManager.instance.generateSection(containedString: searchBar.text)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let addEditVC = segue.destination as? EditContactVC else { return }
        addEditVC.delegate = self

        if segue.identifier == "ShowAddContact" {
            addEditVC.title = "Add contact"
        } else if segue.identifier == "ShowEditContact" {
            addEditVC.title = "Edit contact"
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else { return }
            
            let contact = getContact(for: indexPath)
            
            addEditVC.contact = contact
        }
    }
    
    // MARK: - Privat methods
    private func getContact(for indexPath: IndexPath) -> Contact? {
        let key = contactsKeys[indexPath.section]
        let contactForSection = sectionOfContacts[key]
        return contactForSection?[indexPath.row]
    }
}

extension ContactsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsKeys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(contactsKeys[section])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let optContactsKey = contactsKeys[section], optContacts = sectionOfContacts[optContactsKey] ?? []
        return optContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { fatalError("Error: Cell is not created")
            
        }
        
        guard let contact = getContact(for: indexPath) else {
            fatalError("Error: Contact has wrong index path")
        }
        cell.updateContacts(name: contact.name, surname: contact.surname)
        
        return cell
    }
}

extension ContactsListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ContactsListVC: EditContactDelegate {
    
    func didSaveContact() {
        (contactsKeys, sectionOfContacts) = DataManager.instance.generateSection(containedString: searchBar.text)
        print(contactsKeys)
        tableView.reloadData()
    }
}

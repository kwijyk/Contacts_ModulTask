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
    
    var dataContacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        dataContacts = DataManager.instance.contacts
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
            
            let contact = dataContacts[indexPath.row]
            addEditVC.contact = contact
        }
    }
}

extension ContactsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { return UITableViewCell() }
        
        let contact = dataContacts[indexPath.row]
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
        dataContacts = DataManager.instance.contacts
        tableView.reloadData()
    }
}

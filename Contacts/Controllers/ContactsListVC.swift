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
    
    let dataContacts: [Contact] = DataManager.instance.contacts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let addEditVC = segue.destination as? EditContactVC else { return }
        
        if segue.identifier == "ShowAddContact" {
            addEditVC.title = "Add contact"
        } else if segue.identifier == "ShowEditContact" {
             addEditVC.title = "Edit contact"
            
            guard let cell = sender as? UITableViewCell,
                  let indexPath = tableView.indexPath(for: cell) else { return }
            
            let contact = dataContacts[indexPath.row % 2]
            DataManager.instance.currentContact = contact
        }
    }
}

extension ContactsListVC: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { return UITableViewCell() }
        
        let contact = DataManager.instance.contacts[indexPath.row % 2]
        cell.updateContacts(name: contact.name, surname: contact.surname)
        
        return cell
    }
    
    // MARK: - UISearchBarDelegate
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

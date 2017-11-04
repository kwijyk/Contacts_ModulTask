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

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//       let indexPath = tableView.indexPath(for: sender)
        
    }
    
}

extension ContactsListVC: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataContacts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        DataManager.instance.currentContact = dataContacts[indexPath.row]
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            fatalError("Do not create cell")
        }
        
        return cell
    }
}

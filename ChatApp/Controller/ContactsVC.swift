//
//  ContactsVC.swift
//  ChatApp
//
//  Created by Kanishk Verma on 16/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController,UITableViewDelegate,UITableViewDataSource, FetchData {

    @IBOutlet weak var tableView: UITableView!
    
    private let CHAT_SEGURE = "ChatSegue"
    private var contacts = [Contact]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DBProvider.instance.delegate = self
        DBProvider.instance.getContacts()
    }
    
    func dataRecieved(contacts: [Contact]) {
        self.contacts = contacts;
        
        //Get the name
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CHAT_SEGURE, sender: nil)
    }
    
    
    

    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        if AuthProvider.instance.logOut() {
        dismiss(animated: true, completion: nil)
        }
    }
    
}





















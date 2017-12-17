//
//  ContactsVC.swift
//  ChatApp
//
//  Created by Kanishk Verma on 16/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var contacts = [Contact]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
        
    }
    
    
    

   
    @IBAction func logoutBtnPressed(_ sender: Any) {
        if AuthProvider.instance.logOut() {
        dismiss(animated: true, completion: nil)
        }
    }
    
}





















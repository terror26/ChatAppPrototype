//
//  DBProvider.swift
//  ChatApp
//
//  Created by Kanishk Verma on 17/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation
import Firebase

protocol FetchData:class {
    func dataRecieved(contacts:[Contact]);
}

class DBProvider {
    private static let  _instance = DBProvider()
    //To create a singleton instance and precentind other classes to intialise the object of this class
    private init() {}
    
    static var instance:DBProvider {
        return _instance
    }
    
    weak var delegate:FetchData?;
    
    var ref :DatabaseReference {
        return Database.database().reference();
    }
    
    var contactsRef:DatabaseReference {
        return ref.child(Constants.CONTACTS)
    }
    
    var messagesRef:DatabaseReference {
        return ref.child(Constants.MESSAGES)
    }
    
    var mediaMessagesRed:DatabaseReference {
        return ref.child(Constants.MEDIA_MESSAGES)
    }
    
    var storageRef:StorageReference {
        return Storage.storage().reference(forURL: Constants.STORAGE_REF_URL)
    }
    
    var imageStorageRef:StorageReference {
        return storageRef.child(Constants.IMAGE_STORAGE)
    }
    
    var videoStorageRef:StorageReference {
        return storageRef.child(Constants.VIDEO_STORAGE)
    }
    
    func saveUser(withID:String, email:String, password:String) {
        let data :Dictionary<String,Any> = [
            Constants.EMAI: email,
            Constants.PASSWORD: password
            ]
        contactsRef.child(withID).setValue(data)

    }//Save user
    
    
    func getContacts() {
    
        
        contactsRef.observeSingleEvent(of: .value) { (snapshot) in
        
            var contacts = [Contact]();
            if let myContacts = snapshot.value as?NSDictionary {
                
                for (key,value) in myContacts {
                
                    if let contactData = value as? NSDictionary {
                    
                        if let email = contactData[Constants.EMAI] as?String {
                        
                            let id = key as! String
                            let newContact = Contact(id: id, name: email)
                            contacts.append(newContact)
                        }
                    }
                }
            }
        self.delegate?.dataRecieved(contacts: contacts)
        }
    }//getContacts
    
} // class
























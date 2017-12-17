//
//  DBProvider.swift
//  ChatApp
//
//  Created by Kanishk Verma on 17/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation
import Firebase

class DBProvider {
    private static let  _instance = DBProvider()
    //To create a singleton instance and precentind other classes to intialise the object of this class
    private init() {}
    
    static var instance:DBProvider {
        return _instance
    }
    
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
        
    }
    
    
} // class
























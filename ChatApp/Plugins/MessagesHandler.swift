//
//  MessagesHandler.swift
//  ChatApp
//
//  Created by Kanishk Verma on 20/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

protocol MessageRecivedDelegate:class {
    func messageRecieved(senderID:String , senderName:String, text:String);
}

class MessagesHandler {
    
    private static let _instance = MessagesHandler();
    private init() {}
    
    weak var delegate: MessageRecivedDelegate?;
    
    static var instance: MessagesHandler {
        return _instance;
    }
    
    func sendMessage(senderID:String, senderName: String, text:String) {
        
        let data : Dictionary<String,AnyObject> = [ Constants.SENDER_ID:senderID as AnyObject, Constants.SENDER_NAME:senderName as AnyObject, Constants.TEXT : text as AnyObject ]
        
        DBProvider.instance.messagesRef.childByAutoId().setValue(data)
    }
    
    func sendMediaMessage(senderID:String, senderName:String ,url: String) {
        let data :Dictionary<String,Any> = [Constants.SENDER_ID : senderID, Constants.SENDER_NAME: senderName, Constants.URL : url]
        DBProvider.instance.mediaMessagesRef.childByAutoId().setValue(data);
        
        
    }
    
    
    func sendMedia(image: Data?, video: URL?, senderID: String, senderName :String) {
        
        if image != nil {
            
            DBProvider.instance.imageStorageRef.child(senderID + "\(NSUUID().uuidString).jpg").putData(image!, metadata: nil)
            { (metadata: StorageMetadata?, err:Error?) in
                
                if err != nil {
                
                    print(" Error there was a problem uploading a image ")
                
                } else {
                 
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url: String(describing: metadata?.downloadURL()!))
                
                }
            }
            
        } else {
            
            DBProvider.instance.videoStorageRef.child(senderID + "\(NSUUID().uuidString)").putFile(from: video!, metadata: nil) { (metadata:StorageMetadata? , error:Error?) in
                
                if error != nil {
                    
                    print("The uploading of the video has failed")
                
                } else {
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url: String(describing : metadata?.downloadURL()!) )
                }
            }
            
        }
    }
    
    
    func observeMessage() {
        DBProvider.instance.messagesRef.observe(.childAdded) { (snapshot) in
            
            if let data = snapshot.value as?NSDictionary {
                if let senderName = data[Constants.SENDER_NAME] as?String {
                    if let senderID = data[Constants.SENDER_ID] as? String {
                        if let text = data[Constants.TEXT] as?String {
                            
                            self.delegate?.messageRecieved(senderID: senderID, senderName:senderName ,text: text)
                            
                        }
                    }
                }
                
                
            }
        }
    }
    
    
} // class

//print a alert to inform the user that image was not uploaded to the storage in sendMedia func
//same asignment for the video uploading too


































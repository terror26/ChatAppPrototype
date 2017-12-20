//
//  MessagesHandler.swift
//  ChatApp
//
//  Created by Kanishk Verma on 20/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation

class MessagesHandler {
    
    private static let _instance = MessagesHandler();
    private init() {}
    
    static var instance: MessagesHandler {
        return _instance;
    }
    
    func sendMessage(senderID:String, senderName: String, text:String) {
        
        let data : Dictionary<String,AnyObject> = [ Constants.SENDER_ID:senderID as AnyObject, Constants.SENDER_NAME:senderName as AnyObject, Constants.TEXT : text as AnyObject ]
        
        DBProvider.instance.messagesRef.childByAutoId().setValue(data)
        
    }
    
    
} // class




































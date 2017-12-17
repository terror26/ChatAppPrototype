//
//  Contact.swift
//  ChatApp
//
//  Created by Kanishk Verma on 17/12/17.
//  Copyright © 2017 Kanishk Verma. All rights reserved.
//

import Foundation

class Contact {
    
    private var _name = ""
    private var _id = ""
    
    init(id:String , name:String) {
        _id = id
        _name = name
    }
    
    var name:String {
        return _name
    }
    
    var id:String {
        return _id
    }
    
}

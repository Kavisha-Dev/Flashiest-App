//
//  File.swift
//  Flashiest App
//
//  Created by Kavisha on 07/08/19.
//  Copyright © 2019 SoKa. All rights reserved.
//

import Foundation

class Message {
    
    var sender : String = ""
    var senderMessage : String = "";
    
    init(email : String, message : String) {
        sender = email;
        senderMessage = message;
    }
    
}

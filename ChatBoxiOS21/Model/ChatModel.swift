//
//  ChatModel.swift
//  ChatBoxiOS21
//
//  Created by Ivan Ramirez on 9/10/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
// KEY and Value
//The uuid is the key and the value is a ditionary (which is our object)
//let dictionary = [String:[String:String]]()
// the second part is another dictionary that is nested

struct Chat {
    // make a key
    //private protects these keys so they can't be reached outsdie of this class
    private let messageKey = "message"
    private let uuidKey = "uuid"
    
    let message: String
    let uuid: UUID
    
    //This is for creating
    init(message: String, uuid: UUID = UUID()) {
        self.message = message
        self.uuid = uuid
    }
    // this is for getting ** *** **
    // we need a dictionary and need to define it, with identifier
    init?(dictionary: [String: Any], identifier: String) {
        guard let message = dictionary[messageKey] as? String,
            let uuid = UUID(uuidString: identifier) else {return nil}
        
        self.message = message
        self.uuid = uuid
    }
    // two things that will get this to Firebase
    
    // the code below: this wil turn our object into a dictionary so we can store it to firebase
    
    var dictionaryRep: [String: Any] {
        
        // this is going to take our object above and turn it into a dic format in order to put in into fire base. and create our nodes and stuff
        //This is a computer poperty. will compute our object  to a dic
        let dictionary = [
            messageKey : message,
            uuidKey : uuid.uuidString
        ]
        return dictionary
    }
    // turn it into data first
    
    var jsonData: Data? {
        // we just cant send a dictionary across the web. We have to turn it into data first
        // pretty printed makes it more readable
        return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted)
    }
}

















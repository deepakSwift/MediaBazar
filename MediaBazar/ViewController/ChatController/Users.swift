//
//  User.swift
//  TenderApp
//
//  Created by Saurabh Chandra Bose on 31/10/19.
//  Copyright © 2019 Abhinav Saini. All rights reserved.
//

import UIKit

class Users: NSObject {
    var senderID: String?
    var senderImage: String?
    var senderFirstName: String?
    var senderMiddleName: String?
    var senderLastName: String?
    var senderUserType: String?
    
    var receiverID: String?
    var receiverImage: String?
    var receiverFirstName: String?
    var receiverMiddleName: String?
    var receiverLastName: String?
    var receiverUserType: String?
    
    var chatID: String?

    
    init(dictionary: [String: AnyObject]) {
        self.senderID = dictionary["senderID"] as? String
        self.senderImage = dictionary["senderImage"] as? String
        self.senderFirstName = dictionary["senderFirstName"] as? String
        self.senderMiddleName = dictionary["senderMiddleName"] as? String
        self.senderLastName = dictionary["senderLastName"] as? String
        self.senderUserType = dictionary["senderUserType"] as? String
        
        self.receiverID = dictionary["receiverID"] as? String
        self.receiverImage = dictionary["receiverImage"] as? String
        self.receiverFirstName = dictionary["receiverFirstName"] as? String
        self.receiverMiddleName = dictionary["receiverMiddleName"] as? String
        self.receiverLastName = dictionary["receiverLastName"] as? String
        self.receiverUserType = dictionary["receiverUserType"] as? String
        
        self.chatID = dictionary["chatID"] as? String
    }
    
    override var description: String {
        let seperator1 = "------------------\n\n"
        
        let details = "senderID - \(senderID)\nsenderImage - \(senderImage)\nsenderFirstName - \(senderFirstName)\nsenderMiddleName - \(senderMiddleName)\nsenderLastName - \(senderLastName)\nsenderUserType - \(senderUserType)\nreceiverID - \(receiverID)\nreceiverImage - \(receiverImage)\nreceiverFirstName - \(receiverFirstName)\nreceiverMiddleName - \(receiverMiddleName)\nreceiverLastName - \(receiverLastName)\nreceiverUserType - \(receiverUserType)\nchatID - \(chatID)\n"
        
        let seperator2 = "\n\n================"
        return seperator1 + details + seperator2
    }
}

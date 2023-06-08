//
//  User.swift
//  TenderApp
//
//  Created by Saurabh Chandra Bose on 31/10/19.
//  Copyright © 2019 Abhinav Saini. All rights reserved.
//

import UIKit

class Users_Group: NSObject {
    var senderID: String?
    var senderImage: String?
    var senderFirstName: String?
    var senderMiddleName: String?
    var senderLastName: String?
    var senderUserType: String?
    
    var chatID: String?
    var groupImage: String?
    var groupName: String?
    
    var members = [GroupMembers]()
    
    init(dictionary: [String: AnyObject]) {
        self.senderID = dictionary["senderID"] as? String
        self.senderImage = dictionary["senderImage"] as? String
        self.senderFirstName = dictionary["senderFirstName"] as? String
        self.senderMiddleName = dictionary["senderMiddleName"] as? String
        self.senderLastName = dictionary["senderLastName"] as? String
        self.senderUserType = dictionary["senderUserType"] as? String
        
        self.chatID = dictionary["chatID"] as? String
        self.groupImage = dictionary["groupImage"] as? String
        self.groupName = dictionary["groupName"] as? String
        
        if let membersArray = dictionary["members"] as? [[String : AnyObject]] {
            for member in membersArray {
                let tempMember = GroupMembers(dictionary: member)
                print(tempMember.description)
                self.members.append(tempMember)
            }
        }
        
    }
    
    override var description: String {
        let seperator1 = "------------------\n\n"
        
        let details = "senderID - \(senderID)\nsenderImage - \(senderImage)\nsenderFirstName - \(senderFirstName)\nsenderMiddleName - \(senderMiddleName)\nsenderLastName - \(senderLastName)\nsenderUserType - \(senderUserType)\nchatID - \(chatID)\ngroupImage - \(groupImage)\ngroupName - \(groupName)\n"
        
        let seperator2 = "\n\n================"
        return seperator1 + details + seperator2
    }
}


class GroupMembers: NSObject {
    var receiverID: String?
    var receiverImage: String?
    var receiverFirstName: String?
    var receiverMiddleName: String?
    var receiverLastName: String?
    var receiverUserType: String?
    
    init(dictionary: [String: AnyObject]) {
        self.receiverID = dictionary["receiverID"] as? String
        self.receiverImage = dictionary["receiverImage"] as? String
        self.receiverFirstName = dictionary["receiverFirstName"] as? String
        self.receiverMiddleName = dictionary["receiverMiddleName"] as? String
        self.receiverLastName = dictionary["receiverLastName"] as? String
        self.receiverUserType = dictionary["receiverUserType"] as? String
    }
    
    override var description: String {
        let seperator1 = "------------------\n\n"
        
        let details = "receiverID - \(receiverID)\nreceiverImage - \(receiverImage)\nreceiverFirstName - \(receiverFirstName)\nreceiverMiddleName - \(receiverMiddleName)\nreceiverLastName - \(receiverLastName)\nreceiverUserType - \(receiverUserType)\n"
        
        let seperator2 = "\n\n================"
        return seperator1 + details + seperator2
    }
}

//
//  Message.swift
//  TenderApp
//
//  Created by Saurabh Chandra Bose on 31/10/19.
//  Copyright © 2019 Abhinav Saini. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var message: String?
    var timestamp: NSNumber?
    var fromId: String?
    var messageType: String?
    var toId: String?
    var mediaUrl: String?
    
    var imageUrl: String?
    var videoUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    
    init(dictionary: [String: Any]) {
        self.message = dictionary["message"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.fromId = dictionary["fromId"] as? String
        self.messageType = dictionary["messageType"] as? String
        self.toId = dictionary["toId"] as? String
        self.mediaUrl = dictionary["mediaUrl"] as? String
        
        self.imageUrl = dictionary["imageUrl"] as? String
        self.videoUrl = dictionary["videoUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? NSNumber
        self.imageHeight = dictionary["imageHeight"] as? NSNumber
    }
    
    func chatPartnerId(loginUser: String) -> String? {
        //        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
        return fromId == loginUser ? toId : fromId
    }
    
}


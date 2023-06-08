//
//  MediaHouseParser.swift
//  MediaBazar
//
//  Created by deepak Kumar on 01/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON

class mediaStoryParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    
    var result = [MediaStroyDocsModel]()
       
    var storyResult = MediaStroyModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        
        if let result = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
            for item in result {
                let temp = MediaStroyDocsModel(dict: item)
                self.result.append(temp)
            }
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = MediaStroyModel(dictionary: usrdict)
        }
        super.init()
    }
}



class AddfavStoryParsar : NSObject{
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = AddTofavoriteModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.result = AddTofavoriteModel(dictionary: usrdict)
        }
    }
}

class CompanyInfoParser : NSObject {
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = CompanyInfoModel()
    
    override init() {
        super.init()
    }
    init(json: JSON) {
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let socialDict = json[KResult].dictionaryObject as [String:AnyObject]?{
            self.result = CompanyInfoModel(dictionary: socialDict)
        }
        super.init()
    }
}


class CompanyProfileParser : NSObject {
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = CompanyProfileModel()
    
    override init() {
        super.init()
    }
    init(json: JSON) {
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let socialDict = json[KResult].dictionaryObject as [String:AnyObject]?{
            self.result = CompanyProfileModel(dictionary: socialDict)
        }
        super.init()
    }
}

//------Favorite Parser
class FavoriteListParsar : NSObject{
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
       
    var storyResult = FavoriteDocModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = FavoriteDocModel(dictionary: usrdict)
        }
        super.init()
    }
}

//------AssignmentParser------
class AssignmnetParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = AssignmentListModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = AssignmentListModel(dictionary: usrdict)
        }
        super.init()
    }
}


//------PostAssignmentParser------
class PostAssignmentParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var storyResult = PostAssignmentModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = PostAssignmentModel(dict: usrdict)
        }
        super.init()
    }
}

//------JournalistAssignmentParser------
class JournalistAssignmentParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = AssignmentListModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = AssignmentListModel(dictionary: usrdict)
        }
        super.init()
    }
}

//------EveltListParser------
class EveltListParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = EventListModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = EventListModel(dictionary: usrdict)
        }
        super.init()
    }
}

//------PurchaseListParser------
class PurchaseListParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = [PurchaseDetailsModel]()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
                
        if let listArray = json[kstoryList].arrayObject as? Array<Dictionary<String,AnyObject>> {
            self.storyResult.removeAll()
            for item in listArray {
                let user = PurchaseDetailsModel(dict: item)
                self.storyResult.append(user)
            }
        }

        super.init()
    }
}

//------GetEventStatusParser------
class GetEventStatusParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = PurchaseDetailsModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = PurchaseDetailsModel(dict: usrdict)
        }

                
//        if let listArray = json[kstoryList].arrayObject as? Array<Dictionary<String,AnyObject>> {
//            self.storyResult.removeAll()
//            for item in listArray {
//                let user = PurchaseDetailsModel(dict: item)
//                self.storyResult.append(user)
//            }
//        }

        super.init()
    }
}




//------CreateJobParser------
class CreateJobParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = CreatJobModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.result = CreatJobModel(dict: usrdict)
        }
        super.init()
    }
}


//------GetJobListParser------
class GetJobListParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var result = GetJobModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.result = GetJobModel(dictionary: usrdict)
        }
        super.init()
    }
}


    //-------NotificationParser
    class NotificationParser : NSObject{
        let KResponseCode = "responseCode"
        let kResponseMessage = "responseMessage"
        let kError = "error"
        let KResult = "result"
        
        var responseCode : Int = 0
        var responseMessage : String = ""
        var result = Array<NotificationList>()
        
        override init() {
            super.init()
        }
        init(json: JSON) {
            if let responseCode = json[KResponseCode].int as Int?{
                self.responseCode = responseCode
            }
            if let message = json[kResponseMessage].string as String?{
                self.responseMessage = message
            }
            if let listArray = json[KResult].arrayObject as? Array<Dictionary<String,AnyObject>>{
                for item in listArray{
                    let notificationData = NotificationList(dict: item)
                    self.result.append(notificationData)
                }
            }
            super.init()
        }
    }


//------TranslateParser------
class TranslateParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = TranslateModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.result = TranslateModel(dict: usrdict)
        }
        super.init()
    }
}

//------JournalistAssignmentParser------
class TranslateListParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var result = TranslateListModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.result = TranslateListModel(dictionary: usrdict)
        }
        super.init()
    }
}


//------JournalistReplyParser------
class JournalistReplyParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = GetJornalistReplyModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = GetJornalistReplyModel(dictionary: usrdict)
        }
        super.init()
    }
}

//------JournalistReplyParser------
class ChatListParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    var storyResult = GetJornalistReplyModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = GetJornalistReplyModel(dictionary: usrdict)
        }
        super.init()
    }
}


class EthicMemberEnquiryParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    
    
    //var result = [MediaStroyDocsModel]()
       
    var storyResult = MediaStroyModel()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        
//        if let result = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
//            for item in result {
//                let temp = MediaStroyDocsModel(dict: item)
//                self.result.append(temp)
//            }
//        }
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = MediaStroyModel(dictionary: usrdict)
        }
        super.init()
    }
}

//
//  LoginParsar.swift
//  MediaBazar
//
//  Created by deepak Kumar on 04/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON


class UserParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = User()
    var resultPersonalInfo = SocialMedialinkModel()
    
    
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
            self.result = User(dict: usrdict)
        }
        if let socialDict = json[KResult].dictionaryObject as [String:AnyObject]?{
            self.resultPersonalInfo = SocialMedialinkModel(dictionary: socialDict)
        }
        super.init()
    }
}
//-------------languageParser-------------

class languageParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [LanguageList]()
    
    override init(){
        super.init()
    }
    init(json: JSON){
        if let responseCode = json[KResponseCode].int as Int?{
            self.responseCode = responseCode
        }
        if let message = json[kResponseMessage].string as String?{
            self.responseMessage = message
        }
        if let listArray = json[KResult].arrayObject as? Array<Dictionary<String,AnyObject>>{
            for item in listArray{
                //                self.result.removeAll()
                let user = LanguageList(dictionary: item)
                self.result.append(user)
            }
        }
    }
}

//----------DesignationParser-----------

class DesignationParser: NSObject {
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [DesignationModel]()
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        
        if let message = json[kResponseMessage].string as String? {
            self.responseMessage = message
        }
        if let result = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
            for item in result {
                let tempDesignation = DesignationModel(dictionary: item)
                self.result.append(tempDesignation)
            }
        }
    }
}

//----------SocialMediaLinkParser-----------

class SocialMediaLinkParser: NSObject{
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = SocialMedialinkModel()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.result = SocialMedialinkModel(dictionary: linkList)
        }
    }
}

//------------ benefitParser-----------

class BenefitParser: NSObject{
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = [BenefitModel]()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>>{
            for item in linkList{
                let tempBenef = BenefitModel(dictionary: item)
                self.result.append(tempBenef)
            }
        }
    }
}

//--------privious Parser-------------

class PreviousWorkParser: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = PreviousModel()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.result = PreviousModel(dictionary: linkList)
        }
    }
    
}
//--------category Parser-------------

class categoryParser: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = [CategoryModel]()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
            self.result.removeAll()
            for item in linkList {
                let tempCategory = CategoryModel(dictionary: item)
                self.result.append(tempCategory)
            }
        }
    }
}
//========StoryKeyword Parser=============

class StoryKeywordParser: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = [StoryKeywordModel]()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
            self.result.removeAll()
            for item in linkList {
                let tempCategory = StoryKeywordModel(dictionary: item)
                self.result.append(tempCategory)
            }
        }
    }
}
//========ProfessionalDetails Parser=============

class ProfessionalDetailParser: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = ProffesionalDetailModel()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
//        if let linkList = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
//            self.result.removeAll()
//            for item in linkList {
//                let tempCategory = ProffesionalDetailModel(dictionary: item)
//                self.result.append(tempCategory)
//            }
//        }
        if let linkList = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.result = ProffesionalDetailModel(dictionary: linkList)
        }

    }
}
//-----------JournalistProfile--------

class JournalistProfileParser: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = [ProffesionalDetailModel]()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let linkList = json[KResult].arrayObject as? Array<Dictionary<String, AnyObject>> {
        self.result.removeAll()
        for item in linkList {
            let tempCategory = ProffesionalDetailModel(dictionary: item)
            self.result.append(tempCategory)
        }
    }
  }
}
//-----------EnquiryParser--------



    class EnquiryParser: NSObject{
        let KResponseCode = "responseCode"
        let kResponseMessage = "responseMessage"
        let kError = "error"
        let KResult = "result"
        
        var responseCode : Int = 0
        var responseMessage : String = ""
        var error: String = ""
        var result = EnquiryModel()
        
        
        override init() {
            super.init()
        }
        
        init(json: JSON) {
            
            if let responseCode = json[KResponseCode].int as Int? {
                self.responseCode = responseCode
            }
            if let responseMessage = json[kResponseMessage].string as String?{
                self.responseMessage = responseMessage
            }
            if let linkList = json[KResult].dictionaryObject as [String: AnyObject]?{
                
                self.result = EnquiryModel(dictionary: linkList)
            }
        }
}


//----------downloadStory-----------

class downloadStoryParser: NSObject{
    
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var error: String = ""
    var result = StoryDownloadModal()
    
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        if let responseCode = json[KResponseCode].int as Int? {
            self.responseCode = responseCode
        }
        if let responseMessage = json[kResponseMessage].string as String?{
            self.responseMessage = responseMessage
        }
        if let storyUrl = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.result = StoryDownloadModal(dictionary: storyUrl)
        }
    }
}


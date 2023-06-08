//
//  ParserFile.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 18/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON


class storyParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = storyModal()
    var editResult = storyListModal()
    
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
            self.result = storyModal(dict: usrdict)
        }
        
        if let usrdict1 = json[KResult].dictionaryObject as [String: AnyObject]?{
            self.editResult = storyListModal(dict:usrdict1)
        }

        super.init()
    }
}


class profileParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = profileModal()
    
    
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
            self.result = profileModal(dict: usrdict)
        }
        super.init()
    }
}

class storyListParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    let kstoryList = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [storyListModal]()
    
    var storyResult = listStory()
    
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
                let temp = storyListModal(dict: item)
                self.result.append(temp)
            }
        }
        
        if let usrdict = json[kstoryList].dictionaryObject as [String: AnyObject]?{
            self.storyResult = listStory(dict: usrdict)
        }
        super.init()
    }
}



class storyNewListParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [listStory]()
    
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
                let temp = listStory(dict: item)
                self.result.append(temp)
            }
        }
        super.init()
    }
}

class earningParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var earningResult = earningModal()
    
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
            self.earningResult = earningModal(dict: usrdict)
        }
        super.init()
    }
}

class earningParsarByStoryId: NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var earningResult = earningModalByStoryID()
    
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
            self.earningResult = earningModalByStoryID(dict: usrdict)
        }
        super.init()
    }
}


class contentParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = contentModal()
    
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
            self.result = contentModal(dict: usrdict)
        }
        super.init()
    }
}

class inviteJournalistParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [invitejournalistListModdal]()
    
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
                let temp = invitejournalistListModdal(dict: item)
                self.result.append(temp)
            }
        }
        super.init()
    }
}
class newRequestParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = newRequestModal()
    
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
            self.result = newRequestModal(dict: usrdict)
        }
        super.init()
    }
}


class colloborationListParsar : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var storyResult = collobrationModal()
    
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
            self.storyResult = collobrationModal(dict: usrdict)
        }
        super.init()
    }
}


class membershipParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = paymentsModal()
    
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
            self.result = paymentsModal(dict: usrdict)
        }
        super.init()
    }
}

class faqParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [faqModal]()
    
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
                let temp = faqModal(dict: item)
                self.result.append(temp)
            }
        }
        super.init()
    }
}

class registrationFeeParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = [registrationFeePlansListModal]()
    
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
                let temp = registrationFeePlansListModal(dict: item)
                self.result.append(temp)
            }
        }
        super.init()
    }
}




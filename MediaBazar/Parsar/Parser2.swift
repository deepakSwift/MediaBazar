//
//  Parser2.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryParser : NSObject{
    let KResponseCode = "responseCode"
    let kResponseMessage = "responseMessage"
    let kError = "error"
    let KResult = "result"
    
    var responseCode : Int = 0
    var responseMessage : String = ""
    var result = Array<CountryList>()
    
    
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
                let countryData = CountryList(dict: item)
                self.result.append(countryData)
            }
        }
        super.init()
    }
}


//
//class StateParser : NSObject{
//    let KResponseCode = "responseCode"
//    let kResponseMessage = "responseMessage"
//    let kError = "error"
//    let KResult = "result"
//
//    var responseCode : Int = 0
//    var responseMessage : String = ""
//    var result = Array<StateList>()
//
//    override init() {
//        super.init()
//    }
//    init(json: JSON) {
//        if let responseCode = json[KResponseCode].int as Int?{
//            self.responseCode = responseCode
//        }
//        if let message = json[kResponseMessage].string as String?{
//            self.responseMessage = message
//        }
//        if let listArray = json[KResult].arrayObject as? Array<Dictionary<String,AnyObject>>{
//            for item in listArray{
//                let stateData = StateList(dict: item)
//                self.result.append(stateData)
//            }
//        }
//        super.init()
//    }
//}


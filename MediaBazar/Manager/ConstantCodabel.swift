//
//  Constants.swift
//  Batvard
//
//  Created by Vikas on 30/05/19.
//  Copyright © 2019 Mobilecoderz. All rights reserved.
//


import Foundation
import UIKit

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

struct Constants {
    static let userDefaults  = UserDefaults.standard
    static let sharedApplication = UIApplication.shared
    static let sharedAppDelegate = sharedApplication.delegate as! AppDelegate
    static let sharedWindow = sharedApplication.keyWindow!
    static let screen = UIScreen.main
    static let fileManager = FileManager.default
    static let userListPlaceholder = UIImage(named: "userListPlaceholder")
    
    
    struct Color {
        static let appDefaultRed = UIColor(named: "#9E3635")
        static let appDefaultBlack1 = UIColor(named: "#000000")
        static let appDefaultLightGray = UIColor(named: "#6C6B6B")
        static let appDefaultGreen = UIColor(named: "#3F5564")
        static let appDefaultBlue = UIColor(named: "#415766")

    }
   
    struct ErrorMessages {
        static let noNetwork = "Check your internet connection."
    }
}


struct API {
    static let baseUrl = "http://3.84.159.2:8094/"
   
}



struct MethodName {
   
    static let companyInformation = "companyInformation"
}


struct StatusCode{
    static let success = 200
    static let pageNotFound = 404
    static let dataError = 401
    static let noDataFound = 400
}

struct Validation{
    static let errorEmailEmpty = "Please enter email address."
    static let errorPasswordEmpty = "Please enter password."
    
    static let errorFirstNameEmpty = "Please enter first name."
    static let errorLastNameEmpty = "Please enter last name."
    
}

struct ErrorMessages{
    static let errorToHandleInSuccess = "Something is wrong while getting success"
    static let errorToHandleInFailure = "Something is wrong while getting failure"
    static let errorNothingToLog = "There is nothing to log on console"
    
}

struct Console{
    static func log(_ message: Any?){
        print(message ?? ErrorMessages.errorNothingToLog)
        
    }
}

struct ServerKeys {
    //signup
    static let userId = "user_id"
    static let userName = "user_name"
   
    //companyInformation
    static let areaOfInterest = "areaOfInterest"
    static let targetAudience = "targetAudience"
    static let frequencyId = "frequencyId"
    static let mediahouseId = "mediahouseId"
    static let stepCount = "stepCount"
    static let keywordName = "keywordName"
    static let website = "website"
    static let audience = "audience"
}

struct UserDefaultKeys{
    //static let kIsLoggedIN = "is_logged_in"
    static let isLoggedIn = "isLoggedIn"
}

enum LoginType: String {
    case normal
    case facebook
    case google
}

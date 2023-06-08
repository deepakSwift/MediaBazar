//
//  User2.swift
//  MediaBazar
//
//  Created by Sagar Gupta on 18/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation

class ProfilePic: NSObject{
    enum Keys: String, CodingKey {
        case designationId = "designationId"
        case mailingAddress = "mailingAddress"
        case otp = "otp"
        case verifyOtp = "verifyOtp"
        case areaOfInterest = "areaOfInterest"
        case targetAudience = "targetAudience"
        case resumeDetails = "resumeDetails"
        case uploadResume = "uploadResume"
        case refrences = "refrences"
        case previousWorks = "previousWorks"
        case facebookLink = "facebookLink"
        case twitterLink = "twitterLink"
        case linkedinLink = "linkedinLink"
        case snapChatLink = "snapChatLink"
        case instagramLink = "instagramLink"
        case youtubeLink = "youtubeLink"
        case platformBenefits = "platformBenefits"
        case platformSuggestion = "platformSuggestion"
        case paymentStatus = "paymentStatus"
        case userType = "userType"
        case status = "status"
        case Id = "_id"
        case emailId = "emailId"
        case mobileNumber = "mobileNumber"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case langCode = "langCode"
        case password = "password"
        case currency = "currency"
        case shortBio = "shortBio"
        case country = "country"
        case state = "state"
        case city = "city"
        case stepCount = "stepCount"
        case profilePic = "profilePic"
        case shortVideo = "shortVideo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case value = "__v"
    }
    
    
    
    var designationId = ""
    var mailingAddress = ""
    var otp = ""
    var verifyOtp: Bool = true
    var areaOfInterest = [String]()
    var targetAudience = [String]()
    var resumeDetails = ""
    var uploadResume = ""
    var refrences = [ProffesionalDetailModel]()
    var previousWorks = [PreviousModel]()
    var facebookLink = ""
    var twitterLink = ""
    var linkedinLink = ""
    var snapChatLink = ""
    var instagramLink = ""
    var youtubeLink = ""
    var platformBenefits = [BenefitModel]()
    var platformSuggestion = ""
    var paymentStatus: Int = 0
    var userType = ""
    var status: Int = 0
    var Id = ""
    var emailId = ""
    var mobileNumber = ""
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var langCode = ""
    var password = ""
    var currency = ""
    var shortBio = ""
    var country = CountryList()
    var state = StateList()
    var city = CountryList()
    var stepCount: Int = 0
    var profilePic = ""
    var shortVideo = ""
    var createdAt = ""
    var updatedAt = ""
    var value: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        if let designationId = dictionary[Keys.designationId.stringValue] as? String{
            self.designationId = designationId
        }
        if let mailingAddress = dictionary[Keys.mailingAddress.stringValue] as? String{
            self.mailingAddress = mailingAddress
        }
        if let otp = dictionary[Keys.otp.stringValue] as? String{
            self.otp = otp
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? Bool{
            self.verifyOtp = verifyOtp
        }
        if let areaOfInterest = dictionary[Keys.areaOfInterest.stringValue] as? [String]{
            self.areaOfInterest = areaOfInterest
        }
        if let targetAudience = dictionary[Keys.targetAudience.stringValue] as? [String]{
            self.targetAudience = targetAudience
        }
        if let resumeDetails = dictionary[Keys.resumeDetails.stringValue] as? String{
            self.resumeDetails = resumeDetails
        }
        if let uploadResume = dictionary[Keys.uploadResume.stringValue] as? String{
            self.uploadResume = uploadResume
        }
        if let refrences = dictionary[Keys.refrences.stringValue] as? Array<Dictionary<String, AnyObject>>{
            self.refrences.removeAll()
            for item in refrences{
                let someRefences = ProffesionalDetailModel(dictionary: item)
                self.refrences.append(someRefences)
            }
            
        }
        if let country = dictionary[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dictionary[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        if let city = dictionary[Keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CountryList(dict: city)
        }
        
        //        if let previousWorks = dictionary[Keys.previousWorks.stringValue] as? Array<Dictionary<String, AnyObject>>{
        //            self.previousWorks.removeAll()
        //            for item in refrences{
        //                let somepreviousWorks = PreviousModel(dictionary: item)
        //                self.refrences.append(somepreviousWorks)
        //            }
        //
        //        }
    }
    
}



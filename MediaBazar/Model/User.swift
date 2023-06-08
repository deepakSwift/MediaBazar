//
//  User.swift
//  MediaBazar
//
//  Created by deepak Kumar on 04/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//
import Foundation
import SwiftyJSON

class User: NSObject {
    
    enum Keys: String, CodingKey {
        case token = "journalistToken"
        case stepCount = "stepCount"
        case journalistId = "journalistId"
        case userType = "userType"
        case emailID = "emailId"
        case mediahouseToken = "mediahouseToken"
        case mediahouseId = "mediahouseId"
        case mediaHouseDesignationId = "designationId"
        case UserInfo = "prevData"
        case mediaSignupId = "_id"
        case mobileNumber = "mobileNumber"
        case language = "language"
        
        case prevJouralistData = "prevJouralistData"
    }
    
    
    var token = ""
    var stepCount : Int = 0
    var journalistId = ""
    var userType = ""
    var emailID = ""
    var mediahouseToken = ""
    var mediahouseId = ""
    var mediaHouseDesignationId = ""
    var mediaSignupId = ""
    var mobileNumber = ""
    var language = ""
    var UserInfo = MediaHouseDetailsModel()
    
    var prevJouralistData = PerviousJournalistDatModal()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        if let UserInfo = dict[Keys.UserInfo.stringValue] as? Dictionary<String,AnyObject>{
            self.UserInfo = MediaHouseDetailsModel(dictionary: UserInfo)
        }
        if let token = dict[Keys.token.stringValue] as? String {
            self.token = token
        }
        if let mediahouseToken = dict[Keys.mediahouseToken.stringValue] as? String {
            self.mediahouseToken = mediahouseToken
        }
        if let stepCount = dict[Keys.stepCount.stringValue] as? Int {
            self.stepCount = stepCount
        }
        if let journalistId = dict[Keys.journalistId.stringValue] as? String {
            self.journalistId = journalistId
        }
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let emailID = dict[Keys.emailID.stringValue] as? String {
            self.emailID = emailID
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let mediaSignupId = dict[Keys.mediaSignupId.stringValue] as? String {
            self.mediaSignupId = mediaSignupId
        }
        if let mobileNumber = dict[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let language = dict[Keys.language.stringValue] as? String {
            self.language = language
        }
        
        if let mediaHouseDesignationId = dict[Keys.mediaHouseDesignationId.stringValue] as? String {
            self.mediaHouseDesignationId = mediaHouseDesignationId
        }
        
        if let prevJouralistData = dict[Keys.prevJouralistData.stringValue] as? Dictionary<String,AnyObject> {
            self.prevJouralistData = PerviousJournalistDatModal(dictionary: prevJouralistData)
        }


        super.init()
    }
    
    func saveUserJSON(_ json:JSON) {
        if (json["result"].dictionaryObject as [String: AnyObject]?) != nil {
            let documentPath = NSHomeDirectory() + "/Documents/"
            do {
                let data = try json.rawData(options: [.prettyPrinted])
                let path = documentPath + "data"
                try data.write(to: URL(fileURLWithPath: path), options: .atomic)
            }catch{
                print_debug("error in saving userinfo")
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    class func loadSavedUser() -> User{
        let documentPath = NSHomeDirectory() + "/Documents/"
        let path = documentPath + "data"
        var data = Data()
        var json : JSON
        do{
            data = try Data(contentsOf: URL(fileURLWithPath: path))
            json = try JSON(data: data)
            print("newJson\(json)")
        }catch{
            json = JSON.init(data)
            print_debug("error in getting userinfo")
        }
        let parser = UserParsar(json: json)
        return parser.result
    }
}

//----------PerviousJournalistDatModal---------
class PerviousJournalistDatModal: NSObject{
    enum keys: String, CodingKey {
        case country = "country"
        case city = "city"
        case state = "state"
        case invitedStatus = "invitedStatus"
        case registrationPaymentStatus = "registrationPaymentStatus"
        
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case profilePic = "profilePic"
        
        
    }
    
    var country = CountryList()
    var state = StateList()
    var city = CityList()
    var invitedStatus : Int = 0
    var registrationPaymentStatus : Int = 0
    
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var profilePic = ""
    
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        if let country = dictionary[keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dictionary[keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }

        if let city = dictionary[keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CityList(dict: city)
        }
        if let invitedStatus = dictionary[keys.invitedStatus.stringValue] as? Int {
            self.invitedStatus = invitedStatus
        }
        if let registrationPaymentStatus = dictionary[keys.registrationPaymentStatus.stringValue] as? Int {
            self.registrationPaymentStatus = registrationPaymentStatus
        }

        if let firstName = dictionary[keys.firstName.stringValue] as? String{
            self.firstName = firstName
        }
        if let middleName = dictionary[keys.middleName.stringValue] as? String{
            self.middleName = middleName
        }
        if let lastName = dictionary[keys.lastName.stringValue] as? String{
            self.lastName = lastName
        }
        if let profilePic = dictionary[keys.profilePic.stringValue] as? String{
            self.profilePic = profilePic
        }

        super.init()
    }
}

//----------PerviousJournalistDatModal---------
class PerviousMediaHouseDatModal: NSObject{
    enum keys: String, CodingKey {
        case country = "country"
        case city = "city"
        case state = "state"
        case invitedStatus = "invitedStatus"
    }
    
    var country = CountryList()
    var state = StateList()
    var city = CityList()
    var invitedStatus : Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        if let country = dictionary[keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dictionary[keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }

        if let city = dictionary[keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CityList(dict: city)
        }
        if let invitedStatus = dictionary[keys.invitedStatus.stringValue] as? Int {
            self.invitedStatus = invitedStatus
        }

        super.init()
    }
}





//----------DesignationList---------
class DesignationModel: NSObject{
    enum keys: String, CodingKey {
        case id = "id"
        case text = "text"
        case status = "status"
        case adminBenifitID = "_id"
        case benifitName = "benefitName"
        case designationName = "designationName"
        
    }
    
    var id  = ""
    var text = ""
    var status = ""
    var adminBenifitID = ""
    var benifitName = ""
    var designationName = ""
    
    override init() {
        super.init()
    }
    init(dictionary:[String: AnyObject]) {
        if let designationId = dictionary[keys.id.stringValue] as? String{
            self.id = designationId
        }
        if let designationText = dictionary[keys.text.stringValue] as? String{
            self.text = designationText
        }
        if let status = dictionary[keys.status.stringValue] as? String{
            self.status = status
        }
        if let adminBenifitID = dictionary[keys.adminBenifitID.stringValue] as? String{
            self.adminBenifitID = adminBenifitID
        }
        if let benifitName = dictionary[keys.benifitName.stringValue] as? String{
            self.benifitName = benifitName
        }
        if let designationName = dictionary[keys.designationName.stringValue] as? String{
            self.designationName = designationName
        }
        
        super.init()
    }
}
//----------LanguageList---------

class LanguageList: NSObject {
    enum keys: String, CodingKey {
        
        case languageID = "lang_id"
        case languageName = "lang_name"
        case languageKey = "lang_key"
        case categoryID = "id"
        case categoryText = "text"
        case keywordStatus = "status"
        case keywordID = "_id"
        case keywordName = "storyKeywordName"
        case mediahouseFrequencyName = "mediahouseFrequencyName"
        case jobCategoryName = "jobCategoryName"
        case jobFunctionalAreaName = "jobFunctionalAreaName"
        case jobRoleName = "jobRoleName"
        case jobQualificationName = "jobQualificationName"
        case jobKeywordName = "jobKeywordName"
        //case FrequencyID = "_id"
    }
    
    var languageID = ""
    var languageName = ""
    var languageKey = ""
    var categoryID = ""
    var categoryText = ""
    var keywordStatus = ""
    var keywordID = ""
    var keywordName = ""
    var mediahouseFrequencyName = ""
    var jobCategoryName = ""
    var jobFunctionalAreaName = ""
    var jobRoleName = ""
    var jobQualificationName = ""
    var jobKeywordName = ""
    //var FrequencyID = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String : AnyObject]) {
        if let languageID = dictionary[keys.languageID.stringValue] as? String {
            self.languageID = languageID
        }
        if let languageName = dictionary[keys.languageName.stringValue] as? String {
            self.languageName = languageName
        }
        if let languageKey = dictionary[keys.languageKey.stringValue] as? String {
            self.languageKey = languageKey
        }
        if let categoryID = dictionary[keys.categoryID.stringValue] as? String {
            self.categoryID = categoryID
        }
        if let categoryText = dictionary[keys.categoryText.stringValue] as? String {
            self.categoryText = categoryText
        }
        if let keywordStatus = dictionary[keys.keywordStatus.stringValue] as? String {
            self.keywordStatus = keywordStatus
        }
        if let keywordID = dictionary[keys.keywordID.stringValue] as? String {
            self.keywordID = keywordID
        }
        if let keywordName = dictionary[keys.keywordName.stringValue] as? String {
            self.keywordName = keywordName
        }
        if let mediahouseFrequencyName = dictionary[keys.mediahouseFrequencyName.stringValue] as? String {
            self.mediahouseFrequencyName = mediahouseFrequencyName
        }
        if let jobCategoryName = dictionary[keys.jobCategoryName.stringValue] as? String {
            self.jobCategoryName = jobCategoryName
        }
        if let jobFunctionalAreaName = dictionary[keys.jobFunctionalAreaName.stringValue] as? String {
            self.jobFunctionalAreaName = jobFunctionalAreaName
        }
        if let jobRoleName = dictionary[keys.jobRoleName.stringValue] as? String {
            self.jobRoleName = jobRoleName
        }
        if let jobQualificationName = dictionary[keys.jobQualificationName.stringValue] as? String {
            self.jobQualificationName = jobQualificationName
        }
        if let jobKeywordName = dictionary[keys.jobKeywordName.stringValue] as? String {
            self.jobKeywordName = jobKeywordName
        }
        super.init()
    }
}
//----------SocialMedialinkModel---------

class SocialMedialinkModel: NSObject{
    
    
    enum Keys: String, CodingKey{
        case designationId = "designationId"
        case verifyOtp = "verifyOtp"
        case paymentStatus = "paymentStatus"
        case userType = "userType"
        case status = "status"
        case id = "_id"
        case emailId = "emailId"
        case mobileNumber = "mobileNumber"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case langCode = "langCode"
        case password = "password"
        case currency = "currency"
        case shortBio = "shortBio"
        case organizationName = "organizationName"
        //        case country = "country"
        //        case state = "state"
        //        case city = "city"
        case stepCount = "stepCount"
        case profilePic = "profilePic"
        case shortVideo = "shortVideo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case value = "__v"
        case facebookLink = "facebookLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        
    }
    var designationId = ""
    var verifyOtp = true
    var paymentStatus = 0
    var userType = ""
    var status = ""
    var id = ""
    var emailId = ""
    var mobileNumber = 0
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var langCode = ""
    var password = ""
    var currency = ""
    var shortBio = ""
    var organizationName = ""
    //    var country = 0
    //    var state = 0
    //    var city = 0
    var stepCount = 0
    var profilePic = ""
    var shortVideo = ""
    var createdAt = ""
    var updatedAt = ""
    var value = 0
    var facebookLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let designationId = dictionary[Keys.designationId.stringValue] as? String {
            self.designationId = designationId
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? Bool {
            self.verifyOtp = verifyOtp
        }
        if let paymentStatus = dictionary[Keys.paymentStatus.stringValue] as? Int {
            self.paymentStatus = paymentStatus
        }
        if let userType = dictionary[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let status = dictionary[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let id = dictionary[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let emailId = dictionary[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let mobileNumber = dictionary[Keys.mobileNumber.stringValue] as? Int {
            self.mobileNumber = mobileNumber
        }
        if let firstName = dictionary[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dictionary[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dictionary[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let organizationName = dictionary[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
        }
        if let langCode = dictionary[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dictionary[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let currency = dictionary[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let shortBio = dictionary[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        //        if let country = dictionary[Keys.country.stringValue] as? Int {
        //            self.country = country
        //        }
        //        if let state = dictionary[Keys.state.stringValue] as? Int {
        //            self.state = state
        //        }
        //        if let city = dictionary[Keys.city.stringValue] as? Int {
        //            self.city = city
        //        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? Int {
            self.stepCount = stepCount
        }
        if let profilePic = dictionary[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let shortVideo = dictionary[Keys.shortVideo.stringValue] as? String {
            self.shortVideo = shortVideo
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let value = dictionary[Keys.value.stringValue] as? Int {
            self.value = value
        }
        if let facebookLink = dictionary[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
        }
        if let instagramLink = dictionary[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dictionary[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        if let snapChatLink = dictionary[Keys.snapChatLink.stringValue] as? String {
            self.snapChatLink = snapChatLink
        }
        if let twitterLink = dictionary[Keys.twitterLink.stringValue] as? String {
            self.twitterLink = twitterLink
        }
        if let youtubeLink = dictionary[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        super.init()
    }
}

class BenefitModel: NSObject {
    enum key: String, CodingKey {
        case status = "status"
        case Id = "_id"
        case benefitName = "benefitName"
    }
    
    var status: Int = 0
    var Id = ""
    var benefitName = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        if let status = dictionary[key.status.stringValue] as? Int{
            self.status = status
        }
        if let id = dictionary[key.Id.stringValue] as? String{
            self.Id = id
        }
        if let benefitName = dictionary[key.benefitName.stringValue] as? String{
            self.benefitName = benefitName
        }
        super.init()
    }
}

//-----------previousWorkModel---------
class PreviousModel: NSObject{
    
    enum Keys: String, CodingKey{
        case designationId = "designationId"
        case verifyOtp = "verifyOtp"
        case paymentStatus = "paymentStatus"
        case userType = "userType"
        case status = "status"
        case id = "_id"
        case emailId = "emailId"
        case mobileNumber = "mobileNumber"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case langCode = "langCode"
        case password = "password"
        case currency = "currency"
        case shortBio = "shortBio"
        case organizationName = "organizationName"
        case country = "country"
        case state = "state"
        case city = "city"
        case stepCount = "stepCount"
        case profilePic = "profilePic"
        case shortVideo = "shortVideo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case value = "__v"
        case facebookLink = "facebookLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        case platformSuggestion = "platformSuggestion"
        case resumeDetails = "resumeDetails"
        case uploadResume = "uploadResume"
        
    }
    var designationId = ""
    var verifyOtp = true
    var paymentStatus = 0
    var userType = ""
    var status = ""
    var id = ""
    var emailId = ""
    var mobileNumber = 0
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var organizationName = ""
    var langCode = ""
    var password = ""
    var currency = ""
    var shortBio = ""
    var country = 0
    var state = 0
    var city = 0
    var stepCount = 0
    var profilePic = ""
    var shortVideo = ""
    var createdAt = ""
    var updatedAt = ""
    var value = 0
    var facebookLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    var platformSuggestion = ""
    var resumeDetails = ""
    var uploadResume = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let designationId = dictionary[Keys.designationId.stringValue] as? String {
            self.designationId = designationId
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? Bool {
            self.verifyOtp = verifyOtp
        }
        if let paymentStatus = dictionary[Keys.paymentStatus.stringValue] as? Int {
            self.paymentStatus = paymentStatus
        }
        if let userType = dictionary[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let status = dictionary[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let id = dictionary[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let emailId = dictionary[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let mobileNumber = dictionary[Keys.mobileNumber.stringValue] as? Int {
            self.mobileNumber = mobileNumber
        }
        if let firstName = dictionary[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dictionary[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dictionary[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let organizationName = dictionary[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
        }
        if let langCode = dictionary[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dictionary[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let currency = dictionary[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let shortBio = dictionary[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        if let country = dictionary[Keys.country.stringValue] as? Int {
            self.country = country
        }
        if let state = dictionary[Keys.state.stringValue] as? Int {
            self.state = state
        }
        if let city = dictionary[Keys.city.stringValue] as? Int {
            self.city = city
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? Int {
            self.stepCount = stepCount
        }
        if let profilePic = dictionary[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let shortVideo = dictionary[Keys.shortVideo.stringValue] as? String {
            self.shortVideo = shortVideo
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let value = dictionary[Keys.value.stringValue] as? Int {
            self.value = value
        }
        if let facebookLink = dictionary[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
        }
        if let instagramLink = dictionary[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dictionary[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        if let snapChatLink = dictionary[Keys.snapChatLink.stringValue] as? String {
            self.snapChatLink = snapChatLink
        }
        if let twitterLink = dictionary[Keys.twitterLink.stringValue] as? String {
            self.twitterLink = twitterLink
        }
        if let youtubeLink = dictionary[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        if let platformSuggestion = dictionary[Keys.platformSuggestion.stringValue] as? String{
            self.platformSuggestion = platformSuggestion
        }
        if let resumeDetails = dictionary[Keys.resumeDetails.stringValue] as? String{
            self.resumeDetails = resumeDetails
        }
        if let uploadResume = dictionary[Keys.uploadResume.stringValue] as? String{
            self.uploadResume = uploadResume
        }
        super.init()
    }
}
//---------------Category Model-----------------

class CategoryModel: NSObject{
    enum keys: String, CodingKey{
        case id = "id"
        case text = "text"
    }
    
    var id = ""
    var text = ""
    
    override init() {
        super.init()
    }
    init(dictionary: [String: AnyObject]) {
        
        if let categoryId = dictionary[keys.id.stringValue] as? String {
            self.id = categoryId
        }
        if let categoryText = dictionary[keys.text.stringValue] as? String {
            self.text = categoryText
        }
        super.init()
    }
}

//--------StoryKeyword Model------------

class StoryKeywordModel: NSObject{
    enum key: String, CodingKey {
        case status = "status"
        case id = "_id"
        case storyKeywordName = "storyKeywordName"
    }
    
    var status = ""
    var id = ""
    var storyKeywordName = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let status = dictionary[key.status.stringValue] as? String{
            self.status = status
        }
        if let ID = dictionary[key.id.stringValue] as? String{
            self.id = ID
        }
        if let KeywordName = dictionary[key.storyKeywordName.stringValue] as? String{
            self.storyKeywordName = KeywordName
        }
        super.init()
    }
}
//---------ProfesionalDetail---------

class ProffesionalDetailModel: NSObject {
    
    enum Keys: String, CodingKey {
        
        case designationId = "designationId"
        case verifyOtp = "verifyOtp"
        case areaOfInterest = "areaOfInterest"
        case targetAudience = "targetAudience"
        case previousWorks = "previousWorks"
        case platformBenefits = "platformBenefits"
        case paymentStatus = "paymentStatus"
        case userType = "userType"
        case status = "status"
        case id = "_id"
        case emailId = "emailId"
        case mobileNumber = "mobileNumber"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case organizationName = "organizationName"
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
        case facebookLink = "facebookLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        case platformSuggestion = "platformSuggestion"
        case resumeDetails = "resumeDetails"
        case uploadResume = "uploadResume"
        case frequencyId = "frequencyId"
        case mediahouseId = "mediahouseId"
        case keywordName = "keywordName"
        case website = "website"
        case audience = "audience"
        
    }
    var designationId = ""
    var verifyOtp = true
    var areaOfInterest = [String]()
    var targetAudience = [ProfPreviousWorksMedal]()
    var previousWorks = [String]()
    var platformBenefits = [String]()
    var paymentStatus = 0
    var userType = ""
    var status = ""
    var id = ""
    var emailId = ""
    var mobileNumber = 0
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var organizationName = "organizationName"
    var langCode = ""
    var password = ""
    var currency = ""
    var shortBio = ""
    var country = 0
    var state = 0
    var city = 0
    var stepCount = 0
    var profilePic = ""
    var shortVideo = ""
    var createdAt = ""
    var updatedAt = ""
    var value = 0
    var facebookLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    var platformSuggestion = ""
    var resumeDetails = ""
    var uploadResume = ""
    var frequencyId = ""
    var mediahouseId = ""
    var keywordName = ""
    var website = ""
    var audience = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let designationId = dictionary[Keys.designationId.stringValue] as? String {
            self.designationId = designationId
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? Bool {
            self.verifyOtp = verifyOtp
        }
        if let areaOfInterest = dictionary[Keys.areaOfInterest.stringValue] as? [String] {
            self.areaOfInterest = areaOfInterest
        }
        if let targetAudience = dictionary[Keys.targetAudience.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.targetAudience.removeAll()
            for item in targetAudience{
                let someAudience = ProfPreviousWorksMedal(dictionary: item)
                self.targetAudience.append(someAudience)
            }
        }
        if let previousWorks = dictionary[Keys.previousWorks.stringValue] as? [String] {
            self.previousWorks = previousWorks
        }
        if let platformBenefits = dictionary[Keys.platformBenefits.stringValue] as? [String] {
            self.platformBenefits = platformBenefits
        }
        if let paymentStatus = dictionary[Keys.paymentStatus.stringValue] as? Int {
            self.paymentStatus = paymentStatus
        }
        if let userType = dictionary[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let status = dictionary[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let id = dictionary[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let emailId = dictionary[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let mobileNumber = dictionary[Keys.mobileNumber.stringValue] as? Int {
            self.mobileNumber = mobileNumber
        }
        if let firstName = dictionary[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dictionary[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dictionary[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let organizationName = dictionary[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
        }
        if let langCode = dictionary[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dictionary[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let currency = dictionary[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let shortBio = dictionary[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        if let country = dictionary[Keys.country.stringValue] as? Int {
            self.country = country
        }
        if let state = dictionary[Keys.state.stringValue] as? Int {
            self.state = state
        }
        if let city = dictionary[Keys.city.stringValue] as? Int {
            self.city = city
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? Int {
            self.stepCount = stepCount
        }
        if let profilePic = dictionary[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let shortVideo = dictionary[Keys.shortVideo.stringValue] as? String {
            self.shortVideo = shortVideo
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let value = dictionary[Keys.value.stringValue] as? Int {
            self.value = value
        }
        if let facebookLink = dictionary[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
        }
        if let instagramLink = dictionary[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dictionary[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        if let snapChatLink = dictionary[Keys.snapChatLink.stringValue] as? String {
            self.snapChatLink = snapChatLink
        }
        if let twitterLink = dictionary[Keys.twitterLink.stringValue] as? String {
            self.twitterLink = twitterLink
        }
        if let youtubeLink = dictionary[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        if let platformSuggestion = dictionary[Keys.platformSuggestion.stringValue] as? String{
            self.platformSuggestion = platformSuggestion
        }
        if let resumeDetails = dictionary[Keys.resumeDetails.stringValue] as? String{
            self.resumeDetails = resumeDetails
        }
        if let uploadResume = dictionary[Keys.uploadResume.stringValue] as? String{
            self.uploadResume = uploadResume
        }
        if let frequencyId = dictionary[Keys.frequencyId.stringValue] as? String{
            self.frequencyId = frequencyId
        }
        if let mediahouseId = dictionary[Keys.mediahouseId.stringValue] as? String{
            self.mediahouseId = mediahouseId
        }
        if let keywordName = dictionary[Keys.keywordName.stringValue] as? String{
            self.keywordName = keywordName
        }
        if let website = dictionary[Keys.website.stringValue] as? String{
            self.website = website
        }
        if let audience = dictionary[Keys.audience.stringValue] as? String{
            self.audience = audience
        }
        super.init()
    }
}

class ProfPreviousWorksMedal: NSObject{
    enum Keys: String, CodingKey{
        case link = "link"
        case title = "title"
    }
    var link = ""
    var title = ""
    
    override init() {
        super.init()
    }
    init(dictionary: [String: AnyObject]) {
        if let link = dictionary[Keys.link.stringValue] as? String {
            self.link = link
        }
        if let title = dictionary[Keys.title.stringValue] as? String {
            self.title = title
        }
        super.init()
    }
}
//================================

//-------EnquiryModel------

class EnquiryModel: NSObject{
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
        
        //----PostEnquiry------
        case journalistId =  "journalistId"
        case status = "status"
        case Id = "_id"
        case enquiryTitle = "enquiryTitle"
        case enquiryDescription = "enquiryDescription"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case value = "__v"
    }
    
    var docs = [EnquiryDocsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    var journalistId = ""
    var status: Int = 0
    var Id = ""
    var enquiryTitle = ""
    var enquiryDescription = ""
    var createdAt = ""
    var updatedAt = ""
    var value: Int = 0
    
    
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = EnquiryDocsModel(dictionary: item)
                print("\(somedocs)")
                self.docs.append(somedocs)
            }
        }
        if let total = dictionary[Keys.total.stringValue] as? Int{
            self.total = total
        }
        if let limit = dictionary[Keys.limit.stringValue] as? Int{
            self.limit = limit
        }
        if let page = dictionary[Keys.page.stringValue] as? Int{
            self.page = page
        }
        if let pages = dictionary[Keys.pages.stringValue] as? Int{
            self.pages = pages
        }
        if let journalistId = dictionary[Keys.journalistId.stringValue] as? String{
            self.journalistId = journalistId
        }
        if let status = dictionary[Keys.status.stringValue] as? Int{
            self.status = status
        }
        if let Id = dictionary[Keys.Id.stringValue] as? String{
            self.Id = Id
        }
        if let enquiryTitle = dictionary[Keys.enquiryTitle.stringValue] as? String{
            self.enquiryTitle = enquiryTitle
        }
        if let enquiryDescription = dictionary[Keys.enquiryDescription.stringValue] as? String{
            self.enquiryDescription = enquiryDescription
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String{
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String{
            self.updatedAt = updatedAt
        }
        if let value = dictionary[Keys.value.stringValue] as? Int{
            self.value = value
        }
        super.init()
    }
}

//------EnquiryDocs----
class EnquiryDocsModel: NSObject{
    enum Keys: String, CodingKey{
        case id = "_id"
        case enquiryTitle = "enquiryTitle"
        case enquiryDescription = "enquiryDescription"
        case mediahouseId = "mediahouseId"
        case ethicsCommiteeId = "ethicsCommiteeId"
    }
    var id = ""
    var enquiryTitle = ""
    var enquiryDescription = ""
    var mediahouseId =  MediahouseId()
    var ethicsCommiteeId = EthicsCommiteeId()
    
    override init() {
        super.init()
    }
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let enquiryTitle = dictionary[Keys.enquiryTitle.stringValue] as? String {
            self.enquiryTitle = enquiryTitle
        }
        if let enquiryDescription = dictionary[Keys.enquiryDescription.stringValue] as? String {
            self.enquiryDescription = enquiryDescription
        }
        if let mediahouseId = dictionary[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject> {
            self.mediahouseId = MediahouseId(dict: mediahouseId)
        }
        if let ethicsCommiteeId = dictionary[Keys.ethicsCommiteeId.stringValue] as? Dictionary<String,AnyObject> {
            self.ethicsCommiteeId = EthicsCommiteeId(dict: ethicsCommiteeId)
        }
        
        super.init()
    }
}



class MediahouseId: NSObject {
    
    enum Keys: String, CodingKey {
        case firstName = "firstName"
        case middleName = "middleName"
        case  lastName = "lastName"
        case userType = "userType"
        case id = "_id"
        case logo = "logo"
    }
    
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var userType = ""
    var id = ""
    var logo = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let logo = dict[Keys.logo.stringValue] as? String {
            self.logo = logo
        }
        
        super.init()
    }
    
}


class EthicsCommiteeId: NSObject {
    
    enum Keys: String, CodingKey {
        case firstName = "firstName"
        case middleName = "middleName"
        case  lastName = "lastName"
        case id = "_id"
        case profilePic = "profilePic"
        
    }
    
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var id = ""
    var profilePic = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        
        super.init()
    }
    
}

class StoryDownloadModal: NSObject {
    enum key: String, CodingKey {
        case url = "url"
    }
    

    var url = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        if let url = dictionary[key.url.stringValue] as? String{
            self.url = url
        }
        super.init()
    }
}


//
//  Modal.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 18/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON

class storyModal: NSObject {
    enum Keys: String, CodingKey {
        case headLine = "headLine"
        case categoryID = "categoryId"
        case languageCode = "langCode"
        case country = "country"
        case state = "state"
        case city = "city"
        case date = "date"
        case keywordID = "keywordId"
        case briefDescri = "briefDescription"
        case storyCategory = "storyCategory"
        case price = "price"
        case currency = "currency"
        case typeStatus = "typeStatus"
        case purchaseLimit = "purchasingLimit"
        case auctionDuration = "auctionDuration"
        case auctionBiddingPrice = "auctionBiddingPrice"
        case blogID = "_id"
        
        case body = "body"
        
    }
    
    var headLine = ""
    var categoryID = ""
    var languageCode = ""
    var country = CountryList()
    var state = StateList()
    var city = CountryList()
    var date = ""
    var keywordID = [String]()
    var briefDescri = ""
    var storyCategory = ""
    var price = ""
    var currency = ""
    var typeStatus = ""
    var purchaseLimit = ""
    var auctionDuration = ""
    var auctionBiddingPrice = ""
    var blogID = ""
    
    var body = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let headLine = dict[Keys.headLine.stringValue] as? String {
            self.headLine = headLine
        }
        if let categoryID = dict[Keys.categoryID.stringValue] as? String {
            self.categoryID = categoryID
        }
        if let languageCode = dict[Keys.languageCode.stringValue] as? String {
            self.languageCode = languageCode
        }
        if let keywordID = dict[Keys.keywordID.stringValue] as? [String] {
            self.keywordID = keywordID
        }
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        if let city = dict[Keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CountryList(dict: city)
        }
        if let storyCategory = dict[Keys.storyCategory.stringValue] as? String {
            self.storyCategory = storyCategory
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let typeStatus = dict[Keys.typeStatus.stringValue] as? String {
            self.typeStatus = typeStatus
        }
        if let purchaseLimit = dict[Keys.purchaseLimit.stringValue] as? String {
            self.purchaseLimit = purchaseLimit
        }
        if let auctionDuration = dict[Keys.auctionDuration.stringValue] as? String {
            self.auctionDuration = auctionDuration
        }
        
        if let blogID = dict[Keys.blogID.stringValue] as? String {
            self.blogID = blogID
        }
        
        if let body = dict[Keys.body.stringValue] as? String {
            self.body = body
        }
        super.init()
    }
    
}


class profileModal: NSObject {
    enum Keys: String, CodingKey {
        
        case designationID  = "designationId"
        case mailingAddress = "mailingAddress"
        case middleName = "middleName"
        case pinCode = "pinCode"
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
        case id = "_id"
        case profilePic = "profilePic"
        case shortVideo = "shortVideo"
        case emailId = "emailId"
        case mobileNumber = "mobileNumber"
        case firstName = "firstName"
        case lastName = "lastName"
        case langCode = "langCode"
        case password = "password"
        case currency = "currency"
        case shortBio = "shortBio"
        case country = "country"
        case city = "city"
        case state = "state"
        case stepCount = "stepCount"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        
        case price = "price"
        
        case profileStatus = "profileStatus"
        case totalAveargeReview = "totalAveargeReview"
        
    }
    
    var designationID  = DesignationModel()
    var mailingAddress = ""
    var middleName = ""
    var pinCode = ""
    var otp = ""
    var verifyOtp = ""
    var areaOfInterest = [categoryTypeModal]()
    var targetAudience = [categoryTypeModal]()
    var resumeDetails = ""
    var uploadResume = ""
    var refrences = [categoryTypeModal]()
    var previousWorks = [categoryTypeModal]()
    var facebookLink = ""
    var twitterLink = ""
    var linkedinLink = ""
    var snapChatLink = ""
    var instagramLink = ""
    var youtubeLink = ""
    var platformBenefits = [String]()
    var platformSuggestion = ""
    var paymentStatus = ""
    var userType = ""
    var status = ""
    var id = ""
    var profilePic = ""
    var shortVideo = ""
    var emailId = ""
    var mobileNumber = ""
    var firstName = ""
    var lastName = ""
    var langCode = ""
    var password = ""
    var currency = ""
    var shortBio = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    var stepCount = ""
    var createdAt = ""
    var updatedAt = ""
    
    var price : Int = 0
    
    var profileStatus : Int = 0
    var totalAveargeReview : Int = 0
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let designationID = dict[Keys.designationID.stringValue] as? Dictionary<String,AnyObject>{
            self.designationID = DesignationModel(dictionary: designationID)
        }
        
        if let mailingAddress = dict[Keys.mailingAddress.stringValue] as? String {
            self.mailingAddress = mailingAddress
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        
        if let pinCode = dict[Keys.pinCode.stringValue] as? String {
            self.pinCode = pinCode
        }
        if let otp = dict[Keys.otp.stringValue] as? String {
            self.otp = otp
        }
        if let verifyOtp = dict[Keys.verifyOtp.stringValue] as? String {
            self.verifyOtp = verifyOtp
        }
        
        if let areaOfInterest = dict[Keys.areaOfInterest.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in areaOfInterest {
                let tempArea = categoryTypeModal(dict: area)
                self.areaOfInterest.append(tempArea)
            }
        }
        
        if let targetAudience = dict[Keys.targetAudience.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for target in targetAudience {
                let tempTarget = categoryTypeModal(dict: target)
                self.targetAudience.append(tempTarget)
            }
        }
        
        
        if let refrences = dict[Keys.refrences.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for referenc in refrences {
                let tempRef = categoryTypeModal(dict: referenc)
                self.refrences.append(tempRef)
            }
        }
        
        if let previousWorks = dict[Keys.previousWorks.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for work in previousWorks {
                let tempWork = categoryTypeModal(dict: work)
                self.previousWorks.append(tempWork)
            }
        }
        
        if let facebookLink = dict[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
        }
        if let twitterLink = dict[Keys.twitterLink.stringValue] as? String {
            self.twitterLink = twitterLink
        }
        if let linkedinLink = dict[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        if let snapChatLink = dict[Keys.snapChatLink.stringValue] as? String {
            self.snapChatLink = snapChatLink
        }
        if let instagramLink = dict[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let youtubeLink = dict[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        
        if let platformBenefits = dict[Keys.platformBenefits.stringValue] as? [String] {
            self.platformBenefits = platformBenefits
        }
        
        if let platformSuggestion = dict[Keys.platformSuggestion.stringValue] as? String {
            self.platformSuggestion = platformSuggestion
        }
        if let paymentStatus = dict[Keys.paymentStatus.stringValue] as? String {
            self.paymentStatus = paymentStatus
        }
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let status = dict[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let youtubeLink = dict[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let shortVideo = dict[Keys.shortVideo.stringValue] as? String {
            self.shortVideo = shortVideo
        }
        if let emailId = dict[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let mobileNumber = dict[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dict[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let shortBio = dict[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        if let stepCount = dict[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let resumeDetails = dict[Keys.resumeDetails.stringValue] as? String {
            self.resumeDetails = resumeDetails
        }
        if let uploadResume = dict[Keys.uploadResume.stringValue] as? String {
            self.uploadResume = uploadResume
        }
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        if let city = dict[Keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CountryList(dict: city)
        }
        
        if let price = dict[Keys.price.stringValue] as? Int{
            self.price = price
        }
        
        if let profileStatus = dict[Keys.profileStatus.stringValue] as? Int{
            self.profileStatus = profileStatus
        }
        
        if let totalAveargeReview = dict[Keys.totalAveargeReview.stringValue] as? Int{
            self.totalAveargeReview = totalAveargeReview
        }
        
        super.init()
    }
    
}



class categoryTypeModal: NSObject {
    enum Keys: String, CodingKey {
        
        case id = "_id"
        case categoryName = "categoryName"
        case targetId = "id"
        case sortname = "sortname"
        case name = "name"
        case phonecode = "phonecode"
        case symbol = "symbol"
        case currencyName  = "currencyName"
        case firstName  = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case emailId = "emailId"
        case designation = "designation"
        case mobileNumber = "mobileNumber"
        case link = "link"
        case title = "title"
        
        
        
    }
    
    var id = ""
    var categoryName = ""
    var targetId = ""
    var sortname = ""
    var name = ""
    var phonecode = ""
    var symbol = ""
    var currencyName  = ""
    var firstName  = ""
    var middleName = ""
    var lastName = ""
    var emailId = ""
    var designation = ""
    var mobileNumber = ""
    var link = ""
    var title = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let categoryName = dict[Keys.categoryName.stringValue] as? String {
            self.categoryName = categoryName
        }
        if let targetId = dict[Keys.targetId.stringValue] as? String {
            self.targetId = targetId
        }
        if let sortname = dict[Keys.sortname.stringValue] as? String {
            self.sortname = sortname
        }
        if let name = dict[Keys.name.stringValue] as? String {
            self.name = name
        }
        if let phonecode = dict[Keys.phonecode.stringValue] as? String {
            self.phonecode = phonecode
        }
        if let symbol = dict[Keys.symbol.stringValue] as? String {
            self.symbol = symbol
        }
        if let currencyName = dict[Keys.currencyName.stringValue] as? String {
            self.currencyName = currencyName
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let emailId = dict[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let designation = dict[Keys.designation.stringValue] as? String {
            self.designation = designation
        }
        if let mobileNumber = dict[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let link = dict[Keys.link.stringValue] as? String {
            self.link = link
        }
        if let title = dict[Keys.title.stringValue] as? String {
            self.title = title
        }
        
        super.init()
    }
    
}


class storyListModal: NSObject {
    enum Keys: String, CodingKey {
        
        
        case journalistId = "journalistId"
        case categoryId = "categoryId"
        case storyCategory = "storyCategory"
        case keywordName = "keywordName"
        case langCode = "langCode"
        case storyText = "storyText"
        case currency = "currency"
        case price = "price"
        case collaborationGroupId = "collaborationGroupId"
        case purchasingLimit = "purchasingLimit"
        case auctionDuration = "auctionDuration"
        case auctionExpriyTime = "auctionExpriyTime"
        case auctionBiddingPrice = "auctionBiddingPrice"
        case status = "status"
        case typeStatus = "typeStatus"
        case fileCount = "fileCount"
        case collaboratedStatus = "collaboratedStatus"
        case favouriteStatus = "favouriteStatus"
        case id = "_id"
        case headLine = "headLine"
        case briefDescription = "briefDescription"
        case date = "date"
        case country = "country"
        case city = "city"
        case state = "state"
        case stepCount = "stepCount"
        case uploadTexts = "uploadTexts"
        case uploadImages = "uploadImages"
        case uploadVideos = "uploadVideos"
        case uploadThumbnails = "uploadThumbnails"
        case supportingDocs = "supportingDocs"
        case uploadAudios = "uploadAudios"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case time = "time"
        case assignmentDesc = "journalistAssignmentDescription"
        case assignmentHeadline = "journalistAssignmentHeadline"
        case assignmentID = "id"
        
        case mediaHouseID = "mediahouseId"
        case replyCount = "replyCount"
        case assignmentTitle = "assignmentTitle"
        case assignmentDescription = "assignmentDescription"
        
        case jobFunctionalAreaId = "jobFunctionalAreaId"
        case jobQualificationId = "jobQualificationId"
        case jobCategoryId = "jobCategoryId"
        case jobKeywordName = "jobKeywordName"
        case jobRoleId = "jobRoleId"
        case workExperience = "workExperience"
        case expectedSalary = "expectedSalary"
        case employementType = "employementType"
        case jobDescription = "jobDescription"
        
        case soldOut = "soldOut"
        case totalAveargeReview = "totalAveargeReview"
        case reviewCount = "reviewCount"
        
        case amount = "amount"
        case paymentMode = "paymentMode"
        case transactionId = "transactionId"
        
        case myContent = "myContent"
        
        case spellingAndGrammar =  "spellingAndGrammar"
        case consistencyAndClarity = "consistencyAndClarity"
        case fairObjectiveAndAccuracy = "fairObjectiveAndAccuracy"
        case obscenitiesProfanitiesAndVulgarities = "obscenitiesProfanitiesAndVulgarities"
        case plagiarism = "plagiarism"
        case mediahouseComment = "mediahouseComment"
        case journalistComment = "journalistComment"
        case averageRating = "averageRating"
        case storyId = "storyId"
        
        case userId = "userId"
        case collaborationGroupName = "collaborationGroupName"
        case members = "members"
        case collaborationGroupProfile = "collaborationGroupProfile"
        
        case realCurrencyCode = "realCurrencyCode"
        case realCurrencyName = "realCurrencyName"
        case realPrice = "realPrice"
        
        case message = "message"
        case messageType = "messageType"
        
        case realBiddingPrice = "realBiddingPrice"
        case ethicsCommitteId = "ethicsCommitteId"

    }
    
    
    var journalistId = journalistStoryModal()
    var categoryId = journalistStoryModal()
    var storyCategory = ""
    var keywordName = [String]()
    var langCode = ""
    var storyText = ""
    var currency = ""
    var price : Int = 0
    var collaborationGroupId = ""
    var purchasingLimit = ""
    var auctionDuration = ""
    var auctionExpriyTime = ""
    var auctionBiddingPrice = ""
    var status = ""
    var typeStatus = ""
    var fileCount : Int = 0
    var collaboratedStatus = ""
    var favouriteStatus = 0
    var id = ""
    var headLine = ""
    var briefDescription = ""
    var date = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    var stepCount = ""
    var uploadTexts = [journalistStoryModal]()
    var uploadImages = [journalistStoryModal]()
    var uploadVideos = [journalistStoryModal]()
    var uploadThumbnails = [journalistStoryModal]()
    var supportingDocs = [journalistStoryModal]()
    var uploadAudios = [journalistStoryModal]()
    var createdAt = ""
    var updatedAt = ""
    var time = ""
    var assignmentDesc = ""
    var assignmentHeadline = ""
    
    var mediaHouseID = journalistStoryModal()
    var replyCount = ""
    var assignmentTitle = ""
    var assignmentDescription = ""
    var assignmentID = ""
    
    var jobFunctionalAreaId = [journalistStoryModal]()
    var jobQualificationId = journalistStoryModal()
    var jobCategoryId = journalistStoryModal()
    var jobKeywordName = [String]()
    var jobRoleId = journalistStoryModal()
    var workExperience = ""
    var expectedSalary = ""
    var employementType = ""
    var jobDescription = ""
    
    var soldOut : Int = 0
    var totalAveargeReview : Double = 0.0
    var reviewCount : Int = 0
    
    var amount = ""
    var paymentMode = ""
    var transactionId = ""
    
    var myContent = journalistStoryModal()
    
    var spellingAndGrammar : Int = 0
    var consistencyAndClarity : Int = 0
    var fairObjectiveAndAccuracy : Int = 0
    var obscenitiesProfanitiesAndVulgarities : Int = 0
    var plagiarism : Int = 0
    var mediahouseComment = ""
    var journalistComment = ""
//    var averageRating : Int = 0
    var averageRating = ""

    var storyId = ""
    
    var userId = journalistStoryModal()
    var collaborationGroupName = ""
    var members = [journalistStoryModal]()
    var collaborationGroupProfile = ""
    
    var realCurrencyCode = ""
    var realCurrencyName = ""
    var realPrice = ""
    var message = ""
    var messageType = ""
    var realBiddingPrice = ""
    
    var ethicsCommitteId = journalistStoryModal()
    
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistStoryModal(dict: journalistId)
        }
        if let categoryId = dict[Keys.categoryId.stringValue] as? Dictionary<String,AnyObject>{
            self.categoryId = journalistStoryModal(dict: categoryId)
        }
        if let storyCategory = dict[Keys.storyCategory.stringValue] as? String {
            self.storyCategory = storyCategory
        }
        if let keywordName = dict[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let storyText = dict[Keys.storyText.stringValue] as? String {
            self.storyText = storyText
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        
        if let price = dict[Keys.price.stringValue] as? Int{
            self.price = price
        }
        
        if let collaborationGroupId = dict[Keys.collaborationGroupId.stringValue] as? String {
            self.collaborationGroupId = collaborationGroupId
        }
        if let purchasingLimit = dict[Keys.purchasingLimit.stringValue] as? String {
            self.purchasingLimit = purchasingLimit
        }
        if let auctionDuration = dict[Keys.auctionDuration.stringValue] as? String {
            self.auctionDuration = auctionDuration
        }
        if let auctionBiddingPrice = dict[Keys.auctionBiddingPrice.stringValue] as? String {
            self.auctionBiddingPrice = auctionBiddingPrice
        }
        
        if let auctionExpriyTime = dict[Keys.auctionExpriyTime.stringValue] as? String{
            self.auctionExpriyTime = auctionExpriyTime
        }
        
        
        if let status = dict[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let typeStatus = dict[Keys.typeStatus.stringValue] as? String {
            self.typeStatus = typeStatus
        }
        if let fileCount = dict[Keys.fileCount.stringValue] as? Int{
            self.fileCount = fileCount
        }
        
        
        if let collaboratedStatus = dict[Keys.collaboratedStatus.stringValue] as? String {
            self.collaboratedStatus = collaboratedStatus
        }
        if let collaboratedStatus = dict[Keys.collaboratedStatus.stringValue] as? String {
            self.collaboratedStatus = collaboratedStatus
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let headLine = dict[Keys.headLine.stringValue] as? String {
            self.headLine = headLine
        }
        if let briefDescription = dict[Keys.briefDescription.stringValue] as? String {
            self.briefDescription = briefDescription
        }
        if let date = dict[Keys.date.stringValue] as? String {
            self.date = date
        }
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        if let city = dict[Keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CountryList(dict: city)
        }
        if let stepCount = dict[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        
        if let uploadTexts = dict[Keys.uploadTexts.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadTexts {
                let tempArea = journalistStoryModal(dict: area)
                self.uploadTexts.append(tempArea)
            }
        }
        if let uploadImages = dict[Keys.uploadImages.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadImages {
                let tempArea = journalistStoryModal(dict: area)
                self.uploadImages.append(tempArea)
            }
        }
        if let uploadVideos = dict[Keys.uploadVideos.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadVideos {
                let tempArea = journalistStoryModal(dict: area)
                self.uploadVideos.append(tempArea)
            }
        }
        if let uploadThumbnails = dict[Keys.uploadThumbnails.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadThumbnails {
                let tempArea = journalistStoryModal(dict: area)
                self.uploadThumbnails.append(tempArea)
            }
        }
        if let supportingDocs = dict[Keys.supportingDocs.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in supportingDocs {
                let tempArea = journalistStoryModal(dict: area)
                self.supportingDocs.append(tempArea)
            }
        }
        if let uploadAudios = dict[Keys.uploadAudios.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadAudios {
                let tempArea = journalistStoryModal(dict: area)
                self.uploadAudios.append(tempArea)
            }
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let time = dict[Keys.time.stringValue] as? String {
            self.time = time
        }
        if let assignmentDesc = dict[Keys.assignmentDesc.stringValue] as? String {
            self.assignmentDesc = assignmentDesc
        }
        if let assignmentHeadline = dict[Keys.assignmentHeadline.stringValue] as? String {
            self.assignmentHeadline = assignmentHeadline
        }
        
        
        if let mediaHouseID = dict[Keys.mediaHouseID.stringValue] as? Dictionary<String,AnyObject>{
            self.mediaHouseID = journalistStoryModal(dict: mediaHouseID)
        }
        if let replyCount = dict[Keys.replyCount.stringValue] as? String {
            self.replyCount = replyCount
        }
        if let assignmentTitle = dict[Keys.assignmentTitle.stringValue] as? String {
            self.assignmentTitle = assignmentTitle
        }
        if let assignmentDescription = dict[Keys.assignmentDescription.stringValue] as? String {
            self.assignmentDescription = assignmentDescription
        }
        
        if let assignmentID = dict[Keys.assignmentID.stringValue] as? String {
            self.assignmentID = assignmentID
        }
        
        
        if let jobFunctionalAreaId = dict[Keys.jobFunctionalAreaId.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for job in jobFunctionalAreaId {
                let tempJob = journalistStoryModal(dict: job)
                self.jobFunctionalAreaId.append(tempJob)
            }
        }
        if let jobQualificationId = dict[Keys.jobQualificationId.stringValue] as? Dictionary<String,AnyObject>{
            self.jobQualificationId = journalistStoryModal(dict: jobQualificationId)
        }
        if let jobCategoryId = dict[Keys.jobCategoryId.stringValue] as? Dictionary<String,AnyObject>{
            self.jobCategoryId = journalistStoryModal(dict: jobCategoryId)
        }
        if let jobRoleId = dict[Keys.jobRoleId.stringValue] as? Dictionary<String,AnyObject>{
            self.jobRoleId = journalistStoryModal(dict: jobRoleId)
        }
        
        if let jobKeywordName = dict[Keys.jobKeywordName.stringValue] as? [String] {
            self.jobKeywordName = jobKeywordName
        }
        
        if let workExperience = dict[Keys.workExperience.stringValue] as? String {
            self.workExperience = workExperience
        }
        
        if let expectedSalary = dict[Keys.expectedSalary.stringValue] as? String {
            self.expectedSalary = expectedSalary
        }
        
        if let employementType = dict[Keys.employementType.stringValue] as? String {
            self.employementType = employementType
        }
        
        if let jobDescription = dict[Keys.jobDescription.stringValue] as? String {
            self.jobDescription = jobDescription
        }
        
        if let favouriteStatus = dict[Keys.favouriteStatus.stringValue] as? Int {
            self.favouriteStatus = favouriteStatus
        }
        
        if let soldOut = dict[Keys.soldOut.stringValue] as? Int{
            self.soldOut = soldOut
        }
        if let totalAveargeReview = dict[Keys.totalAveargeReview.stringValue] as? Double{
            self.totalAveargeReview = totalAveargeReview
        }
        if let reviewCount = dict[Keys.reviewCount.stringValue] as? Int{
            self.reviewCount = reviewCount
        }
        
        
        
        if let amount = dict[Keys.amount.stringValue] as? String {
            self.amount = amount
        }
        if let paymentMode = dict[Keys.paymentMode.stringValue] as? String {
            self.paymentMode = paymentMode
        }
        if let transactionId = dict[Keys.transactionId.stringValue] as? String {
            self.transactionId = transactionId
        }
        if let myContent = dict[Keys.myContent.stringValue] as? Dictionary<String,AnyObject>{
            self.myContent = journalistStoryModal(dict: myContent)
        }
        
        if let spellingAndGrammar = dict[Keys.spellingAndGrammar.stringValue] as? Int{
            self.spellingAndGrammar = spellingAndGrammar
        }
        
        if let consistencyAndClarity = dict[Keys.consistencyAndClarity.stringValue] as? Int{
            self.consistencyAndClarity = consistencyAndClarity
        }
        
        if let fairObjectiveAndAccuracy = dict[Keys.fairObjectiveAndAccuracy.stringValue] as? Int{
            self.fairObjectiveAndAccuracy = fairObjectiveAndAccuracy
        }
        
        if let obscenitiesProfanitiesAndVulgarities = dict[Keys.obscenitiesProfanitiesAndVulgarities.stringValue] as? Int{
            self.obscenitiesProfanitiesAndVulgarities = obscenitiesProfanitiesAndVulgarities
        }
        
        if let plagiarism = dict[Keys.plagiarism.stringValue] as? Int{
            self.plagiarism = plagiarism
        }
        
        if let mediahouseComment = dict[Keys.mediahouseComment.stringValue] as? String {
            self.mediahouseComment = mediahouseComment
        }
        if let journalistComment = dict[Keys.journalistComment.stringValue] as? String {
            self.journalistComment = journalistComment
        }
        
        if let averageRating = dict[Keys.averageRating.stringValue] as? String{
            self.averageRating = averageRating
        }
        
        if let storyId = dict[Keys.storyId.stringValue] as? String {
            self.storyId = storyId
        }
        
        if let userId = dict[Keys.userId.stringValue] as? Dictionary<String,AnyObject>{
            self.userId = journalistStoryModal(dict: userId)
        }
        if let collaborationGroupName = dict[Keys.collaborationGroupName.stringValue] as? String {
            self.collaborationGroupName = collaborationGroupName
        }
        if let members = dict[Keys.members.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for job in members {
                let tempJob = journalistStoryModal(dict: job)
                self.members.append(tempJob)
            }
        }
        
        if let collaborationGroupProfile = dict[Keys.collaborationGroupProfile.stringValue] as? String {
            self.collaborationGroupProfile = collaborationGroupProfile
        }
        
        
        if let realCurrencyCode = dict[Keys.realCurrencyCode.stringValue] as? String {
            self.realCurrencyCode = realCurrencyCode
        }
        
        if let realCurrencyName = dict[Keys.realCurrencyName.stringValue] as? String {
            self.realCurrencyName = realCurrencyName
        }
        
        if let realPrice = dict[Keys.realPrice.stringValue] as? String {
            self.realPrice = realPrice
        }
        
        if let message = dict[Keys.message.stringValue] as? String {
            self.message = message
        }
        if let messageType = dict[Keys.messageType.stringValue] as? String {
            self.messageType = messageType
        }
        
        if let realBiddingPrice = dict[Keys.realBiddingPrice.stringValue] as? String {
            self.realBiddingPrice = realBiddingPrice
        }
        
        if let ethicsCommitteId = dict[Keys.ethicsCommitteId.stringValue] as? Dictionary<String,AnyObject>{
            self.ethicsCommitteId = journalistStoryModal(dict: ethicsCommitteId)
        }

        
        
        super.init()
    }
    
}


class journalistStoryModal: NSObject {
    enum Keys: String, CodingKey {
        case userType = "userType"
        case id = "_id"
        case profilePic = "profilePic"
        case firstName = "firstName"
        case lastName = "lastName"
        
        case categoryName = "categoryName"
        case thumbnale = "thumbnale"
        case thumbnaleNote = "thumbnaleNote"
        case video = "video"
        case videoNote = "videoNote"
        case text = "text"
        case textNote = "textNote"
        case Image = "Image"
        case imageNote = "imageNote"
        case doc = "doc"
        case docNote = "docNote"
        case audio = "audio"
        case audioNote = "audioNote"
        case organizationName = "organizationName"
        case middleName = "middleName"
        case jobFunctionalAreaName = "jobFunctionalAreaName"
        case jobQualificationName = "jobQualificationName"
        case jobCategoryName = "jobCategoryName"
        case jobRoleName = "jobRoleName"
        
        case logo = "logo"
        
        case contentOriginalName = "contentOriginalName"
        case contentDuplicateName = "contentDuplicateName"
        
        case langCode = "langCode"
        case pinCode = "pinCode"
        case country = "country"
        case state = "state"
        
        case journalistId = "journalistId"
        case type = "type"
        case status = "status"
        
        case filename = "filename"
        
        
    }
    
    var userType = ""
    var id = ""
    var profilePic = ""
    var firstName = ""
    var lastName = ""
    
    var categoryName = ""
    var thumbnale = ""
    var thumbnaleNote = ""
    var video = ""
    var videoNote = ""
    var text = ""
    var textNote = ""
    var Image = ""
    var imageNote = ""
    var doc = ""
    var docNote = ""
    var audio = ""
    var audioNote = ""
    var organizationName = ""
    var middleName = ""
    var jobFunctionalAreaName = ""
    var jobQualificationName = ""
    var jobCategoryName = ""
    var jobRoleName = ""
    
    var logo = ""
    
    var contentOriginalName = ""
    var contentDuplicateName = ""
    
    var langCode = ""
    var pinCode = ""
    var country = CountryList()
    var state = StateList()
    
    var journalistId = journalistIDModal()
    var type = ""
    var status : Int = 0
    var filename = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let categoryName = dict[Keys.categoryName.stringValue] as? String {
            self.categoryName = categoryName
        }
        if let thumbnale = dict[Keys.thumbnale.stringValue] as? String {
            self.thumbnale = thumbnale
        }
        if let thumbnaleNote = dict[Keys.thumbnaleNote.stringValue] as? String {
            self.thumbnaleNote = thumbnaleNote
        }
        if let video = dict[Keys.video.stringValue] as? String {
            self.video = video
        }
        if let videoNote = dict[Keys.videoNote.stringValue] as? String {
            self.videoNote = videoNote
        }
        if let textNote = dict[Keys.textNote.stringValue] as? String {
            self.textNote = textNote
        }
        if let Image = dict[Keys.Image.stringValue] as? String {
            self.Image = Image
        }
        if let imageNote = dict[Keys.imageNote.stringValue] as? String {
            self.imageNote = imageNote
        }
        if let doc = dict[Keys.doc.stringValue] as? String {
            self.doc = doc
        }
        if let docNote = dict[Keys.docNote.stringValue] as? String {
            self.docNote = docNote
        }
        if let audio = dict[Keys.audio.stringValue] as? String {
            self.audio = audio
        }
        if let organizationName = dict[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let jobFunctionalAreaName = dict[Keys.jobFunctionalAreaName.stringValue] as? String {
            self.jobFunctionalAreaName = jobFunctionalAreaName
        }
        if let jobQualificationName = dict[Keys.jobQualificationName.stringValue] as? String {
            self.jobQualificationName = jobQualificationName
        }
        if let jobCategoryName = dict[Keys.jobCategoryName.stringValue] as? String {
            self.jobCategoryName = jobCategoryName
        }
        if let jobRoleName = dict[Keys.jobRoleName.stringValue] as? String {
            self.jobRoleName = jobRoleName
        }
        
        if let logo = dict[Keys.logo.stringValue] as? String {
            self.logo = logo
        }
        
        if let contentOriginalName = dict[Keys.contentOriginalName.stringValue] as? String {
            self.contentOriginalName = contentOriginalName
        }
        if let contentDuplicateName = dict[Keys.contentDuplicateName.stringValue] as? String {
            self.contentDuplicateName = contentDuplicateName
        }
        
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        
        if let pinCode = dict[Keys.pinCode.stringValue] as? String {
            self.pinCode = pinCode
        }
        
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        
        if let type = dict[Keys.type.stringValue] as? String {
            self.type = type
        }
        if let journalistId = dict[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistIDModal(dict: journalistId)
        }
        if let status = dict[Keys.status.stringValue] as? Int{
            self.status = status
        }
        
        if let filename = dict[Keys.filename.stringValue] as? String {
            self.filename = filename
        }
        
        super.init()
    }
    
}

class journalistIDModal: NSObject {
    enum Keys: String, CodingKey {
        case id = "_id"
        case middleName = "middleName"
        case profilePic = "profilePic"
        case firstName = "firstName"
        case lastName = "lastName"
        case langCode = "langCode"
        case state = "state"
        case userType = "userType"
        
    }
    
    var id = "_id"
    var middleName = ""
    var profilePic = ""
    var firstName = ""
    var lastName = ""
    var langCode = ""
    var state = StateList()
    var userType = ""
    
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        
        
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        
        
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        
        
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        
        super.init()
    }
    
}



class listStory: NSObject {
    enum Keys: String, CodingKey {
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [storyListModal]()
    var total : Int = 0
    var limit : Int = 0
    var page : Int = 0
    var pages : Int = 0
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let uploadAudios = dict[Keys.docs.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in uploadAudios {
                let tempArea = storyListModal(dict: area)
                self.docs.append(tempArea)
            }
        }
        
        if let total = dict[Keys.total.stringValue] as? Int{
            self.total = total
        }
        
        if let limit = dict[Keys.limit.stringValue] as? Int{
            self.limit = limit
        }
        
        if let page = dict[Keys.page.stringValue] as? Int{
            self.page = page
        }
        
        if let pages = dict[Keys.pages.stringValue] as? Int{
            self.pages = pages
        }
        
        super.init()
    }
    
}

class earningModal: NSObject {
    enum Keys: String, CodingKey {
        case totalEarning = "totalEarning"
        case currency = "currency"
        case storyData = "storyData"
    }
    
    var totalEarning: Int = 0
    var currency = ""
    var storyData = [storyListModal]()
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        
        if let totalEarning = dict[Keys.totalEarning.stringValue] as? Int{
            self.totalEarning = totalEarning
        }
        
        if let earningData = dict[Keys.storyData.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for earn in earningData {
                let tempEarn = storyListModal(dict: earn)
                self.storyData.append(tempEarn)
            }
        }
        
        super.init()
    }
    
}

class earningModalByStoryID: NSObject {
    enum Keys: String, CodingKey {
        case totalEarning = "totalEarning"
        case currency = "currency"
        case storyData = "storyData"
        case mediahouseData = "mediahouseData"
    }
    
    var totalEarning: Int = 0
    var currency = ""
    var storyData = storyListModal()
    var mediahouseData = [storyListModal]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        
        if let totalEarning = dict[Keys.totalEarning.stringValue] as? Int{
            self.totalEarning = totalEarning
        }
        
        
        if let mediaaHouseData = dict[Keys.mediahouseData.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for earn in mediaaHouseData {
                let tempEarn = storyListModal(dict: earn)
                self.mediahouseData.append(tempEarn)
            }
        }
        
        if let storyData = dict[Keys.storyData.stringValue] as? Dictionary<String,AnyObject>{
            self.storyData = storyListModal(dict: storyData)
        }
        
        
        super.init()
    }
    
}


class contentModal: NSObject {
    enum Keys: String, CodingKey {
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
        case docs = "docs"
    }
    
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    var docs = [storyListModal]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let total = dict[Keys.total.stringValue] as? Int{
            self.total = total
        }
        if let limit = dict[Keys.limit.stringValue] as? Int{
            self.limit = limit
        }
        if let page = dict[Keys.page.stringValue] as? Int{
            self.page = page
        }
        if let pages = dict[Keys.pages.stringValue] as? Int{
            self.pages = pages
        }
        
        if let contentData = dict[Keys.docs.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in contentData {
                let tempData = storyListModal(dict: data)
                self.docs.append(tempData)
            }
        }
        
        super.init()
    }
    
}



class invitejournalistListModdal: NSObject {
    enum Keys: String, CodingKey {
        
        case middleName = "middleName"
        case id = "_id"
        case profilePic = "profilePic"
        case emailId = "emailId"
        case firstName = "firstName"
        case lastName = "lastName"
        case langCode = "langCode"
        case state = "state"
        
    }
    
    var middleName = ""
    var id = ""
    var profilePic = ""
    var emailId = ""
    var firstName = ""
    var lastName = ""
    var langCode = ""
    var state = StateList()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        
        
        super.init()
    }
    
}


class newRequestModal: NSObject {
    enum Keys: String, CodingKey {
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
        case docs = "docs"
    }
    
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    var docs = [storyListModal]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let total = dict[Keys.total.stringValue] as? Int{
            self.total = total
        }
        if let limit = dict[Keys.limit.stringValue] as? Int{
            self.limit = limit
        }
        if let page = dict[Keys.page.stringValue] as? Int{
            self.page = page
        }
        if let pages = dict[Keys.pages.stringValue] as? Int{
            self.pages = pages
        }
        if let contentData = dict[Keys.docs.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in contentData {
                let tempData = storyListModal(dict: data)
                self.docs.append(tempData)
            }
        }
        
        super.init()
    }
    
}


class collobrationModal: NSObject {
    enum Keys: String, CodingKey {
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
        case docs = "docs"
    }
    
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    var docs = [collobrationListModal]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let total = dict[Keys.total.stringValue] as? Int{
            self.total = total
        }
        if let limit = dict[Keys.limit.stringValue] as? Int{
            self.limit = limit
        }
        if let page = dict[Keys.page.stringValue] as? Int{
            self.page = page
        }
        if let pages = dict[Keys.pages.stringValue] as? Int{
            self.pages = pages
        }
        
        if let contentData = dict[Keys.docs.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in contentData {
                let tempData = collobrationListModal(dict: data)
                self.docs.append(tempData)
            }
        }
        
        super.init()
    }
    
}

class collobrationListModal: NSObject {
    enum Keys: String, CodingKey {
        case id = "_id"
        case langCode = "langCode"
        case auctionBiddingPrice = "auctionBiddingPrice"
        case currency = "currency"
        case price = "price"
        case ID = "id"
        case realCurrencyName = "realCurrencyName"
        case realCurrencyCode = "realCurrencyCode"
        case realPrice = "realPrice"
        case realBiddingPrice = "realBiddingPrice"
        case storyId = "storyId"
        
    }
    var id = "_id"
    var langCode = "langCode"
    var auctionBiddingPrice = "auctionBiddingPrice"
    var currency = "currency"
    var price = "price"
    var ID = "id"
    var realCurrencyName = "realCurrencyName"
    var realCurrencyCode = "realCurrencyCode"
    var realPrice = "realPrice"
    var realBiddingPrice = "realBiddingPrice"
    var storyId = storyListModal()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let auctionBiddingPrice = dict[Keys.auctionBiddingPrice.stringValue] as? String {
            self.auctionBiddingPrice = auctionBiddingPrice
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let ID = dict[Keys.ID.stringValue] as? String {
            self.ID = ID
        }
        if let realCurrencyName = dict[Keys.realCurrencyName.stringValue] as? String {
            self.realCurrencyName = realCurrencyName
        }
        if let realCurrencyCode = dict[Keys.realCurrencyCode.stringValue] as? String {
            self.realCurrencyCode = realCurrencyCode
        }
        if let realPrice = dict[Keys.realPrice.stringValue] as? String {
            self.realPrice = realPrice
        }
        if let realBiddingPrice = dict[Keys.realBiddingPrice.stringValue] as? String {
            self.realBiddingPrice = realBiddingPrice
        }
        if let storyId = dict[Keys.storyId.stringValue] as? Dictionary<String,AnyObject>{
            self.storyId = storyListModal(dict: storyId)
        }
        
        
        super.init()
    }
    
}

class paymentsModal: NSObject {
    enum Keys: String, CodingKey {
        case activePlans = "activePlans"
        case expriePlans = "expriePlans"
        case allPlan = "allPlan"
    }
    var activePlans = [plansModal]()
    var expriePlans = [plansModal]()
    var allPlan = [plansModal]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let activePlans = dict[Keys.activePlans.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in activePlans {
                let tempData = plansModal(dict: data)
                self.activePlans.append(tempData)
            }
        }
        
        if let expriePlans = dict[Keys.expriePlans.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in expriePlans {
                let tempData = plansModal(dict: data)
                self.expriePlans.append(tempData)
            }
        }
        
        if let allPlan = dict[Keys.allPlan.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for data in allPlan {
                let tempData = plansModal(dict: data)
                self.allPlan.append(tempData)
            }
        }
        
        
        super.init()
    }
    
}



class plansModal: NSObject {
    enum Keys: String, CodingKey {
        
        case mediahouseId = "mediahouseId"
        case journalistId = "journalistId"
        case membershipId = "membershipId"
        case transactionId = "transactionId"
        case amount = "amount"
        case paymentMode = "paymentMode"
        case id = "_id"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case expiryTime = "expiryTime"
        
        case status = "status"
        case membershipName = "membershipName"
        case membershipPrice = "membershipPrice"
        case membershipDescription = "membershipDescription"
        case membershipDuration = "membershipDuration"
        
    }
    
    var mediahouseId = ""
    var journalistId = ""
    var membershipId = memberShipModal()
    var transactionId = ""
    var amount = ""
    var paymentMode = ""
    var id = ""
    var createdAt = ""
    var updatedAt = ""
    var expiryTime = ""
    
    var status : Int = 0
    var membershipName = ""
    var membershipPrice = ""
    var membershipDescription = ""
    var membershipDuration = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let journalistId = dict[Keys.journalistId.stringValue] as? String {
            self.journalistId = journalistId
        }
        if let membershipId = dict[Keys.membershipId.stringValue] as? Dictionary<String,AnyObject>{
            self.membershipId = memberShipModal(dict: membershipId)
        }
        
        if let transactionId = dict[Keys.transactionId.stringValue] as? String {
            self.transactionId = transactionId
        }
        if let amount = dict[Keys.amount.stringValue] as? String {
            self.amount = amount
        }
        if let paymentMode = dict[Keys.paymentMode.stringValue] as? String {
            self.paymentMode = paymentMode
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let status = dict[Keys.status.stringValue] as? Int{
            self.status = status
        }
        if let membershipName = dict[Keys.membershipName.stringValue] as? String {
            self.membershipName = membershipName
        }
        if let membershipPrice = dict[Keys.membershipPrice.stringValue] as? String {
            self.membershipPrice = membershipPrice
        }
        if let membershipDescription = dict[Keys.membershipDescription.stringValue] as? String {
            self.membershipDescription = membershipDescription
        }
        if let membershipDuration = dict[Keys.membershipDuration.stringValue] as? String {
            self.membershipDuration = membershipDuration
        }
        if let expiryTime = dict[Keys.expiryTime.stringValue] as? String {
            self.expiryTime = expiryTime
        }
        super.init()
    }
    
}



class memberShipModal: NSObject {
    enum Keys: String, CodingKey {
        
        case id = "_id"
        case membershipName = "membershipName"
        case membershipPrice = "membershipPrice"
        case membershipDuration = "membershipDuration"
        
    }
    var id = ""
    var membershipName = ""
    var membershipPrice = ""
    var membershipDuration = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let membershipName = dict[Keys.membershipName.stringValue] as? String {
            self.membershipName = membershipName
        }
        
        if let membershipPrice = dict[Keys.membershipPrice.stringValue] as? String {
            self.membershipPrice = membershipPrice
        }
        
        if let membershipDuration = dict[Keys.membershipDuration.stringValue] as? String {
            self.membershipDuration = membershipDuration
        }
        
        
        super.init()
    }
    
}


class faqModal: NSObject {
    enum Keys: String, CodingKey {
        case status = "status"
        case id = "_id"
        case question = "question"
        case answer = "answer"
        case userType = "userType"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        
    }
    var status : Int = 0
    var id = ""
    var question = ""
    var answer = ""
    var userType = ""
    var createdAt = ""
    var updatedAt = ""

    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let question = dict[Keys.question.stringValue] as? String {
            self.question = question
        }
        if let answer = dict[Keys.answer.stringValue] as? String {
            self.answer = answer
        }
        if let userType = dict[Keys.userType.stringValue] as? String {
            self.userType = userType
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        super.init()
    }
    
}


class registrationFeePlansListModal: NSObject {
    enum Keys: String, CodingKey {
        

        case status = "status"
        case id = "_id"
        case name = "name"
        case price = "price"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
                
    }
    
    var status = 0
    var id = ""
    var name = ""
    var price = ""
    var createdAt = ""
    var updatedAt = ""

    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let name = dict[Keys.name.stringValue] as? String {
            self.name = name
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        
        super.init()
    }
    
}





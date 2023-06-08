//
//  MediaHouseStoryListModel.swift
//  MediaBazar
//
//  Created by deepak Kumar on 01/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation

class MediaStroyModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
        case ethicMember = "ethicMember"
        case Head = "Head"
    }
    
    var docs = [MediaStroyDocsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    var ethicMember = [MediaStroyDocsModel]()
    var Head = MediaStroyDocsModel()
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = MediaStroyDocsModel(dict: item)
                print("\(somedocs)")
                self.docs.append(somedocs)
            }
        }
        if let ethicMember = dictionary[Keys.ethicMember.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.ethicMember.removeAll()
            for item in ethicMember{
                let somedocs = MediaStroyDocsModel(dict: item)
                print("\(somedocs)")
                self.ethicMember.append(somedocs)
            }
        }
        if let Head = dictionary[Keys.Head.stringValue] as? Dictionary<String,AnyObject>{
            self.Head = MediaStroyDocsModel(dict: Head)
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
        super.init()
    }
    
    
}

//---- MediaStroyDocsModel ------

class MediaStroyDocsModel: NSObject{
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
        
        case realCurrencyCode = "realCurrencyCode"
        case realCurrencyName = "realCurrencyName"
        case realPrice = "realPrice"
        case realBiddingPrice = "realBiddingPrice"
        case lastBiddingPrice = "lastBiddingPrice"
        case auctionBiddingPrice = "auctionBiddingPrice"
        case auctionExpriyTime  = "auctionExpriyTime"
        case reviewStatus = "reviewStatus"
        case reviewCount = "reviewCount"
        case soldOut = "soldOut"
        case totalAveargeReview = "totalAveargeReview"
        case invoice = "invoice"
        case amount = "amount"
        case paymentMode = "paymentMode"
        case transactionId = "transactionId"
        
        case profilePic = "profilePic"
        case middleName = "middleName"
        case otp = "otp"//
        case verifyOtp = "verifyOtp"
        case profileStatus = "profileStatus"
        case reviewComplaint = "reviewComplaint"//
        case pendingComplaint = "pendingComplaint"//
        case accessWrites = "accessWrites"
        case pincode = "pincode"
        case profession = "profession"
        case skills = "skills"//array
        //case description = "description"
        case salary = "salary"
        case emailId = "emailId"
        case firstName = "firstName"
        case lastName = "lastName"
        case password = "password"
        case accountType = "accountType"
        case facebookLink = "facebookLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
        case mailingAddress = "mailingAddress"
        case phoneCode = "phoneCode"
        case mobileNumber = "mobileNumber"
        case shortVideo = "shortVideo"
        case descDetails = "description"
        case biddingPurchaseAmount = "biddingPurchaseAmount"
        
        
        
    }
    
    var journalistId = journalistStoryModal()
    var categoryId = journalistStoryModal()
    var storyCategory = ""
    var keywordName = [String]()
    var langCode = ""
    var storyText = ""
    var currency = ""
    var price = 0
    var collaborationGroupId = ""
    var purchasingLimit = ""
    var auctionDuration = ""
    var status = 0
    var typeStatus = 0
    var fileCount = 0
    var collaboratedStatus = ""
    var favouriteStatus = 0
    var id = ""
    var headLine = ""
    var briefDescription = ""
    var date = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    var stepCount : Int = 0
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
    
    var jobFunctionalAreaId = [journalistStoryModal]()
    var jobQualificationId = journalistStoryModal()
    var jobCategoryId = journalistStoryModal()
    var jobKeywordName = [String]()
    var jobRoleId = journalistStoryModal()
    var workExperience = ""
    var expectedSalary = ""
    var employementType = ""
    var jobDescription = ""
    
    var realCurrencyCode = ""
    var realCurrencyName = ""
    var realPrice = ""
    var realBiddingPrice = ""
    var lastBiddingPrice = ""
    var auctionBiddingPrice = 0
    var auctionExpriyTime = ""
    var reviewStatus = ""
    var reviewCount = 0
    var soldOut = 0
    var totalAveargeReview = 0.0
    var invoice = ""
    var amount = ""
    var paymentMode = ""
    var transactionId = ""
    
    var profilePic = ""
    var middleName = ""
    var otp = 0
    var verifyOtp = ""
    var profileStatus = ""
    var reviewComplaint = 0
    var pendingComplaint = 0
    var accessWrites = ""
    var pincode = ""
    var profession = ""
    var skills = [String]()
    //var description = ""
    var salary = ""
    var emailId = ""
    var firstName = ""
    var lastName = ""
    var password = ""
    var accountType = ""
    var facebookLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    var mailingAddress = ""
    var phoneCode = ""
    var mobileNumber = ""
    var shortVideo = ""
    var descDetails = ""
    var biddingPurchaseAmount = 0
    
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
        if let price = dict[Keys.price.stringValue] as? Int {
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
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let typeStatus = dict[Keys.typeStatus.stringValue] as? Int {
            self.typeStatus = typeStatus
        }
        if let fileCount = dict[Keys.fileCount.stringValue] as? Int {
            self.fileCount = fileCount
        }
        if let collaboratedStatus = dict[Keys.collaboratedStatus.stringValue] as? String {
            self.collaboratedStatus = collaboratedStatus
        }
        if let favouriteStatus = dict[Keys.favouriteStatus.stringValue] as? Int {
            self.favouriteStatus = favouriteStatus
        }
        if let collaboratedStatus = dict[Keys.collaboratedStatus.stringValue] as? String {
            self.collaboratedStatus = collaboratedStatus
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
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
        if let stepCount = dict[Keys.stepCount.stringValue] as? Int {
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
        if let headLine = dict[Keys.headLine.stringValue] as? String {
            self.headLine = headLine
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
        if let realCurrencyCode = dict[Keys.realCurrencyCode.stringValue] as? String {
            self.realCurrencyCode = realCurrencyCode
        }
        if let realCurrencyName = dict[Keys.realCurrencyName.stringValue] as? String {
            self.realCurrencyName = realCurrencyName
        }
        if let realPrice = dict[Keys.realPrice.stringValue] as? String {
            self.realPrice = realPrice
        }
        if let realBiddingPrice = dict[Keys.realBiddingPrice.stringValue] as? String {
            self.realBiddingPrice = realBiddingPrice
        }
        if let lastBiddingPrice = dict[Keys.lastBiddingPrice.stringValue] as? String {
            self.lastBiddingPrice = lastBiddingPrice
        }
        if let auctionBiddingPrice = dict[Keys.auctionBiddingPrice.stringValue] as? Int {
            self.auctionBiddingPrice = auctionBiddingPrice
        }
        if let reviewStatus = dict[Keys.reviewStatus.stringValue] as? String {
            self.reviewStatus = reviewStatus
        }
        if let auctionExpriyTime = dict[Keys.auctionExpriyTime.stringValue] as? String {
            self.auctionExpriyTime = auctionExpriyTime
        }
        if let reviewCount = dict[Keys.reviewCount.stringValue] as? Int {
            self.reviewCount = reviewCount
        }
        if let jobDescription = dict[Keys.jobDescription.stringValue] as? String {
            self.jobDescription = jobDescription
        }
        if let soldOut = dict[Keys.soldOut.stringValue] as? Int {
            self.soldOut = soldOut
        }
        if let totalAveargeReview = dict[Keys.totalAveargeReview.stringValue] as? Double {
            self.totalAveargeReview = totalAveargeReview
        }
        if let invoice = dict[Keys.invoice.stringValue] as? String {
            self.invoice = invoice
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
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let middleName = dict[Keys.middleName.stringValue] as? String {
            self.middleName = middleName
        }
        if let otp = dict[Keys.otp.stringValue] as? Int {
            self.otp = otp
        }
        if let verifyOtp = dict[Keys.verifyOtp.stringValue] as? String {
            self.verifyOtp = verifyOtp
        }
        if let profileStatus = dict[Keys.profileStatus.stringValue] as? String {
            self.profileStatus = profileStatus
        }
        if let reviewComplaint = dict[Keys.reviewComplaint.stringValue] as? Int {
            self.reviewComplaint = reviewComplaint
        }
        if let pendingComplaint = dict[Keys.pendingComplaint.stringValue] as? Int {
            self.pendingComplaint = pendingComplaint
        }
        if let accessWrites = dict[Keys.accessWrites.stringValue] as? String {
            self.accessWrites = accessWrites
        }
        if let pincode = dict[Keys.pincode.stringValue] as? String {
            self.pincode = pincode
        }
        if let profession = dict[Keys.profession.stringValue] as? String {
            self.profession = profession
        }
        if let skills = dict[Keys.skills.stringValue] as? [String] {
            self.skills = skills
        }
        //        if let description = dict[Keys.description.stringValue] as? String {
        //            self.description = description
        //        }
        if let salary = dict[Keys.salary.stringValue] as? String {
            self.salary = salary
        }
        if let emailId = dict[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let firstName = dict[Keys.firstName.stringValue] as? String {
            self.firstName = firstName
        }
        if let lastName = dict[Keys.lastName.stringValue] as? String {
            self.lastName = lastName
        }
        if let password = dict[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let accountType = dict[Keys.accountType.stringValue] as? String {
            self.accountType = accountType
        }
        if let profilePic = dict[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let facebookLink = dict[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
        }
        if let snapChatLink = dict[Keys.snapChatLink.stringValue] as? String {
            self.snapChatLink = snapChatLink
        }
        if let twitterLink = dict[Keys.twitterLink.stringValue] as? String {
            self.twitterLink = twitterLink
        }
        if let youtubeLink = dict[Keys.youtubeLink.stringValue] as? String {
            self.youtubeLink = youtubeLink
        }
        if let instagramLink = dict[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dict[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        if let mailingAddress = dict[Keys.mailingAddress.stringValue] as? String {
            self.mailingAddress = mailingAddress
        }
        if let phoneCode = dict[Keys.phoneCode.stringValue] as? String {
            self.phoneCode = phoneCode
        }
        if let mobileNumber = dict[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let shortVideo = dict[Keys.shortVideo.stringValue] as? String {
            self.shortVideo = shortVideo
        }
        if let descDetails = dict[Keys.descDetails.stringValue] as? String {
            self.descDetails = descDetails
        }
        if let biddingPurchaseAmount = dict[Keys.biddingPurchaseAmount.stringValue] as? Int {
            self.biddingPurchaseAmount = biddingPurchaseAmount
        }
        super.init()
    }
}



//----------FavoriteModel---------

class AddTofavoriteModel: NSObject{
    
    enum Keys: String, CodingKey{
        
        case journalistId = "journalistId"
        case mediahouseId = "mediahouseId"
        case storyId = "storyId"
        case id = "_id"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
        
    }
    
    var journalistId = ""
    var mediahouseId = ""
    var storyId = ""
    var id = ""
    var status = ""
    var createdAt = ""
    var updatedAt = ""
    var vId = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let journalistId = dictionary[Keys.journalistId.stringValue] as? String {
            self.journalistId = journalistId
        }
        if let mediahouseId = dictionary[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let storyId = dictionary[Keys.storyId.stringValue] as? String {
            self.storyId = storyId
        }
        if let id = dictionary[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let status = dictionary[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dictionary[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        super.init()
    }
}

//----------CompanyInfoModel---------

class CompanyInfoModel: NSObject{
    
    enum Keys: String, CodingKey{
        
        case nameCode = "nameCode"
        case phoneCode = "phoneCode"
        case designationId = "designationId"
        case profilePic = "profilePic"
        case organizationName = "organizationName"
        case mediahouseTypeId = "mediahouseTypeId"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case mobileNumber = "mobileNumber"
        case otp = "otp"
        case verifyOtp = "verifyOtp"
        case areaOfInterest = "areaOfInterest"
        case targetAudience = "targetAudience"
        case frequencyId = "frequencyId"
        case keywordName = "keywordName"
        case userType = "userType"
        case status = "status"
        case id = "_id"
        case logo = "logo"
        case emailId = "emailId"
        case langCode = "langCode"
        case password = "password"
        case pinCode = "pinCode"
        case shortBio = "shortBio"
        case country = "country"
        case city = "city"
        case state = "state"
        case mailingAddress = "mailingAddress"
        case stepCount = "stepCount"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case v = "__v"
        case audience = "audience"
        case website = "website"
        case facebookLink = "facebookLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
    }
    
    var nameCode = ""
    var phoneCode = ""
    var designationId = ""
    var profilePic = ""
    var organizationName = ""
    var mediahouseTypeId = ""
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var mobileNumber = ""
    var otp = ""
    var verifyOtp = ""
    var areaOfInterest = [categoryTypeModal]()
    var targetAudience = [categoryTypeModal]()
    var frequencyId = ""
    var keywordName = [String]()
    var userType = ""
    var status = ""
    var id = ""
    var logo = ""
    var emailId = ""
    var langCode = ""
    var password = ""
    var pinCode = ""
    var shortBio = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    var mailingAddress = ""
    var stepCount = ""
    var createdAt = ""
    var updatedAt = ""
    var v = ""
    var audience = ""
    var website = ""
    var facebookLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let nameCode = dictionary[Keys.nameCode.stringValue] as? String {
            self.nameCode = nameCode
        }
        if let phoneCode = dictionary[Keys.phoneCode.stringValue] as? String {
            self.phoneCode = phoneCode
        }
        if let designationId = dictionary[Keys.designationId.stringValue] as? String {
            self.designationId = designationId
        }
        if let profilePic = dictionary[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let organizationName = dictionary[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
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
        if let mobileNumber = dictionary[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let otp = dictionary[Keys.otp.stringValue] as? String {
            self.otp = otp
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? String {
            self.verifyOtp = verifyOtp
        }
        if let areaOfInterest = dictionary[Keys.areaOfInterest.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in areaOfInterest {
                let tempArea = categoryTypeModal(dict: area)
                self.areaOfInterest.append(tempArea)
            }
        }
        if let targetAudience = dictionary[Keys.targetAudience.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in targetAudience {
                let tempArea = categoryTypeModal(dict: area)
                self.targetAudience.append(tempArea)
            }
        }
        if let frequencyId = dictionary[Keys.frequencyId.stringValue] as? String {
            self.frequencyId = frequencyId
        }
        if let keywordName = dictionary[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
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
        if let logo = dictionary[Keys.logo.stringValue] as? String {
            self.logo = logo
        }
        if let emailId = dictionary[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let langCode = dictionary[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dictionary[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let pinCode = dictionary[Keys.pinCode.stringValue] as? String {
            self.pinCode = pinCode
        }
        if let shortBio = dictionary[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        if let mediahouseTypeId = dictionary[Keys.mediahouseTypeId.stringValue] as? String {
            self.mediahouseTypeId = mediahouseTypeId
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
        if let mailingAddress = dictionary[Keys.mailingAddress.stringValue] as? String {
            self.mailingAddress = mailingAddress
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let v = dictionary[Keys.v.stringValue] as? String {
            self.v = v
        }
        if let audience = dictionary[Keys.audience.stringValue] as? String {
            self.audience = audience
        }
        if let website = dictionary[Keys.website.stringValue] as? String {
            self.website = website
        }
        if let facebookLink = dictionary[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
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
        if let instagramLink = dictionary[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dictionary[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        super.init()
    }
}



//--------GetMediaProfileModel--------

class CompanyProfileModel: NSObject{
    
    enum Keys: String, CodingKey{
        
        case nameCode = "nameCode"
        case phoneCode = "phoneCode"
        case designationId = "designationId"
        case profilePic = "profilePic"
        case organizationName = "organizationName"
        case mediahouseTypeId = "mediahouseTypeId"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case mobileNumber = "mobileNumber"
        case otp = "otp"
        case verifyOtp = "verifyOtp"
        case areaOfInterest = "areaOfInterest"
        case targetAudience = "targetAudience"
        case frequencyId = "frequencyId"
        case keywordName = "keywordName"
        case userType = "userType"
        case status = "status"
        case id = "_id"
        case logo = "logo"
        case emailId = "emailId"
        case langCode = "langCode"
        case password = "password"
        case pinCode = "pinCode"
        case shortBio = "shortBio"
        case country = "country"
        case city = "city"
        case state = "state"
        case mailingAddress = "mailingAddress"
        case stepCount = "stepCount"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case v = "__v"
        case audience = "audience"
        case website = "website"
        case facebookLink = "facebookLink"
        case snapChatLink = "snapChatLink"
        case twitterLink = "twitterLink"
        case youtubeLink = "youtubeLink"
        case instagramLink = "instagramLink"
        case linkedinLink = "linkedinLink"
    }
    
    var nameCode = ""
    var phoneCode = 0
    var designationId = ""
    var profilePic = ""
    var organizationName = ""
    var mediahouseTypeId = MediaHouseTypeModel()
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var mobileNumber = ""
    var otp = ""
    var verifyOtp = ""
    var areaOfInterest = [categoryTypeModal]()
    var targetAudience = [categoryTypeModal]()
    var frequencyId = MediahouseFrequencyNameModel()
    var keywordName = [String]()
    var userType = ""
    var status = ""
    var id = ""
    var logo = ""
    var emailId = ""
    var langCode = ""
    var password = ""
    var pinCode = ""
    var shortBio = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    var mailingAddress = ""
    var stepCount = ""
    var createdAt = ""
    var updatedAt = ""
    var v = ""
    var audience = ""
    var website = ""
    var facebookLink = ""
    var snapChatLink = ""
    var twitterLink = ""
    var youtubeLink = ""
    var instagramLink = ""
    var linkedinLink = ""
    
    override init() {
        super.init()
    }
    
    init(dictionary:[String: AnyObject]) {
        
        if let nameCode = dictionary[Keys.nameCode.stringValue] as? String {
            self.nameCode = nameCode
        }
        if let phoneCode = dictionary[Keys.phoneCode.stringValue] as? Int {
            self.phoneCode = phoneCode
        }
        if let designationId = dictionary[Keys.designationId.stringValue] as? String {
            self.designationId = designationId
        }
        if let profilePic = dictionary[Keys.profilePic.stringValue] as? String {
            self.profilePic = profilePic
        }
        if let organizationName = dictionary[Keys.organizationName.stringValue] as? String {
            self.organizationName = organizationName
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
        if let mobileNumber = dictionary[Keys.mobileNumber.stringValue] as? String {
            self.mobileNumber = mobileNumber
        }
        if let otp = dictionary[Keys.otp.stringValue] as? String {
            self.otp = otp
        }
        if let verifyOtp = dictionary[Keys.verifyOtp.stringValue] as? String {
            self.verifyOtp = verifyOtp
        }
        if let areaOfInterest = dictionary[Keys.areaOfInterest.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in areaOfInterest {
                let tempArea = categoryTypeModal(dict: area)
                self.areaOfInterest.append(tempArea)
            }
        }
        if let targetAudience = dictionary[Keys.targetAudience.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in targetAudience {
                let tempArea = categoryTypeModal(dict: area)
                self.targetAudience.append(tempArea)
            }
        }
        if let frequencyId = dictionary[Keys.frequencyId.stringValue] as? Dictionary<String,AnyObject>{
            self.frequencyId = MediahouseFrequencyNameModel(dict: frequencyId)
        }
        if let keywordName = dictionary[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
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
        if let logo = dictionary[Keys.logo.stringValue] as? String {
            self.logo = logo
        }
        if let emailId = dictionary[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let langCode = dictionary[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let password = dictionary[Keys.password.stringValue] as? String {
            self.password = password
        }
        if let pinCode = dictionary[Keys.pinCode.stringValue] as? String {
            self.pinCode = pinCode
        }
        if let shortBio = dictionary[Keys.shortBio.stringValue] as? String {
            self.shortBio = shortBio
        }
        if let mediahouseTypeId = dictionary[Keys.mediahouseTypeId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseTypeId = MediaHouseTypeModel(dict: mediahouseTypeId)
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
        if let mailingAddress = dictionary[Keys.mailingAddress.stringValue] as? String {
            self.mailingAddress = mailingAddress
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let stepCount = dictionary[Keys.stepCount.stringValue] as? String {
            self.stepCount = stepCount
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let v = dictionary[Keys.v.stringValue] as? String {
            self.v = v
        }
        if let audience = dictionary[Keys.audience.stringValue] as? String {
            self.audience = audience
        }
        if let website = dictionary[Keys.website.stringValue] as? String {
            self.website = website
        }
        if let facebookLink = dictionary[Keys.facebookLink.stringValue] as? String {
            self.facebookLink = facebookLink
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
        if let instagramLink = dictionary[Keys.instagramLink.stringValue] as? String {
            self.instagramLink = instagramLink
        }
        if let linkedinLink = dictionary[Keys.linkedinLink.stringValue] as? String {
            self.linkedinLink = linkedinLink
        }
        super.init()
    }
}


//-----------MediaTypeModel---------
class MediaHouseTypeModel: NSObject {
    
    enum Keys: String, CodingKey {
        case Id = "_id"
        case mediahouseTypeName = "mediahouseTypeName"
    }
    
    var Id = ""
    var mediahouseTypeName = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let Id = dict[Keys.Id.stringValue] as? String {
            self.Id = Id
        }
        if let mediahouseTypeName = dict[Keys.mediahouseTypeName.stringValue] as? String {
            self.mediahouseTypeName = mediahouseTypeName
        }
        
        super.init()
    }
}


//-----------FrequencyModel---------
class MediahouseFrequencyNameModel: NSObject {
    
    enum Keys: String, CodingKey {
        case Id = "_id"
        case mediahouseFrequencyName = "mediahouseFrequencyName"
    }
    
    var Id = ""
    var mediahouseFrequencyName = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let Id = dict[Keys.Id.stringValue] as? String {
            self.Id = Id
        }
        if let mediahouseFrequencyName = dict[Keys.mediahouseFrequencyName.stringValue] as? String {
            self.mediahouseFrequencyName = mediahouseFrequencyName
        }
        
        super.init()
    }
}

//--------Favorite Doc Model
class FavoriteDocModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [FavoriteStroyDocsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = FavoriteStroyDocsModel(dict: item)
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
        super.init()
    }
    
}


//---- FavoriteStroyDocsModel ------

class FavoriteStroyDocsModel: NSObject{
    
    enum Keys: String, CodingKey {
        
        case journalistId = "journalistId"
        case status = "status"
        case ids = "_id"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case mediaHouseID = "mediahouseId"
        case vId = "__v"
        case storyId = "storyId"
        case auctionBiddingPrice = "auctionBiddingPrice"
        case currency = "currency"
        case realCurrencyCode = "realCurrencyCode"
        case realCurrencyName = "realCurrencyName"
        case realPrice = "realPrice"
        case realBiddingPrice = "realBiddingPrice"
        case id = "id"
        case price = "price"
        
        case invoice = "invoice"
        case keywordName = "keywordName"
        case amount = "amount"
        case paymentMode = "paymentMode"
        case transactionId = "transactionId"
        case headline = "headline"
        
    }
    
    var journalistId = ""
    var status = ""
    var id = ""
    var ids = ""
    var createdAt = ""
    var updatedAt = ""
    var mediaHouseID = ""
    var vId = 0
    var storyId = MediaStroyDocsModel()
    var auctionBiddingPrice = ""
    var currency = ""
    var realCurrencyCode = ""
    var realCurrencyName = ""
    var realPrice = ""
    var realBiddingPrice = ""
    var price = ""
    var keywordName = [String]()
    var invoice = ""
    var amount = ""
    var paymentMode = ""
    var transactionId = ""
    var headline = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? String {
            self.journalistId = journalistId
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let ids = dict[Keys.ids.stringValue] as? String {
            self.ids = ids
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let mediaHouseID = dict[Keys.mediaHouseID.stringValue] as? String {
            self.mediaHouseID = mediaHouseID
        }
        if let storyId = dict[Keys.storyId.stringValue] as? Dictionary<String,AnyObject>{
            self.storyId = MediaStroyDocsModel(dict: storyId)
        }
        if let vId = dict[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        if let auctionBiddingPrice = dict[Keys.auctionBiddingPrice.stringValue] as? String {
            self.auctionBiddingPrice = auctionBiddingPrice
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
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
        if let realBiddingPrice = dict[Keys.realBiddingPrice.stringValue] as? String {
            self.realBiddingPrice = realBiddingPrice
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let status = dict[Keys.status.stringValue] as? String {
            self.status = status
        }
        if let keywordName = dict[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
        }
        if let invoice = dict[Keys.invoice.stringValue] as? String {
            self.invoice = invoice
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
        if let headline = dict[Keys.headline.stringValue] as? String {
            self.headline = headline
        }
        super.init()
    }
}

//-----AssignmentListModel
class AssignmentListModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [AssignmentListDetailsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = AssignmentListDetailsModel(dict: item)
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
        super.init()
    }
}


//---- AssignmentListDetailsModel ------

class AssignmentListDetailsModel: NSObject{
    enum Keys: String, CodingKey {
        
        case journalistId = "journalistId"//
        case ids = "_id"
        case mediahouseId = "mediahouseId"
        case status = "status"
        case assignmentTitle = "assignmentTitle"
        case langCode = "langCode"
        case currency = "currency"
        case price = "price"
        case assignmentDescription = "assignmentDescription"
        case country = "country"
        case replyCount = "replyCount"
        case journalistReply = "journalistReply"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
        case id = "id"
        case journalistHeadline = "journalistAssignmentHeadline"
        case date = "date"
        case time = "time"
        case journalistDescription = "journalistAssignmentDescription"
        case keywordName = "keywordName"

        //    case city = "city"
        //    case state = "state"
        //    case live = "live"
        //    case purchaseStatus = "purchaseStatus"
        
        
    }
    
    var journalistId = journalistStoryModal()
    var ids = ""
    var mediahouseId = journalistStoryModal()
    var status = 0
    var assignmentTitle = ""
    var langCode = ""
    var currency = ""
    var price = ""
    var assignmentDescription = ""
    var country = CountryList()
    var replyCount = 0
    var journalistReply = [JournalistReplyModel]()
    var createdAt = ""
    var updatedAt = ""
    var vId = ""
    var id = ""
    var journalistHeadline = ""
    var date = ""
    var time = ""
    var journalistDescription = ""
    var keywordName = [String]()
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistStoryModal(dict: journalistId)
        }
        if let ids = dict[Keys.ids.stringValue] as? String {
            self.ids = ids
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseId = journalistStoryModal(dict: mediahouseId)
        }
        if let status = dict[Keys.status.stringValue] as? Int{
            self.status = status
        }
        if let assignmentTitle = dict[Keys.assignmentTitle.stringValue] as? String {
            self.assignmentTitle = assignmentTitle
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let replyCount = dict[Keys.replyCount.stringValue] as? Int{
            self.replyCount = replyCount
        }
        if let journalistReply = dict[Keys.journalistReply.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.journalistReply.removeAll()
            for item in journalistReply{
                let somedocs = JournalistReplyModel(dictionary: item)
                print("\(somedocs)")
                self.journalistReply.append(somedocs)
            }
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? String {
            self.vId = vId
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let assignmentDescription = dict[Keys.assignmentDescription.stringValue] as? String {
            self.assignmentDescription = assignmentDescription
        }
        if let journalistHeadline = dict[Keys.journalistHeadline.stringValue] as? String {
            self.journalistHeadline = journalistHeadline
        }
        if let date = dict[Keys.date.stringValue] as? String {
            self.date = date
        }
        if let time = dict[Keys.time.stringValue] as? String {
            self.time = time
        }
        if let journalistDescription = dict[Keys.journalistDescription.stringValue] as? String {
            self.journalistDescription = journalistDescription
        }
        
        if let keywordName = dict[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
        }

        super.init()
    }
    
}


//-----PostAssignmentModel-----
class PostAssignmentModel: NSObject {
    enum Keys: String, CodingKey{
        case mediahouseId = "mediahouseId"
        case status = "status"
        case ids = "_id"
        case assignmentTitle = "assignmentTitle"
        case langCode = "langCode"
        case currency = "currency"
        case price = "price"
        case assignmentDescription = "assignmentDescription"
        case country = "country"
        case replyCount = "replyCount"
        case journalistReply = "journalistReply"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
    }
    
    
    var mediahouseId = ""
    var status = 0
    var ids = ""
    var assignmentTitle = ""
    var langCode = ""
    var currency = ""
    var price = ""
    var assignmentDescription = ""
    var country = CountryList()
    var replyCount = 0
    var journalistReply = [String]()
    var createdAt = ""
    var updatedAt = ""
    var vId = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        if let journalistReply = dict[Keys.journalistReply.stringValue] as? [String] {
            self.journalistReply = journalistReply
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let ids = dict[Keys.ids.stringValue] as? String {
            self.ids = ids
        }
        if let assignmentTitle = dict[Keys.assignmentTitle.stringValue] as? String {
            self.assignmentTitle = assignmentTitle
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let price = dict[Keys.price.stringValue] as? String {
            self.price = price
        }
        if let assignmentTitle = dict[Keys.assignmentTitle.stringValue] as? String {
            self.assignmentTitle = assignmentTitle
        }
        if let assignmentDescription = dict[Keys.assignmentDescription.stringValue] as? String {
            self.assignmentDescription = assignmentDescription
        }
        if let replyCount = dict[Keys.replyCount.stringValue] as? Int {
            self.replyCount = replyCount
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? String {
            self.vId = vId
        }
        
        super.init()
    }
}


//-----CreatJobModel-----
class CreatJobModel: NSObject {
    enum Keys: String, CodingKey{
        
        case mediahouseId = "mediahouseId"
        case jobFunctionalAreaId = "jobFunctionalAreaId"
        case jobQualificationId = "jobQualificationId"
        case jobCategoryId = "jobCategoryId"
        case jobKeywordName = "jobKeywordName"
        case jobRoleId = "jobRoleId"
        case currency = "currency"
        case jobStatus = "jobStatus"
        case status = "status"
        case jobId = "_id"
        case workExperience = "workExperience"
        case expectedSalary = "expectedSalary"
        case employementType = "employementType"
        case jobDescription = "jobDescription"
        case country = "country"
        case city = "city"
        case state = "state"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
    }
    
    var mediahouseId = ""
    var jobFunctionalAreaId = [String]()
    var jobQualificationId = ""
    var jobCategoryId = ""
    var jobKeywordName = [String]()
    var jobRoleId = journalistStoryModal()
    var currency = ""
    var jobStatus = 0
    var status = 0
    var jobId = ""
    var workExperience = ""
    var expectedSalary = ""
    var employementType = ""
    var jobDescription = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    
    var createdAt = ""
    var updatedAt = ""
    var vId = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let jobQualificationId = dict[Keys.jobQualificationId.stringValue] as? String {
            self.jobQualificationId = jobQualificationId
        }
        if let jobCategoryId = dict[Keys.jobCategoryId.stringValue] as? String {
            self.jobCategoryId = jobCategoryId
        }
        if let jobRoleId = dict[Keys.jobRoleId.stringValue] as? Dictionary<String,AnyObject>{
            self.jobRoleId = journalistStoryModal(dict: jobRoleId)
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let jobStatus = dict[Keys.jobStatus.stringValue] as? Int {
            self.jobStatus = jobStatus
        }
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let jobId = dict[Keys.jobId.stringValue] as? String {
            self.jobId = jobId
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
        if let jobFunctionalAreaId = dict[Keys.jobFunctionalAreaId.stringValue] as? [String] {
            self.jobFunctionalAreaId = jobFunctionalAreaId
        }
        if let jobKeywordName = dict[Keys.jobKeywordName.stringValue] as? [String] {
            self.jobKeywordName = jobKeywordName
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
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? String {
            self.vId = vId
        }
        
        super.init()
    }
}



//-----GetJobModel-----
class GetJobModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [GetJobDetailsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = GetJobDetailsModel(dict: item)
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
        super.init()
    }
}


//-----CreatJobModel-----
class GetJobDetailsModel: NSObject {
    enum Keys: String, CodingKey{
        
        case mediahouseId = "mediahouseId"
        case jobFunctionalAreaId = "jobFunctionalAreaId"
        case jobQualificationId = "jobQualificationId"
        case jobCategoryId = "jobCategoryId"
        case jobKeywordName = "jobKeywordName"
        case jobRoleId = "jobRoleId"
        case currency = "currency"
        case jobStatus = "jobStatus"
        case status = "status"
        case jobId = "_id"
        case workExperience = "workExperience"
        case expectedSalary = "expectedSalary"
        case employementType = "employementType"
        case jobDescription = "jobDescription"
        case country = "country"
        case city = "city"
        case state = "state"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
    }
    
    var mediahouseId = journalistStoryModal()
    var jobFunctionalAreaId = [journalistStoryModal]()
    var jobQualificationId = journalistStoryModal()
    var jobCategoryId = journalistStoryModal()
    var jobKeywordName = [String]()
    var jobRoleId = journalistStoryModal()
    var currency = ""
    var jobStatus = 0
    var status = 0
    var jobId = ""
    var workExperience = ""
    var expectedSalary = ""
    var employementType = ""
    var jobDescription = ""
    var country = CountryList()
    var city = CountryList()
    var state = StateList()
    
    var createdAt = ""
    var updatedAt = ""
    var vId = ""
    
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseId = journalistStoryModal(dict: mediahouseId)
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
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let jobStatus = dict[Keys.jobStatus.stringValue] as? Int {
            self.jobStatus = jobStatus
        }
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let jobId = dict[Keys.jobId.stringValue] as? String {
            self.jobId = jobId
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
        if let jobFunctionalAreaId = dict[Keys.jobFunctionalAreaId.stringValue] as? Array<Dictionary<String,AnyObject>>{
            for area in jobFunctionalAreaId {
                let tempArea = journalistStoryModal(dict: area)
                self.jobFunctionalAreaId.append(tempArea)
            }
        }
        if let jobKeywordName = dict[Keys.jobKeywordName.stringValue] as? [String] {
            self.jobKeywordName = jobKeywordName
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
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? String {
            self.vId = vId
        }
        
        super.init()
    }
}


//------NotificationModel----
class NotificationList: NSObject {
    
    enum Keys: String, CodingKey {
        case status = "status"
        case notificationId = "_id"
        case title = "title"
        case descriptions = "description"
        case userType = "userType"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
    }
    
    var status = 2
    var notificationId = ""
    var title = ""
    var descriptions = ""
    var userType = ""
    var createdAt = ""
    var updatedAt = ""
    var vId = 2
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let status = dict[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let notificationId = dict[Keys.notificationId.stringValue] as? String {
            self.notificationId = notificationId
        }
        if let title = dict[Keys.title.stringValue] as? String {
            self.title = title
        }
        if let descriptions = dict[Keys.descriptions.stringValue] as? String {
            self.descriptions = descriptions
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
        if let vId = dict[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        super.init()
    }
    
}

//---------TranslateModel----
class TranslateModel: NSObject {
    enum Keys: String, CodingKey{
        
        case journalistId = "journalistId"
        case mediahouseId = "mediahouseId"
        case serviceType = "serviceType"
        case fromLanguage = "fromLanguage"
        case toLanguage = "toLanguage"
        case fileType = "fileType"
        case fileSize = "fileSize"
        case emailId = "emailId"
        case id = "_id"
        case convertedFile = "convertedFile"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
    }
    
    var journalistId = "journalistId"
    var mediahouseId = "mediahouseId"
    var serviceType = "serviceType"
    var fromLanguage = "fromLanguage"
    var toLanguage = "toLanguage"
    var fileType = "fileType"
    var fileSize = "fileSize"
    var emailId = "emailId"
    var id = "_id"
    var convertedFile = "convertedFile"
    var createdAt = "createdAt"
    var updatedAt = "updatedAt"
    var vId = 0
    
    override init() {
        super.init()
    }
    
    init(dict: [String: AnyObject]) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? String {
            self.journalistId = journalistId
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let serviceType = dict[Keys.serviceType.stringValue] as? String {
            self.serviceType = serviceType
        }
        if let fromLanguage = dict[Keys.fromLanguage.stringValue] as? String {
            self.fromLanguage = fromLanguage
        }
        if let toLanguage = dict[Keys.toLanguage.stringValue] as? String {
            self.toLanguage = toLanguage
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let convertedFile = dict[Keys.convertedFile.stringValue] as? String {
            self.convertedFile = convertedFile
        }
        if let fileType = dict[Keys.fileType.stringValue] as? String {
            self.fileType = fileType
        }
        if let fileSize = dict[Keys.fileSize.stringValue] as? String {
            self.fileSize = fileSize
        }
        if let emailId = dict[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        super.init()
    }
}

//-----TranslateListModel
class TranslateListModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [TranslateListDetailsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = TranslateListDetailsModel(dict: item)
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
        super.init()
    }
}



//---- TranslateListDetailsModel ------
class TranslateListDetailsModel: NSObject{
    enum Keys: String, CodingKey {
        
        case journalistId = "journalistId"//
        case translateId = "_id"
        case mediahouseId = "mediahouseId"
        case serviceType = "serviceType"
        case fromLanguage = "fromLanguage"
        case toLanguage = "toLanguage"
        case fileType = "fileType"
        case fileSize = "fileSize"
        case emailId = "emailId"
        case convertedFile = "convertedFile"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
        case originalFile =  "originalFile"
        
    }
    
    var journalistId = journalistStoryModal()
    var translateId = ""
    var mediahouseId = journalistStoryModal()
    var serviceType = ""
    var fromLanguage = ""
    var toLanguage = ""
    var fileType = ""
    var fileSize = ""
    var emailId = ""
    var convertedFile = ""
    var createdAt = ""
    var updatedAt = ""
    var vId = 0
    var originalFile = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistStoryModal(dict: journalistId)
        }
        if let translateId = dict[Keys.translateId.stringValue] as? String {
            self.translateId = translateId
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseId = journalistStoryModal(dict: mediahouseId)
        }
        if let serviceType = dict[Keys.serviceType.stringValue] as? String {
            self.serviceType = serviceType
        }
        if let fromLanguage = dict[Keys.fromLanguage.stringValue] as? String {
            self.fromLanguage = fromLanguage
        }
        if let toLanguage = dict[Keys.toLanguage.stringValue] as? String {
            self.toLanguage = toLanguage
        }
        if let fileType = dict[Keys.fileType.stringValue] as? String {
            self.fileType = fileType
        }
        if let fileSize = dict[Keys.fileSize.stringValue] as? String {
            self.fileSize = fileSize
        }
        
        if let emailId = dict[Keys.emailId.stringValue] as? String {
            self.emailId = emailId
        }
        if let convertedFile = dict[Keys.convertedFile.stringValue] as? String {
            self.convertedFile = convertedFile
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        if let originalFile = dict[Keys.originalFile.stringValue] as? String {
            self.originalFile = originalFile
        }
        
        super.init()
    }
}

//-----JournalistReplyModel
class JournalistReplyModel: NSObject {
    enum Keys: String, CodingKey{
        case journalistId = "journalistId"
        case journalistComment = "journalistComment"
        case id = "_id"
        case assignmentId = "assignmentId"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
        case message = "message"
        case messageType = "messageType"
        case mediahouseId = "mediahouseId"
        
        case spellingAndGrammar = "spellingAndGrammar"
        case consistencyAndClarity = "consistencyAndClarity"
        case fairObjectiveAndAccuracy = "fairObjectiveAndAccuracy"
        case obscenitiesVulgarities = "obscenitiesProfanitiesAndVulgarities"
        case plagiarism = "plagiarism"
        case mediahouseComment = "mediahouseComment"
        case averageRating = "averageRating"
        case storyId = "storyId"
        
        case editorialBoardId = "editorialBoardId"
        case ethicsCommitteId = "ethicsCommitteId"
    }
    
    var journalistId = journalistStoryModal()
    var journalistComment = ""
    var id = ""
    var assignmentId = ""
    var status = 0
    var createdAt = ""
    var updatedAt = ""
    var vId = 0
    var message = ""
    var messageType = ""
    var mediahouseId = journalistStoryModal()
    var spellingAndGrammar = 0
    var consistencyAndClarity = 0
    var fairObjectiveAndAccuracy = 0
    var obscenitiesVulgarities = 0.0
    var averageRating = ""
    var plagiarism = 0
    var mediahouseComment = ""
    var storyId = ""
    
    var editorialBoardId = journalistStoryModal()
    var ethicsCommitteId = journalistStoryModal()

    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let journalistId = dictionary[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistStoryModal(dict: journalistId)
        }
        if let mediahouseId = dictionary[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseId = journalistStoryModal(dict: mediahouseId)
        }
        if let ethicsCommitteId = dictionary[Keys.ethicsCommitteId.stringValue] as? Dictionary<String,AnyObject>{
                   self.ethicsCommitteId = journalistStoryModal(dict: ethicsCommitteId)
        }
        if let editorialBoardId = dictionary[Keys.editorialBoardId.stringValue] as? Dictionary<String,AnyObject>{
            self.editorialBoardId = journalistStoryModal(dict: editorialBoardId)
        }
        if let journalistComment = dictionary[Keys.journalistComment.stringValue] as? String{
            self.journalistComment = journalistComment
        }
        if let id = dictionary[Keys.id.stringValue] as? String{
            self.id = id
        }
        if let assignmentId = dictionary[Keys.assignmentId.stringValue] as? String {
            self.assignmentId = assignmentId
        }
        if let status = dictionary[Keys.status.stringValue] as? Int {
            self.status = status
        }
        if let createdAt = dictionary[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dictionary[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dictionary[Keys.vId.stringValue] as? Int {
            self.vId = vId
        }
        if let message = dictionary[Keys.message.stringValue] as? String {
            self.message = message
        }
        if let messageType = dictionary[Keys.messageType.stringValue] as? String {
            self.messageType = messageType
        }
        if let spellingAndGrammar = dictionary[Keys.spellingAndGrammar.stringValue] as? Int {
            self.spellingAndGrammar = spellingAndGrammar
        }
        if let consistencyAndClarity = dictionary[Keys.consistencyAndClarity.stringValue] as? Int {
            self.consistencyAndClarity = consistencyAndClarity
        }
        if let fairObjectiveAndAccuracy = dictionary[Keys.fairObjectiveAndAccuracy.stringValue] as? Int {
            self.fairObjectiveAndAccuracy = fairObjectiveAndAccuracy
        }
        if let obscenitiesVulgarities = dictionary[Keys.obscenitiesVulgarities.stringValue] as? Double {
            self.obscenitiesVulgarities = obscenitiesVulgarities
        }
        if let plagiarism = dictionary[Keys.plagiarism.stringValue] as? Int {
            self.plagiarism = plagiarism
        }
        
        if let averageRating = dictionary[Keys.averageRating.stringValue] as? String {
            self.averageRating = averageRating
        }
        if let mediahouseComment = dictionary[Keys.mediahouseComment.stringValue] as? String {
            self.mediahouseComment = mediahouseComment
        }
        if let storyId = dictionary[Keys.storyId.stringValue] as? String {
            self.storyId = storyId
        }
        
        
        super.init()
    }
}



//-----GetJornalistReplyModel
class GetJornalistReplyModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [JournalistReplyModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = JournalistReplyModel(dictionary: item)
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
        super.init()
    }
}


//-----MediaHouseDetailsModel
class MediaHouseDetailsModel: NSObject {
    enum Keys: String, CodingKey{
        
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case logo = "logo"
        case invitedStatus = "invitedStatus"
    }
    
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var logo = ""
    var invitedStatus = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let firstName = dictionary[Keys.firstName.stringValue] as? String{
            self.firstName = firstName
        }
        if let middleName = dictionary[Keys.middleName.stringValue] as? String{
            self.middleName = middleName
        }
        if let lastName = dictionary[Keys.lastName.stringValue] as? String{
            self.lastName = lastName
        }
        if let logo = dictionary[Keys.logo.stringValue] as? String{
            self.logo = logo
        }
        if let invitedStatus = dictionary[Keys.invitedStatus.stringValue] as? Int{
            self.invitedStatus = invitedStatus
        }

        super.init()
    }
}



//-----EventListModal
class EventListModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [EventListDetailsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = EventListDetailsModel(dict: item)
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
        super.init()
    }
}


//---- AssignmentListDetailsModel ------

class EventListDetailsModel: NSObject{
    enum Keys: String, CodingKey {
        

        
        case journalistId = "journalistId"//
        case ids = "_id"
        case mediahouseId = "mediahouseId"
        case status = "status"
        case assignmentTitle = "assignmentTitle"
        case langCode = "langCode"
        case currency = "currency"
        case price = "price"
        case assignmentDescription = "assignmentDescription"
        case country = "country"
        case replyCount = "replyCount"
        case journalistReply = "journalistReply"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case vId = "__v"
        case id = "id"
        case journalistHeadline = "journalistAssignmentHeadline"
        case date = "date"
        case time = "time"
        case journalistDescription = "journalistAssignmentDescription"
        case city = "city"
        case state = "state"
        case live = "live"
        case purchaseStatus = "purchaseStatus"
        
        case assignmentId = "assignmentId"
        case message = "message"
        
        case keywordName = "keywordName"
        
        
        
    }
    
    var journalistId = journalistStoryModal()
    var ids = ""
    var mediahouseId = journalistStoryModal()
    var status = 0
    var assignmentTitle = ""
    var langCode = ""
    var currency = ""
    var price = 0
    var assignmentDescription = ""
    var country = CountryList()
    var replyCount = 0
    var journalistReply = [JournalistReplyModel]()
    var createdAt = ""
    var updatedAt = ""
    var vId = ""
    var id = ""
    var journalistHeadline = ""
    var date = ""
    var time = ""
    var journalistDescription = ""
    var city = CityList()
    var state = StateList()
    var live = 0
    var purchaseStatus = 0
    
    
    var assignmentId = ""
    var message = ""
    
    var keywordName = [String]()


    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let journalistId = dict[Keys.journalistId.stringValue] as? Dictionary<String,AnyObject>{
            self.journalistId = journalistStoryModal(dict: journalistId)
        }
        if let ids = dict[Keys.ids.stringValue] as? String {
            self.ids = ids
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? Dictionary<String,AnyObject>{
            self.mediahouseId = journalistStoryModal(dict: mediahouseId)
        }
        if let status = dict[Keys.status.stringValue] as? Int{
            self.status = status
        }
        if let assignmentTitle = dict[Keys.assignmentTitle.stringValue] as? String {
            self.assignmentTitle = assignmentTitle
        }
        if let langCode = dict[Keys.langCode.stringValue] as? String {
            self.langCode = langCode
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let country = dict[Keys.country.stringValue] as? Dictionary<String,AnyObject>{
            self.country = CountryList(dict: country)
        }
        
        if let state = dict[Keys.state.stringValue] as? Dictionary<String,AnyObject>{
            self.state = StateList(dict: state)
        }
        
        if let city = dict[Keys.city.stringValue] as? Dictionary<String,AnyObject>{
            self.city = CityList(dict: city)
        }
        if let replyCount = dict[Keys.replyCount.stringValue] as? Int{
            self.replyCount = replyCount
        }
        if let journalistReply = dict[Keys.journalistReply.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.journalistReply.removeAll()
            for item in journalistReply{
                let somedocs = JournalistReplyModel(dictionary: item)
                print("\(somedocs)")
                self.journalistReply.append(somedocs)
            }
        }
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        if let vId = dict[Keys.vId.stringValue] as? String {
            self.vId = vId
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let price = dict[Keys.price.stringValue] as? Int {
            self.price = price
        }
        if let assignmentDescription = dict[Keys.assignmentDescription.stringValue] as? String {
            self.assignmentDescription = assignmentDescription
        }
        if let journalistHeadline = dict[Keys.journalistHeadline.stringValue] as? String {
            self.journalistHeadline = journalistHeadline
        }
        if let date = dict[Keys.date.stringValue] as? String {
            self.date = date
        }
        if let time = dict[Keys.time.stringValue] as? String {
            self.time = time
        }
        if let journalistDescription = dict[Keys.journalistDescription.stringValue] as? String {
            self.journalistDescription = journalistDescription
        }
        
        if let live = dict[Keys.live.stringValue] as? Int{
            self.live = live
        }
        
        if let purchaseStatus = dict[Keys.purchaseStatus.stringValue] as? Int{
            self.purchaseStatus = purchaseStatus
        }
        
        if let assignmentId = dict[Keys.assignmentId.stringValue] as? String {
            self.assignmentId = assignmentId
        }

        if let message = dict[Keys.message.stringValue] as? String {
            self.message = message
        }
        
        if let keywordName = dict[Keys.keywordName.stringValue] as? [String] {
            self.keywordName = keywordName
        }


        super.init()
    }
    
}



//-----purxhaseListModal
class PurchaseListModel: NSObject {
    enum Keys: String, CodingKey{
        case docs = "docs"
        case total = "total"
        case limit = "limit"
        case page = "page"
        case pages = "pages"
    }
    
    var docs = [PurchaseDetailsModel]()
    var total: Int = 0
    var limit: Int = 0
    var page: Int = 0
    var pages: Int = 0
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        
        if let docs = dictionary[Keys.docs.stringValue] as? Array<Dictionary<String, AnyObject>> {
            self.docs.removeAll()
            for item in docs{
                let somedocs = PurchaseDetailsModel(dict: item)
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
        super.init()
    }
}


//---- AssignmentListDetailsModel ------

class PurchaseDetailsModel: NSObject{
    enum Keys: String, CodingKey {
        
        
        case id = "_id"
        case mediahouseId = "mediahouseId"
        case  assignmentId = "assignmentId"
        case currency = "currency"
        case invoice = "invoice"
        case journalistAssignmentHeadline = "journalistAssignmentHeadline"
        case amount = "amount"
        case paymentMode = "paymentMode"
        case transactionId = "transactionId"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case ids = "id"
        case startStatus = "startStatus"
        
    }
    
    var id = ""
    var mediahouseId = ""
    var assignmentId = EventListDetailsModel()
    var currency = ""
    var invoice = ""
    var journalistAssignmentHeadline = ""
    var amount = ""
    var paymentMode = ""
    var transactionId = ""
    var createdAt = ""
    var updatedAt = ""
    var ids = ""
    var startStatus = 0
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let assignmentId = dict[Keys.assignmentId.stringValue] as? Dictionary<String,AnyObject>{
            self.assignmentId = EventListDetailsModel(dict: assignmentId)
        }
        if let id = dict[Keys.id.stringValue] as? String {
            self.id = id
        }
        if let mediahouseId = dict[Keys.mediahouseId.stringValue] as? String {
            self.mediahouseId = mediahouseId
        }
        if let currency = dict[Keys.currency.stringValue] as? String {
            self.currency = currency
        }
        if let invoice = dict[Keys.invoice.stringValue] as? String {
            self.invoice = invoice
        }
        if let journalistAssignmentHeadline = dict[Keys.journalistAssignmentHeadline.stringValue] as? String {
            self.journalistAssignmentHeadline = journalistAssignmentHeadline
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
        if let createdAt = dict[Keys.createdAt.stringValue] as? String {
            self.createdAt = createdAt
        }
        
        if let updatedAt = dict[Keys.updatedAt.stringValue] as? String {
            self.updatedAt = updatedAt
        }
        
        if let ids = dict[Keys.ids.stringValue] as? String {
            self.ids = ids
        }
        if let startStatus = dict[Keys.startStatus.stringValue] as? Int{
                  self.startStatus = startStatus
              }
        super.init()
    }
    
}

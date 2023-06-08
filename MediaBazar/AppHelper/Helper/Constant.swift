//
//  Constant.swift
//  TenderApp
//
//  Created by Saurabh Chandra Bose on 17/09/19.
//  Copyright © 2019 Abhinav Saini. All rights reserved.
//

import Foundation
import UIKit

/*================== API URLs ====================================*/
//https://apimedia.5wh.com/
//https://apimediaprod.5wh.com/
//let BASE_URL = "http://3.84.159.2:8094/"

let BASE_URL = "https://apimediaprod.5wh.com/"
//let BASE_URL = "https://apimedia.5wh.com/"

let LOGIN_URL = "\(BASE_URL)api/user/login"
let PERSONAL_INFO = "\(BASE_URL)api/user/personalInfo"
let INVITE_PERSONAL_INFO = "\(BASE_URL)api/user/updateProfile"
let PROFESIONAL_DETAILS = "\(BASE_URL)professionalDetails"
let REFRENCES_URL = "\(BASE_URL)api/user/refrences"
let SOCIAL_ACCOUNTLINK = "\(BASE_URL)socialAccountLinks"
let PLATEFORM_BENEFITS = "\(BASE_URL)api/user/platformBenefits"
let COUNTRY_LIST = "\(BASE_URL)api/user/country"
let STATE_LIST = "\(BASE_URL)api/user/states"
let CITY_LIST = "\(BASE_URL)api/user/city"
let LANGUAGES = "\(BASE_URL)user/languages"
let DESIGNATION = "\(BASE_URL)admin/designation"
let SOCIALMEDIALINK_URL = "\(BASE_URL)api/user/socialAccountLinks"
//let BENEFIT_URL = "\(BASE_URL)admin/benefit"

let TO_LANGUAGE_LIST = "\(BASE_URL)api/user/selectedLanguages"

let BENEFIT_URL = "\(BASE_URL)admin/platformBenefit"

let PREVIOUSWORK_URL = "\(BASE_URL)api/user/previousWorks"
let CATEGORY_URL = "\(BASE_URL)admin/category"
let STORYKEYWORD_URL = "\(BASE_URL)admin/storyKeyword"
let PROFESSIONALDETAIL_URL = "\(BASE_URL)api/user/professionalDetails"
let JOURNALISTPROFILE_URL = "\(BASE_URL)api/user/getJournalistProfile"
let BENEFITS_URL = "\(BASE_URL)admin/benefit"
let ENQUIRY_URL = "\(BASE_URL)api/user/enquiry"

                              
let BLOF_FORM_FILL = "\(BASE_URL)api/user/blog"
let EDIT_BLOG_FORM_FILL = "\(BASE_URL)api/user/upadeteBlog"
let SELL_STORY_FORM = "\(BASE_URL)api/user/sellStory"
let UPDATE_SELL_STORY_FORM = "\(BASE_URL)api/user/updateSellStory"
let UPDATE_SECOND_FORM_STORY = "\(BASE_URL)api/user/updateStoryById"
let GET_USER_STORY = "\(BASE_URL)api/user/getStory"
let GET_FILTER_STORY_LIST = "\(BASE_URL)api/user/storyFilterByStoryCategory"
let GET_MYSTORY = "\(BASE_URL)api/user/getMyStory"
let GET_MY_SAVE_STORY = "\(BASE_URL)api/user/getSaveStory"
let GET_MY_SAVE_FILTER_STORY = "\(BASE_URL)api/user/saveStoryFilterByStoryCategory"

let GET_MY_STORY_FILTER_STORY = "\(BASE_URL)api/user/myStoryFilterByStoryCategory"
//let GET_CONTENT_TYPE_DATA = "\(BASE_URL)api/user/getSaveStory"
let CONTACT_US = "\(BASE_URL)admin/contact_us"
let CHANGE_PASSWORD = "\(BASE_URL)api/user/changePassword"
let FORGRT_PASSWORD = "\(BASE_URL)api/user/forgotPassword"
let OTP_VERIFICATION = "\(BASE_URL)api/user/verifyOtp"
let RESET_PASSWORD = "\(BASE_URL)api/user/resetPassword"

let CREATE_ASSIGNMENT = "\(BASE_URL)api/user/journalistAssignment"
let MY_ASSIGNMENT_LIST = "\(BASE_URL)api/user/journalistAssignment"
let SEARCH_MY_ASSIGNMENT_LIST = "\(BASE_URL)api/user/searchAssignment"
let EDITORS_ASSIGNMENT_LIST = "\(BASE_URL)api/user/mediahouseAssignment"
let SEARCH_EDITORS_ASSIGNMENT = "\(BASE_URL)api/user/searchMediahouseAssignment"
let ASSIGNMENT_REPLAY = "\(BASE_URL)api/user/mediahouseAssignment"
let REMOVE_ASSIGNMENT = "\(BASE_URL)api/user/journalistAssignment"

let EARNING_STORY_LIST = "\(BASE_URL)api/user/earning"
let EARNING_STORY_BY_ID = "\(BASE_URL)api/user/earningByStoryId"

let JOB_LIST = "\(BASE_URL)api/user/getAllJob"
let SEARCH_JOB_LIST = "\(BASE_URL)api/user/searchJob"
let APPLIED_JOB = "\(BASE_URL)api/user/applyJob"

let CONTENT_UPLOAD_LIST = "\(BASE_URL)api/user/uploadContent"

let SEARCH_ALL_TYPE_STORY = "\(BASE_URL)api/user/searchStory"
let SEARCH_SAVE_STORY = "\(BASE_URL)api/user/searchSaveStory"
let SEARCH_MY_STORY = "\(BASE_URL)api/user/searchMyStory"
let MEDIA_TYPE = "\(BASE_URL)admin/mediahouseType"

let ADD_JOURNALIST_FAV_STORY = "\(BASE_URL)api/user/favouriteStory"

let GET_REVIEW_BY_STORY_ID = "\(BASE_URL)api/user/storyReview"

let UPDATE_PROFILE_PIC = "\(BASE_URL)api/user/profilePic"
let UPDATE_PROFILE_VIDEO = "\(BASE_URL)api/user/profileVideo"
let EDIT_PERSONAL_INFO = "\(BASE_URL)api/user/personalInfo"

let EDITORIAL_CHAT_LIST = "\(BASE_URL)api/user/editorialChat"

let GET_REGISTRATION_FEE_PLANS = "\(BASE_URL)admin/registrationFee"
let REGISTRATION_FEE_PAYMENT = "\(BASE_URL)admin/registrationFee"

//========collobrate module======

let GET_INVITE_JOURNALIST_LIST = "\(BASE_URL)api/user/getAllJournalist"
let CREATE_GROUP = "\(BASE_URL)api/user/inviteUser"
let NEW_REQUEST_GROUP_LIST = "\(BASE_URL)api/user/Invitation"
let REQUEST_ACCEPT_REJECT_GROUP = "\(BASE_URL)api/user/Invitation"
let ADDED_GROUP_LIST = "\(BASE_URL)api/user/addedGroup"
let LEAVE_GROUP = "\(BASE_URL)api/user/leaveGroup"
let CHAT_LIST = "\(BASE_URL)api/user/userChat"
let INSERT_CHAT_JOURNALIST = "\(BASE_URL)api/user/userChat"


let GET_SAVE_COLLOBRATE_STORY = "\(BASE_URL)api/user/getSaveCollaboratedStory"
let GET_SEARCH_SAVE_COLLOBRATE_STORY = "\(BASE_URL)api/user/searchMyCollaboratedStory"
let GET_FILTER_SAVE_COLLOBRATE_STORY = "\(BASE_URL)api/user/saveCollaboratedStoryFilterByStoryCategory"
let SAVE_STORY_POST_BY_ID = "\(BASE_URL)api/user/storyPostById"
let PENDING_COLLABORATED_STORY_LIST = "\(BASE_URL)api/user/pendingCollaboratedStory"
let APPROVED_COLLABORATED_STORY_LIST = "\(BASE_URL)api/user/approvedCollaboratedStory"
let INVITE_COLLABORATED_STORY_LIST = "\(BASE_URL)api/user/InvitedCollaboratedStory"
let  COLLABORATED_STORY_INVITATION_STATUS = "\(BASE_URL)api/user/collaboratedStoryInvitationStatus"

let TRANSLATE_FILE_PRICE_JM = "\(BASE_URL)api/user/translatePrice"
let TRANSLATE_AND_TRASCRIBE = "\(BASE_URL)api/user/translate"
let TRANSLATE_LIST_JM =  "\(BASE_URL)api/user/translate"
let TRANSLATE_DELETE_JM =  "\(BASE_URL)api/user/translate"

let NOTIFICATION_LIST_JM = "\(BASE_URL)api/user/notification"

let MEMBERSHIP_PLANS_LIST_JM = "\(BASE_URL)api/user/mebershipPayment"
let MEMBERSHIP_PAYMENTS_JM = "\(BASE_URL)api/user/mebershipPayment"
let CHECK_COUPON_JM = "\(BASE_URL)api/user/checkCoupon"

let ETHIC_MEMBER_ENQUIRY_JM = "\(BASE_URL)api/user/ethicMember"

let DELETE_STORY_JM = "\(BASE_URL)api/user/deleteStory"

let INCREASE_STORY_VIEW = "\(BASE_URL)api/user/storyViews"

let DELETE_STORY_FILE_BY_ID = "\(BASE_URL)api/user/deleteStoryById"

let LIVE_VIDEO_START_JOURNALIST = "\(BASE_URL)api/user/event"

let GET_PROFILE_STATUS = "\(BASE_URL)api/user/profileStatus"

let GET_FAQ_MEDIA_AND_JOURNALIST = "\(BASE_URL)api/user/faq"

let DELETE_CONTENT_BY_ID = "\(BASE_URL)api/user/deletContent"
let RENAME_UPLOADED_CONTENT = "\(BASE_URL)api/user/uploadContent"

let JOURNALIST_ETHIC_CHAT_LIST = "\(BASE_URL)api/user/enquiryChat"

//=============Media House Api
let MEDIAHOUSE_FREQUENCY = "\(BASE_URL)admin/mediahousefrequency"
let COMPANY_INFORMATION = "\(BASE_URL)api/mediahouse/companyInformation"

let JOURNALIST_DATA_BY_ID = "\(BASE_URL)api/user/getJournalistProfileById"
let STORY_DATA_BY_ID = "\(BASE_URL)api/user/getStoryByJournalistId"
let MEDIAHOUSE_SOCIAL_LINKS = "\(BASE_URL)api/mediahouse/socialAccountLink"
let GET_MEDIA_STORY = "\(BASE_URL)api/mediahouse/getStory"
let SEARCH_MEDIA_STORY = "\(BASE_URL)api/mediahouse/searchStory"
let ADMIN_CATEGORY = "\(BASE_URL)admin/category"
let FILTER_STORY = "\(BASE_URL)api/mediahouse/storyFilterByStoryCategory"
let ADD_FAV_MEDIA = "\(BASE_URL)api/mediahouse/favouriteStory"
let JOB_CATEGORY = "\(BASE_URL)admin/jobCategory"
let FUNCTIONAL_AREA_CATEGORY = "\(BASE_URL)admin/jobFunctionalArea"
let JOB_ROLE = "\(BASE_URL)admin/jobrole"
let JOB_QUALIFICATION = "\(BASE_URL)admin/jobQualification"
let JOB_KEYWORD = "\(BASE_URL)admin/jobKeyword"
let MEDIAHOUSE_PROFILE = "\(BASE_URL)api/mediahouse/getMediahouseProfile"
let MEDIAHOUSE_PERSONALINFO = "\(BASE_URL)api/mediahouse/personalInformation"
let INVITE_USER_MEDIAHOUSE_PERSONALINFO = "\(BASE_URL)api/mediahouse/updateProfile"
let CHANGE_PASS_MEDIA = "\(BASE_URL)api/mediahouse/changePassword"
let MEDIA_CONTACTUS = "\(BASE_URL)api/mediahouse/contactUs"
let MEDIA_ENQUIRY = "\(BASE_URL)api/mediahouse/enquiry"
let FAVORITE_MEDIASTORY = "\(BASE_URL)api/mediahouse/favouriteStory"
let MEDIAHOUSE_ASSIGNMENT = "\(BASE_URL)api/mediahouse/assignment"
let POST_MEDIA_ASSIGNMENT = "\(BASE_URL)api/mediahouse/assignment"
let SEARCH_MEDIA_ASSIGNMENT = "\(BASE_URL)api/mediahouse/searchMediahouseAssignment"
let JOURNALIST_ASSIGNMENT_LIST = "\(BASE_URL)api/mediahouse/journalistAssignment"
let CREATE_MEDIA_JOB = "\(BASE_URL)api/mediahouse/job"
let SEARCH_MEDIA_JOB = "\(BASE_URL)api/mediahouse/searchJob"
let PURCHASE_STORY_LIST = "\(BASE_URL)api/mediahouse/getPurchasedStory"
let CURRENCY_LIST = "\(BASE_URL)api/user/currency"
let NOTIFICATION_LIST = "\(BASE_URL)api/mediahouse/notification"
let TRANSLATE_TRANNSCRIBE = "\(BASE_URL)api/mediahouse/translate"
let DELETE_TRANSLATE = "\(BASE_URL)api/mediahouse/translate"
let TRANSLATE_FILE_PRICE_MEDIA = "\(BASE_URL)api/mediahouse/translatePrice"
let GET_REPLY = "\(BASE_URL)api/mediahouse/getReply"
let CHAT_LISTS = "\(BASE_URL)api/mediahouse/userChat"
let INSERT_CHAT_LIST_MEDIA = "\(BASE_URL)api/mediahouse/userChat"
let STORY_REVIEWS = "\(BASE_URL)api/mediahouse/storyReview"
let ETHIC_MEMBER = "\(BASE_URL)api/mediahouse/ethicMember"
let STORY_PAYMENT = "\(BASE_URL)api/mediahouse/storyPayment"

let MEDIABAZAR_BIDDING = "\(BASE_URL)api/mediahouse/bidding"

let NEW_EVENT_LIST = "\(BASE_URL)api/mediahouse/event"
let PURCHASE_EVENT_LIST = "\(BASE_URL)api/mediahouse/purchaseEvent"
let GET_VIDEO_COMMENT = "\(BASE_URL)api/mediahouse/liveChat"
let ADD_VIDEO_COMMENT = "\(BASE_URL)api/mediahouse/liveChat"
let NEW_EVENT_PAYMENT = "\(BASE_URL)api/mediahouse/eventPayment"
let GET_VIDEO_EVENT_STATUS = "\(BASE_URL)api/mediahouse/eventStatus"

let MEDIA_MEMBERSHIP_PLAN = "\(BASE_URL)api/mediahouse/mebershipPayment"
let MEMBERSHIP_PLANS_PAY_MEDIA = "\(BASE_URL)api/mediahouse/mebershipPayment"

let APP_CONENT_DATA = "\(BASE_URL)admin/staticContent"

let MEDIAHOUSE_LOGO = "\(BASE_URL)api/mediahouse/logo"

let DOWNLOAD_PURCHASE_STORY = "\(BASE_URL)api/mediahouse/downloadStory"


let GET_MEDIA_JOPURNALIST_BY_STORY = "\(BASE_URL)api/mediahouse/getJournalistProfileById"
let GET_MEDIA_JOURNALIST_ASSIGNMENT_BY_ID = "\(BASE_URL)api/mediahouse/getAssignmentByJournalistId"
let GET_MEDIA_JOURNALIST_STORY_JOURNALIST_ID = "\(BASE_URL)api/mediahouse/getStoryByJournalistId"
let MEDIA_ETHICS_CHAT_LIST = "\(BASE_URL)api/mediahouse/enquiryChat"

enum api: String {
    
    case login
    case personalInfo
    case invitePersonalInfo
    case refrences
    case socialAccountLinks
    
    case platformBenefits
    
    case countrySearch
    case stateSearch
    case citySerach
    case languages
    case designation
    case socialMedialink
    
    case toLanguagelist
    
    case benefit
    
    case previoousWork
    case category
    case storyKeyweord
    case professionalDetail
    case journalistProfile
    
    case adminBenefit
    
    case enquiry
    
    case blogFormFill
    case editBlogFormFill
    case sellStoryForm
    case updateSellStoryForm
    case updateSecondFormStory
    case getUserStory
    case getFilterStoryList
    case getMyStory
    case getMyStoryFilterList
    case searchMyStory

    case editorialChatList
    
    
    case contactUs
    case changePassword
    case forgetPassword
    case otpVerification
    case resetPassword
    
    case createAssignment
    case myAssignmentList
    case searchMyAssignmentList
    case editorAssignmentList
    case searchEditorAssignment
    case assignmentReplay
    case removeAssignment
    
    case earningStoryList
    case earningStoryByID
    
    case jobList
    case searchJobList
    case appliedJob
    
    case contentUpload
 
    case searchMyAllTypeStory
    
    case getMySaveStory
    case getMyFilterSaveStory
    case searchSavedStory
    
    
    
    case mediaType
    case addJournalistFavList
    case getJournalistDataByID
    case getStoryDataByID
    case getReviewByStoryID
    
    //=====colloborate Module ========
    case getJournalistInviteList
    case createGroup
    case newRequestGroupList
    case requestAcceptRejectGroup
    case addedGroupList
    case leaveGroup
    case chatList
    case insertChatListJournalist
    
    
    case getSaveCollobrateStoryList
    case getSearchSaveCollobateStoryList
    case getFilterSaveCollobrateStoryList
    case saveStoryPostById
    case invitedCollaboratedStoryList
    case approvedCollaboratedStoryList
    case pendingCollaboratedStoryList
    case collaboratedStoryInvitationStatus
    
    case updateProfilePic
    case updateProfileVideo
    case editPersonalInfo
    
    case translateFIlePriceJM
    case transnlateAndTranscribe
    case translateListJM
    case traslateDeleteJM
    
    case notificationList
    
    case membershipPlansListJM
    case mebershipPaymentJM
    case checkCouponJM
    
    case ethicMemberEnquiry

    case deleteStoryJM
    
    case increaseStoryView
    case deleteStoryFileByID
    
    case liveVideoStartJournalist
    
    case getProfileStatus
    
    case getFaqMediaAndJournalist
    
    case deleteContentByID
    case renameUploadedContent
    
    case getRegistrationFeePlans
    case registrationFeePayment
    
    case journalistEthicsChat
    
    
    //============================Media house Api
    case mediahousefrequency
    case companyInformation
    case mediaSocialAccountLink
    case getMediaStory
    case searchStory
    case adminCategory
    case filetrStory
    case favouriteStory
    case jobCategory
    case jobFunctionalArea
    case jobRole
    case jobQualification
    case jobKeyword
    case getMediahouseProfile
    case mediaHousePersonalInfo
    case inviteUserMediaHousePersonalInfo
    case changePasswordMedia
    case mediaContactUs
    case mediaEnquiry
    case favouriteMediaStory
    
    case mediahouseAssignmentList
    case postMediaAssignment
    case searchMediaAssignment
    case journalistAssignmentList
    case createjobMedia
    case searchMediaJob
    case purchaseStroryList
    case currency
    case notificationListMedia
    case translate
    case deleteTranslate
    case translatePriceMedia
    case getReply
    case chatLists
    case insertChatListMedia
    case storyReview
    case ethicMember
    case storyPayment
    
    case mediaBidding
    
    case newEventList
    case purchaseEventList
    case getVideoComment
    case addVideoComment
    case newEventPayment
    case getVideoEventStatus
    
    
    case getMediaMembersPlans
    case membershipPlansPayMedia
    
    case appContentData
    
    case mediaHouseLogo
    case downloadPurchaseStory
        
    case getMediaJournalistByStorty
    case getMediaJournalistAssignmentByID
    case getMediaStoryListByJournalistID
    
    case getMediaEthicsChatList
    
    func url() -> String {
        switch self {
        case .login : return LOGIN_URL
        case .personalInfo : return PERSONAL_INFO
        case .invitePersonalInfo : return INVITE_PERSONAL_INFO
        case .refrences : return REFRENCES_URL
        case .designation: return DESIGNATION
        case .socialAccountLinks : return SOCIAL_ACCOUNTLINK
            
        case .platformBenefits : return PLATEFORM_BENEFITS
            
        case .socialMedialink: return SOCIALMEDIALINK_URL
        case .countrySearch : return COUNTRY_LIST
        case .stateSearch : return STATE_LIST
        case .citySerach : return CITY_LIST
        case .languages: return LANGUAGES
            
        case .toLanguagelist: return TO_LANGUAGE_LIST
            
        case .benefit: return BENEFITS_URL
            
        case .previoousWork: return PREVIOUSWORK_URL
        case .category: return CATEGORY_URL
        case .storyKeyweord: return STORYKEYWORD_URL
        case .professionalDetail : return PROFESSIONALDETAIL_URL
        case .journalistProfile: return JOURNALISTPROFILE_URL
            
        case .adminBenefit: return BENEFIT_URL
            
        case .enquiry: return ENQUIRY_URL
            
        case .blogFormFill: return BLOF_FORM_FILL
        case .editBlogFormFill: return EDIT_BLOG_FORM_FILL
        case .sellStoryForm: return SELL_STORY_FORM
        case .updateSellStoryForm: return UPDATE_SELL_STORY_FORM
        case .updateSecondFormStory: return UPDATE_SECOND_FORM_STORY
        case .getUserStory: return GET_USER_STORY
        case .getFilterStoryList: return GET_FILTER_STORY_LIST
        case .getMyStory: return GET_MYSTORY
        case .getMySaveStory: return GET_MY_SAVE_STORY
        case .getMyFilterSaveStory: return GET_MY_SAVE_FILTER_STORY
        case .getMyStoryFilterList: return GET_MY_STORY_FILTER_STORY
//        case .getContentType: return GET_CONTENT_TYPE_DATA
        case .contactUs: return CONTACT_US
        case .changePassword: return CHANGE_PASSWORD
        case .forgetPassword: return FORGRT_PASSWORD
        case .otpVerification: return OTP_VERIFICATION
        case .resetPassword: return RESET_PASSWORD
            
        case .createAssignment: return CREATE_ASSIGNMENT
        case .myAssignmentList: return MY_ASSIGNMENT_LIST
        case .searchMyAssignmentList: return SEARCH_MY_ASSIGNMENT_LIST
        case .editorAssignmentList: return EDITORS_ASSIGNMENT_LIST
        case .searchEditorAssignment: return SEARCH_EDITORS_ASSIGNMENT
        case .assignmentReplay: return ASSIGNMENT_REPLAY
        case .removeAssignment: return REMOVE_ASSIGNMENT
            
        case .earningStoryList: return EARNING_STORY_LIST
        case .earningStoryByID: return EARNING_STORY_BY_ID
            
        case .jobList: return JOB_LIST
        case .searchJobList: return SEARCH_JOB_LIST
        case .appliedJob: return APPLIED_JOB
            
        case .contentUpload: return CONTENT_UPLOAD_LIST
        case .searchMyAllTypeStory: return SEARCH_ALL_TYPE_STORY
        case .searchSavedStory: return SEARCH_SAVE_STORY
        case .searchMyStory: return SEARCH_MY_STORY
        case .mediaType: return MEDIA_TYPE
        case .addJournalistFavList: return ADD_JOURNALIST_FAV_STORY
        case .getJournalistDataByID: return JOURNALIST_DATA_BY_ID
        case .getStoryDataByID: return STORY_DATA_BY_ID
        case .getReviewByStoryID: return GET_REVIEW_BY_STORY_ID
        case .editorialChatList: return EDITORIAL_CHAT_LIST
            
           //========collobrate module======
        case .getJournalistInviteList: return GET_INVITE_JOURNALIST_LIST
        case .createGroup: return CREATE_GROUP
        case .newRequestGroupList: return NEW_REQUEST_GROUP_LIST
        case .requestAcceptRejectGroup: return REQUEST_ACCEPT_REJECT_GROUP
        case .addedGroupList: return ADDED_GROUP_LIST
        case .leaveGroup: return LEAVE_GROUP
        case .chatList: return CHAT_LIST
        case .insertChatListJournalist: return INSERT_CHAT_JOURNALIST
            
        case .getSaveCollobrateStoryList: return GET_SAVE_COLLOBRATE_STORY
        case .getSearchSaveCollobateStoryList: return GET_SEARCH_SAVE_COLLOBRATE_STORY
        case .getFilterSaveCollobrateStoryList: return GET_FILTER_SAVE_COLLOBRATE_STORY
        case .invitedCollaboratedStoryList: return INVITE_COLLABORATED_STORY_LIST
        case .approvedCollaboratedStoryList: return APPROVED_COLLABORATED_STORY_LIST
        case .pendingCollaboratedStoryList: return PENDING_COLLABORATED_STORY_LIST
        case .collaboratedStoryInvitationStatus: return COLLABORATED_STORY_INVITATION_STATUS
            
        case .saveStoryPostById: return SAVE_STORY_POST_BY_ID
            
        case .updateProfilePic: return UPDATE_PROFILE_PIC
        case .updateProfileVideo: return UPDATE_PROFILE_PIC
        case .editPersonalInfo: return EDIT_PERSONAL_INFO
            
        case .translateFIlePriceJM: return TRANSLATE_FILE_PRICE_JM
        case .transnlateAndTranscribe: return TRANSLATE_AND_TRASCRIBE
        case .translateListJM: return TRANSLATE_LIST_JM
        case .traslateDeleteJM: return TRANSLATE_DELETE_JM
            
        case .notificationList: return NOTIFICATION_LIST_JM
            
        case .membershipPlansListJM: return MEMBERSHIP_PLANS_LIST_JM
        case .mebershipPaymentJM: return MEMBERSHIP_PAYMENTS_JM
        case .checkCouponJM: return CHECK_COUPON_JM
            
        case .ethicMemberEnquiry: return ETHIC_MEMBER_ENQUIRY_JM
            
        case .deleteStoryJM: return DELETE_STORY_JM
        case .increaseStoryView: return INCREASE_STORY_VIEW
        case .deleteStoryFileByID: return DELETE_STORY_FILE_BY_ID
        case .liveVideoStartJournalist: return LIVE_VIDEO_START_JOURNALIST
            
        case .getProfileStatus: return GET_PROFILE_STATUS
            
        case .getFaqMediaAndJournalist: return GET_FAQ_MEDIA_AND_JOURNALIST
            
        case .getRegistrationFeePlans: return GET_REGISTRATION_FEE_PLANS
        case .registrationFeePayment: return REGISTRATION_FEE_PAYMENT
        case .journalistEthicsChat: return JOURNALIST_ETHIC_CHAT_LIST
            
            //============================Media house Api
        case .mediahousefrequency: return MEDIAHOUSE_FREQUENCY
        case .companyInformation : return COMPANY_INFORMATION
        case .mediaSocialAccountLink : return MEDIAHOUSE_SOCIAL_LINKS
        case .getMediaStory : return GET_MEDIA_STORY
        case .searchStory : return SEARCH_MEDIA_STORY
        case .adminCategory : return ADMIN_CATEGORY
        case .filetrStory : return FILTER_STORY
        case .favouriteStory : return ADD_FAV_MEDIA
        case .jobCategory : return JOB_CATEGORY
        case .jobFunctionalArea : return FUNCTIONAL_AREA_CATEGORY
        case .jobRole : return JOB_ROLE
        case .jobQualification : return JOB_QUALIFICATION
        case .jobKeyword : return JOB_KEYWORD
        case .getMediahouseProfile : return MEDIAHOUSE_PROFILE
        case .mediaHousePersonalInfo : return MEDIAHOUSE_PERSONALINFO
        case .inviteUserMediaHousePersonalInfo : return INVITE_USER_MEDIAHOUSE_PERSONALINFO
        case .changePasswordMedia : return CHANGE_PASS_MEDIA
        case .mediaContactUs : return MEDIA_CONTACTUS
        case .mediaEnquiry : return MEDIA_ENQUIRY
        case .favouriteMediaStory : return FAVORITE_MEDIASTORY
        case .mediahouseAssignmentList : return MEDIAHOUSE_ASSIGNMENT
        case .postMediaAssignment : return POST_MEDIA_ASSIGNMENT
        case .searchMediaAssignment : return SEARCH_MEDIA_ASSIGNMENT
        case .journalistAssignmentList : return JOURNALIST_ASSIGNMENT_LIST
        case .createjobMedia : return CREATE_MEDIA_JOB
        case .searchMediaJob : return SEARCH_MEDIA_JOB
        case .purchaseStroryList : return PURCHASE_STORY_LIST
        case .currency : return CURRENCY_LIST
        case .notificationListMedia : return NOTIFICATION_LIST
        case .translate : return TRANSLATE_TRANNSCRIBE
        case .deleteTranslate : return DELETE_TRANSLATE
        case .translatePriceMedia : return TRANSLATE_FILE_PRICE_MEDIA
        case .getReply : return GET_REPLY
        case .chatLists : return CHAT_LISTS
        case .insertChatListMedia : return INSERT_CHAT_LIST_MEDIA
        case .storyReview : return STORY_REVIEWS
        case .ethicMember : return ETHIC_MEMBER
        case .storyPayment : return STORY_PAYMENT
        case .mediaBidding : return MEDIABAZAR_BIDDING
        case .newEventList : return NEW_EVENT_LIST
        case .purchaseEventList : return PURCHASE_EVENT_LIST
        case .getVideoComment : return GET_VIDEO_COMMENT
        case .addVideoComment : return ADD_VIDEO_COMMENT
        case .newEventPayment : return NEW_EVENT_PAYMENT
        case .getVideoEventStatus : return GET_VIDEO_EVENT_STATUS
            
        case .getMediaMembersPlans : return MEDIA_MEMBERSHIP_PLAN
        case .membershipPlansPayMedia : return MEMBERSHIP_PLANS_PAY_MEDIA
            
        case .deleteContentByID : return DELETE_CONTENT_BY_ID
        case .renameUploadedContent : return RENAME_UPLOADED_CONTENT
            
        case .appContentData : return APP_CONENT_DATA
            
        case .mediaHouseLogo : return MEDIAHOUSE_LOGO
        case .downloadPurchaseStory : return DOWNLOAD_PURCHASE_STORY
            
        case .getMediaJournalistByStorty : return GET_MEDIA_JOPURNALIST_BY_STORY
        case .getMediaJournalistAssignmentByID : return GET_MEDIA_JOURNALIST_ASSIGNMENT_BY_ID
        case .getMediaStoryListByJournalistID : return GET_MEDIA_JOURNALIST_STORY_JOURNALIST_ID
        case .getMediaEthicsChatList: return MEDIA_ETHICS_CHAT_LIST
        }
    }
}

struct Constant {
    static var statusBarHeight: CGFloat?
    
}




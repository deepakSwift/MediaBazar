//
//  FindAJobDetailViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//


import UIKit
import JDStatusBarNotification
import TSMessages

let kNavigationColor = UIColor(red:30.0/255.0, green:48.0/255.0, blue:58.0/255, alpha:1.0)
let kApplicationRedColor = UIColor(red:250.0/255.0, green:99.0/255.0, blue:98.0/255, alpha:1.0)
let warningMessageShowingDuration = 1.25

let kUserDefaults = UserDefaults.standard

let separatorText = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"

/*============== NOTIFICATIONS ==================*/
extension NSNotification.Name {
    public static let RIDE_REQUEST_NOTIFICATION = NSNotification.Name("RideAcceptNotification")
    public static let RIDE_CANCELLED_NOTIFICATION = NSNotification.Name("RideCancelledNotification")
    public static let ADD_EMERGENCY_CONTACT_NOTIFICATION = NSNotification.Name("AddEmergencyContactNotification")
    public static let ADD_CAR_NOTIFICATION = NSNotification.Name("AddCarNotification")
    public static let EDIT_PROFILE_NOTIFICATION = NSNotification.Name("EditProfileNotification")
    public static let COLLECT_FARE_NOTIFICATION = NSNotification.Name("CollectFareNotification")
    public static let RIDE_COMPLETE_NOTIFICATION = NSNotification.Name("RideCompleteNotification")
    public static let GOTO_DASHBOARD_NOTIFICATION = NSNotification.Name("GoToDashboardNotification")
    public static let START_RIDE_NOTIFICATION = NSNotification.Name("StartRideNotification")
    public static let RIDE_REJECT_NOTIFICATION = NSNotification.Name("RideRejectNotification")
    public static let CAR_SELECTED_NOTIFICATION = NSNotification.Name("CarSelectedNotification")
    public static let ADDED_EMERGENCY_CONTACT_NOTIFICATION = NSNotification.Name("AddedEmergrncyContactNotification")

    public static let FORGET_PASSWORD_NOTIFICATION = NSNotification.Name("ForgetPasswordNitofication")

    public static let USER_LOGIN_NOTIFICATION = NSNotification.Name("UserLoginNitofication")
    public static let PAYMENT_RIDE_NOTIFICATION = NSNotification.Name("PaymentRideNitofication")

}


let kNotificationType = "notification_type"
let kRideRequestNotification = "ride_request"
let kRideCancelledNotification = "cancel_ride"
let kPaymentRideNotification = "payment_for_ride"


/*========== SOME GLOBAL VARIABLE FOR USERS ==============*/


let kUserName = "user_name"
let kFCMToken = "FCMToken"

let appID = ""


let kIsLoggedIN = "is_logged_in"
let kUserEmail = "user_email"
let kPassword = "password"
let kDeviceToken = "DeviceToken"
let kAppToken = "App-Token"
let kUser = "user_id"
let kCurrentDashboard = "currentDashboard"

/*============= Error Code ===================*/

enum ErrorCode:Int{
    case success
    case failure
    case forceUpdate
    case sessionExpire

    init(rawValue:Int) {
        if rawValue == 102{
            self = .forceUpdate
        }else if rawValue == 345{
            self = .sessionExpire
        }else if ((rawValue >= 200) && (rawValue < 300)){
            self = .success
        }else{
            self = .failure
        }
    }
}


/*================== SOCIAL LOGIN TYPE ====================================*/
enum SocialLoginType: String {
    case facebook = "facebook"
    case google = "google"
}

/*======================== CONSTANT MESSAGES ==================================*/

let NETWORK_NOT_CONNECTED_MESSAGE = "Network is not connected!"
let FUNCTIONALITY_PENDING_MESSAGE = "Under Development. Please ignore it!"
let ALERT_TITTLE_MESSAGE = "Important Message"


/*============== SOCIAL MEDIA URL SCHEMES ==================*/

let SELF_URL_SCHEME = "com.tecorb.CartingKidzsDriver"

/*============== PRINTING IN DEBUG MODE ==================*/

func print_debug <T>(_ object : T){
    print(object)
}

func print_log <T>(_ object : T){
//    NSLog("\(object)")
}





/*============== SHOW MESSAGE ==================*/


func showSuccessWithMessage(_ message: String)
{
    JDStatusBarNotification.show(withStatus: message, dismissAfter: warningMessageShowingDuration, styleName: JDStatusBarStyleSuccess)

    // TSMessage.showNotification(withTitle: message, type: TSMessageNotificationType.success)
}
func showErrorWithMessage(_ message: String)
{
    JDStatusBarNotification.show(withStatus: message, dismissAfter: warningMessageShowingDuration, styleName: JDStatusBarStyleError)
    //TSMessage.showNotification(withTitle: message, type: TSMessageNotificationType.error)
}
func showWarningWithMessage(_ message: String)
{
   // JDStatusBarNotification.show(withStatus: message, dismissAfter: warningMessageShowingDuration, styleName: JDStatusBarStyleWarning)
    TSMessage.showNotification(withTitle: message, type: TSMessageNotificationType.warning)
}
func showMessage(_ message: String)
{
   // JDStatusBarNotification.show(withStatus: message, dismissAfter: warningMessageShowingDuration, styleName: JDStatusBarStyleDefault)
    TSMessage.showNotification(withTitle: message, type: TSMessageNotificationType.message)
}


func showAlertWith(_ viewController: UIViewController,message:String,title:String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
        alert.dismiss(animated: true, completion: nil)
    }
    alert.addAction(okayAction)
    viewController.present(alert, animated: true, completion: nil)
}



/*================== API URLs ====================================*/
//
//let BASE_URL = "http://designoweb.work/rent/api/"
//let API_VERSION = "api/v1/"
//
//let REGISTERATION_URL = "\(BASE_URL)registration"
//let LOGIN_URL = "\(BASE_URL)login"
//let CITY_URL = "\(BASE_URL)city"
//let STATE_URL = "\(BASE_URL)state"
//let GET_PROFILE_DATA_URL = "\(BASE_URL)getUserData"
//let CHANGE_PASSWORD_URL = "\(BASE_URL)changePassword"
//let FORGET_PASSWORD_URL = "\(BASE_URL)forgot"
//let UPDATE_PROFILE_URL = "\(BASE_URL)updateUserProfile"
//let ADD_POST_URL = "\(BASE_URL)doAddPost"
//let EDIT_POST_URL = "\(BASE_URL)doEditPost"
//let ROOM_TYPE_URL = "\(BASE_URL)roomType"
//let PROPERTY_TYPE_URL = "\(BASE_URL)propertyType"
//let PROPERTY_HOME_URL = "\(BASE_URL)getPostDataByLocationId"
//let PROPERTY_DETAIL_URL = "\(BASE_URL)getPostData"
//let FURNISH_TYPE_URL = "\(BASE_URL)furnishedType"
//let BANNER_IMAGES_URL = "\(BASE_URL)getBanner"
//let MY_POSTED_PROPERTY_URL = "\(BASE_URL)getPostDataByUserId"
//let WISHLIST_URL = "\(BASE_URL)getWishlist"
//let PAGES_URL = "\(BASE_URL)getPages"
//let WISHLIST_ADD_DELETE_URL = "\(BASE_URL)wishlist"
//let DELETE_POST = "\(BASE_URL)deletePropertyByPropertyId"
//let FILTER_CATEGORY_URL = "\(BASE_URL)filter_api"
//let FILTER_DATA = "\(BASE_URL)filter"

//enum api: String {
//    case base
//    case register
//    case login
//    case city
//    case state
//    case getProfileData
//    case changePassword
//    case forgetPassword
//    case updateProfile
//    case addPost
//    case editPost
//    case roomType
//    case propertyType
//    case propertyHome
//    case prppertyDetail
//    case furnishType
//    case bannerImages
//    case myPostedProperty
//    case wishlist
//    case pages
//    case wishlistAddOrDelete
//    case deletePost
//    case filterCategoryData
//    case filterData
//
//    func url() -> String {
//        switch self {
//        case .base : return BASE_URL
//        case .register : return REGISTERATION_URL
//        case .login : return LOGIN_URL
//        case .city : return CITY_URL
//        case .state: return STATE_URL
//        case .getProfileData: return GET_PROFILE_DATA_URL
//        case .changePassword: return CHANGE_PASSWORD_URL
//        case .forgetPassword: return FORGET_PASSWORD_URL
//        case .updateProfile: return UPDATE_PROFILE_URL
//        case .addPost: return ADD_POST_URL
//        case .editPost: return EDIT_POST_URL
//        case .roomType: return ROOM_TYPE_URL
//        case .propertyType: return PROPERTY_TYPE_URL
//        case .propertyHome: return PROPERTY_HOME_URL
//        case .prppertyDetail: return PROPERTY_DETAIL_URL
//        case .furnishType: return FURNISH_TYPE_URL
//        case .bannerImages: return BANNER_IMAGES_URL
//        case .myPostedProperty: return MY_POSTED_PROPERTY_URL
//        case .wishlist: return WISHLIST_URL
//        case .pages: return PAGES_URL
//        case .wishlistAddOrDelete: return WISHLIST_ADD_DELETE_URL
//        case .deletePost: return DELETE_POST
//        case .filterCategoryData: return FILTER_CATEGORY_URL
//        case .filterData: return FILTER_DATA
//
//        }
//    }
//}






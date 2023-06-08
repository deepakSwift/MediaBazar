//
//  AppSettings.swift
//  FoodClubDeliveryBoy
//
//  Created by admin on 07/05/18.
//  Copyright © 2018 Tecorb. All rights reserved.
//

import UIKit
import CoreFoundation
import SystemConfiguration

class AppSettings{
    
    static let shared = AppSettings()
    fileprivate init() {}
    var isLoggedIn: Bool{
        get{
            let result = kUserDefaults.bool(forKey:kIsLoggedIN)
            return result
        }
        set(newIsLogin){
            kUserDefaults.set(newIsLogin, forKey: kIsLoggedIN)
        }
    }
    
    var isPunched : Bool {
        if punchInDate != "" && punchOutDate == ""{
            return false
        }
        return (punchInDate == punchOutDate)
    }
    
     func getDateString(_ date: Date) -> String{
        let df  = DateFormatter()
        df.locale = Locale.current
        df.locale = Locale.autoupdatingCurrent
        df.timeZone = TimeZone.autoupdatingCurrent
        df.dateFormat = "dd"
        let ddStr = df.string(from: date)
        return ddStr
    }
    
    var shouldShowPunchButton:Bool{
        let todayDate = self.getDateString(Date())
        return (todayDate != punchOutDate)
    }
    
    var punchOutDate : String {
        get{
            let prePunchDate = kUserDefaults.string(forKey: "punchOutDate")
            return prePunchDate ?? ""
        }
        set (newPunched){
            kUserDefaults.set(newPunched, forKey: "punchOutDate")
        }
    }
    
    var punchInDate : String {
        get{
            let prePunchDate = kUserDefaults.string(forKey: "punchInDate")
            return prePunchDate ?? ""
        }
        set (newPunched){
            kUserDefaults.set(newPunched, forKey: "punchInDate")
        }
    }
    
    
    var currentDashboard : String{
        get {
            var result = ""
            if let r = kUserDefaults.value(forKey:kCurrentDashboard) as? String{
                result = r
            }
            return result
        }
        set(newCurrentDashboard){
            kUserDefaults.set(newCurrentDashboard, forKey: kCurrentDashboard)
        }
    }
    
    
   func prepareHeader(withAuth:Bool) -> Dictionary<String,String>{
        let accept = "application/json"
        let currentVersion = UIApplication.appVersion()+"."+UIApplication.appBuild()
        var header = Dictionary<String,String>()
        if withAuth{
          //  let user = kUser.loadSavedUser()
          //  let userToken = user.apiKey
            //header.updateValue(userToken, forKey: "accessToken")
        }
        
        header.updateValue(currentVersion, forKey: "currentVersion")
        header.updateValue("ios", forKey: "currentDevice")
        header.updateValue(accept, forKey: "Accept")
        return header
    }
    
    func showForceUpdateAlert(){
        let alert = UIAlertController(title: warningMessage.title.rawValue, message: warningMessage.updateVersion.rawValue, preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "Update Now", style: .cancel) {[alert] (action) in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)"),
                UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:], completionHandler: {[alert] (done) in
                    alert.dismiss(animated: false, completion: nil)
                })
            }
        }
        alert.addAction(updateAction)
        let toastShowingVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        toastShowingVC?.present(alert, animated: true, completion: nil)
    }
    
    func showSessionExpireAndProceedToLandingPage(){
        NKToastHelper.sharedInstance.showErrorAlert(nil, message: warningMessage.sessionExpired.rawValue, completionBlock: {
            self.proceedToLoginModule()
        })
    }
    
    func proceedToLoginModule(){
        kUserDefaults.set(false, forKey: kIsLoggedIN)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "PreLogin", bundle: nil)
        let nav = mainStoryboard.instantiateViewController(withIdentifier: "navigationContoller") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
    
//    func proceedToWelcomeDashboard(){
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let menu = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
//        let nav = mainStoryboard.instantiateViewController(withIdentifier: "SlideNavigationController") as! SlideNavigationController
//        nav.leftMenu = menu
//        nav.enableSwipeGesture = true
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = nav
//    }

}

extension UIApplication {
    
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
}


extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

//
//  AppDelegate.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 17/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import Stripe
//import UserNotifications
//import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var currentUserLogin: User?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // To send analytics to firebase to fix app verify issue
        Analytics.logEvent("This is a test", parameters: [
            "Test1": "tester",
            "Test2": "tester"
        ])
        //        AppSettings.shared.isLoggedIn = true
        IQKeyboardManager.shared.enable = true
       // self.registerForRemoteNotification()
        Stripe.setDefaultPublishableKey("pk_test_V3llXBxT7KWmPhf39erEVODM00YtoKZPD1")
        // Override point for customization after application launch.
        
        if !AppSettings.shared.isLoggedIn {// new user i.e. open get start screen
            
            let storyBoard = AppStoryboard.PreLogin.instance
            let navigationController = storyBoard.instantiateViewController(withIdentifier: "navigationContoller")
            self.window?.rootViewController = navigationController
            
        }else{
            //                    let storyBoard = AppStoryboard.PreLogin.instance
            //                    let navigationController = storyBoard.instantiateViewController(withIdentifier: "navigationContoller")
            //                    self.window?.rootViewController = navigationController
            
            currentUserLogin = User.loadSavedUser()
            print("user type --- \(currentUserLogin?.userType)")
            if currentUserLogin?.userType == "journalist"{
                let storyBoard = AppStoryboard.Journalist.instance
                let navigationController = storyBoard.instantiateViewController(withIdentifier: "TabBarControllerViewControllerJM")
                self.window?.rootViewController = navigationController
            } else {
                if currentUserLogin?.userType == "mediahouse"{
                    let storyBoard = AppStoryboard.MediaHouse.instance
                    let navigationController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                    self.window?.rootViewController = navigationController
                    
                }
            }
        }
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        currentUserLogin = User.loadSavedUser()
        if currentUserLogin?.userType == "journalist" {
            if currentUserLogin?.journalistId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin?.journalistId, online: false)
            }
        } else {
            if currentUserLogin?.mediahouseId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin?.mediahouseId, online: false)
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        currentUserLogin = User.loadSavedUser()
        if currentUserLogin?.userType == "journalist" {
            if currentUserLogin?.journalistId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin?.journalistId, online: true)
            }
        } else {
            if currentUserLogin?.mediahouseId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin?.mediahouseId, online: true)
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app : UIApplication , open url : URL, options : [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool{
        return Auth.auth().canHandle(url)
    }
    
    
    // make user go offline with timestamp when logout
    fileprivate func handleFirebaseStatus(userID: String?, online: Bool) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        guard let uuid = userID, uuid != "" else { // use to remove empty child error
            return
        }
        let usersReference = ref.child("users").child(uuid)
        var onlineStatus: [String : AnyObject]?
        
        if online {
            onlineStatus = ["lastSeen": ServerValue.timestamp(), "status": "online"] as [String : AnyObject]
        } else {
            onlineStatus = ["lastSeen": ServerValue.timestamp(), "status": "offline"] as [String : AnyObject]
        }
        
        usersReference.updateChildValues(onlineStatus!, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err!)
                return
            }
        })
    }
}


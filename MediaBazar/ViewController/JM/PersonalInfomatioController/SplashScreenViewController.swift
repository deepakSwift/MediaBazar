//
//  SplashScreenViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 17/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import WebKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var globeWebView: UIWebView!
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var applicationStatusLabel : UIButton!
    @IBOutlet weak var apprivedLabel : UIButton!
    @IBOutlet weak var editorialChatButton: UIButton!
    
    var window: UIWindow?
    var currentUserLogin : User!
    var profileStatus = profileModal()
    
    var jourTokenByRegister = ""
    var jourTokenFlowSet = ""
    var newUserSignUp = ""

    
    var plans = paymentsModal()
    var plansList = paymentsModal()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        editorialChatButton.isHidden = true
//        setupUI()
//        setupButton()
//        setupWebView()
//        self.currentUserLogin = User.loadSavedUser()
//        print("\(currentUserLogin.token)")
//
//        if jourTokenFlowSet == "flowSetByApproved"{
//            getJournalistStatus(header: jourTokenByRegister)
//            getPlansList(header: jourTokenByRegister)
//        }else {
//            getJournalistStatus(header: currentUserLogin.token)
//            getPlansList(header: currentUserLogin.token)
//        }
        
//        getJournalistStatus(header: currentUserLogin.token)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        setupButton()
        setupWebView()
        self.currentUserLogin = User.loadSavedUser()
        print("\(currentUserLogin.token)")
        
        if jourTokenFlowSet == "flowSetByApproved"{
            getJournalistStatus(header: jourTokenByRegister)
            getPlansList(header: jourTokenByRegister)
        }else {
            getJournalistStatus(header: currentUserLogin.token)
            getPlansList(header: currentUserLogin.token)
        }
    }
    
    func setupButton(){
        loginButton.addTarget(self, action: #selector(pressedLoginButton), for: .touchUpInside)
        editorialChatButton.addTarget(self, action: #selector(editorialChat), for: .touchUpInside)
    }
    
    @objc func editorialChat() {
        let editorialChatVC = AppStoryboard.Journalist.viewController(EditorialChatController.self)
        self.navigationController?.pushViewController(editorialChatVC, animated: true)
    }
    
    func setupWebView() {
        let urlString = "https://5wh.com/account/show-globe"
        let request = URLRequest(url: URL(string: urlString)!)
        globeWebView.loadRequest(request)
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithRespectToHeight(loginButton, borderColor: .clear, borderWidth: 15)
        CommonClass.makeViewCircularWithRespectToHeight(editorialChatButton, borderColor: .clear, borderWidth: 15)
        
    }
    
    @objc func pressedLoginButton(){
        
        //                if currentUserLogin.userType == "journalist"{
        //                    if newUserSignUp == "membershipPlan"{
        //
        //                        let storyBoard = AppStoryboard.Journalist.instance
        //                        let navigationController = storyBoard.instantiateViewController(withIdentifier: "journalistRoootNavigationController") as! UINavigationController
        //                        AppDelegate.getAppDelegate().window?.rootViewController = navigationController
        //                        } else {
        //                        let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
        //                        self.navigationController?.pushViewController(loginVC, animated: true)
        //                    }
        //                } else if currentUserLogin.userType == "mediahouse"{
        //                    //                    let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
        //                    //                    self.navigationController?.pushViewController(homeVC, animated: true)
        //                    let storyBoard = AppStoryboard.MediaHouse.instance
        //                    let navigationController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
        //                    self.window?.rootViewController = navigationController
        //                }
        
        
        //        if profileStatus.profileStatus == 0{
        //            if newUserSignUp == "membershipPlan"{
        //                let HomeVC = AppStoryboard.Journalist.viewController(TabBarControllerViewControllerJM.self)
        //                self.navigationController?.pushViewController(HomeVC, animated: true)
        //            } else {
        //                let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
        //                self.navigationController?.pushViewController(loginVC, animated: true)
        //            }
        //        }else {
        //            print("Pending status\(profileStatus.profileStatus)")
        //
        //        }
        
        
        
        
//        if currentUserLogin.token == ""{
//            let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
//            self.navigationController?.pushViewController(loginVC, animated: true)
//        }else {
//            if profileStatus.profileStatus == 1{
//                if newUserSignUp == "membershipPlan"{
//                    let HomeVC = AppStoryboard.Journalist.viewController(TabBarControllerViewControllerJM.self)
//                    self.navigationController?.pushViewController(HomeVC, animated: true)
//                } else {
//                    let HomeVC = AppStoryboard.Journalist.viewController(TabBarControllerViewControllerJM.self)
//                    self.navigationController?.pushViewController(HomeVC, animated: true)
//                }
//            }else {
//
//            }
//
//        }
        
        if currentUserLogin.token == ""{
          let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
          self.navigationController?.pushViewController(loginVC, animated: true)
        }else {
            if newUserSignUp == "membershipPlan"{
                if profileStatus.profileStatus == 1{
                    if plansList.activePlans.count == 0{
                        let memberShipVC = AppStoryboard.Journalist.viewController(MembershipPlanViewControllerJM.self)
                        self.navigationController?.pushViewController(memberShipVC, animated: true)
                    }else {
                        let HomeVC = AppStoryboard.Journalist.viewController(TabBarControllerViewControllerJM.self)
                        self.navigationController?.pushViewController(HomeVC, animated: true)
                    }
                }else {
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Thanks for registering. Your account has been sent to Editorial board for approval.")
                }
            }
        }
        
        
    }
    
    func getJournalistStatus(header: String){
        //        CommonClass.showLoader()
        Webservice.sharedInstance.journalistProfileStatus(header: header){(result,response,message) in
            //            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.profileStatus = somecategory
                }
                
                if self.profileStatus.profileStatus == 1{
                    self.apprivedLabel.setTitle("Approved", for: .normal)
                    self.applicationStatusLabel.setTitle("Explore >>", for: .normal)
                    self.loginButton.setTitle("GET STARTED", for: .normal)
                }else if self.profileStatus.profileStatus == 0{
                    self.apprivedLabel.setTitle("Pending", for: .normal)
                    self.applicationStatusLabel.setTitle("", for: .normal)
                    self.loginButton.setTitle("GET STARTED", for: .normal)
                    self.editorialChatButton.isHidden = false
                }else {
                    self.apprivedLabel.setTitle("Reject", for: .normal)
                    self.applicationStatusLabel.setTitle("", for: .normal)
                    self.loginButton.setTitle("GET STARTED", for: .normal)
                }
                
            } else{
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getPlansList(header : String){
//        CommonClass.showLoader(withStatus: "Login...")
        Webservices.sharedInstance.plansList(Header: header){(result,message,response) in
//            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.plansList = somecategory
                    print("\(somecategory)")
                    print("\(self.plansList.activePlans.count)")
                    
                }
            }else{
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

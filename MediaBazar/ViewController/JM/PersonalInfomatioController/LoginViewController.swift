//
//  LoginViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 17/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var registerButton : UIButton!
    @IBOutlet weak var forgetPasswordButton : UIButton!
    @IBOutlet weak var iconButton : UIButton!
    
    var userData : User!
    var plansList = paymentsModal()
    var plans = paymentsModal()
    //var text = ""
    var iconClick = true
    var loginData = User()
    
    override func viewDidLoad() {
        emailTextField.text = ""
        passwordTextField.text = ""
        
        super.viewDidLoad()
        self.userData = User.loadSavedUser()
        //        getPlansList(header: userData.token)
        setUpUI()
        setupButton()
        //        let timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //        self.userData = User.loadSavedUser()
        //        getPlansList(header: userData.token)
        
    }
    
    
    func setupButton(){
        registerButton.addTarget(self, action: #selector(pressedRegisterButton), for: .touchUpInside)
        forgetPasswordButton.addTarget(self, action: #selector(preesedForgetPassButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        //self.text = userData.userType
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(loginButton, borderColor: .clear, borderWidth: 20)
    }
    
    @objc func pressedRegisterButton(){
        let registerLanguageVC = AppStoryboard.PreLogin.viewController(RegisterLanguageViewController.self)
        self.navigationController?.pushViewController(registerLanguageVC, animated: true)
    }
    
    @objc func preesedForgetPassButton(){
        let forgetVC = AppStoryboard.PreLogin.viewController(ForgetPasswordViewController.self)
        self.navigationController?.pushViewController(forgetVC, animated: true)
    }
    
    @objc func loginBtnPressed(){
        
        if isValidate() {
            userLogin(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    @IBAction func iconAction(sender: AnyObject) {
        if(iconClick == true) {
            passwordTextField.isSecureTextEntry = false
            iconButton.setImage(#imageLiteral(resourceName: "Group 3238"), for: .normal)
            
        } else {
            passwordTextField.isSecureTextEntry = true
            iconButton.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        }
        
        iconClick = !iconClick
    }
    
    //----Call Api----
    func userLogin(email : String,password: String){
        
        CommonClass.showLoader(withStatus: "Login...")
        Webservice.sharedInstance.signIn(email: email, password: password){(result, response,message) in
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory1 = response{
                    self.loginData = somecategory1
                }
                
                guard let data = response else {
                    return
                }
                
                print("===============\(data.userType)")
                print("===============\(data.prevJouralistData.invitedStatus)")
                
                if data.userType == "journalist" {
                    
                    if data.journalistId != "" {
                        self.handleFirebaseLogin(userID: data.journalistId, userType: data.userType)
                    }
                    print("token--------------------\(data.token)")
                    
                    if data.prevJouralistData.registrationPaymentStatus == 0{
                        self.getPlansList(header: data.token)
                    }else {
                        if self.loginData.stepCount == 0{
                            let step1 = AppStoryboard.PreLogin.viewController(InviteUserPersonalInformationViewControllerJM.self)
                            step1.invitejournalistToken = self.loginData.token
                            self.navigationController?.pushViewController(step1, animated: true)
                        } else if self.loginData.stepCount == 1{
                            let step2 = AppStoryboard.PreLogin.viewController(PersonalInformation3Controller.self)
                            step2.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step2, animated: true)
                        } else if self.loginData.stepCount == 2{
                            let step4 = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
                            step4.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step4, animated: true)
                        } else if self.loginData.stepCount == 4{
                            let step5 = AppStoryboard.PreLogin.viewController(SocialMediaLinksViewController.self)
                            step5.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step5, animated: true)
                        } else if self.loginData.stepCount == 5{
                            let step6 = AppStoryboard.PreLogin.viewController(PersonalInformation4ViewController.self)
                            step6.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step6, animated: true)
                        } else if self.loginData.stepCount == 6{
//                            if self.plansList.activePlans.count == 0{
                            if self.loginData.prevJouralistData.registrationPaymentStatus == 0{
                                    //                            let memberShipVC = AppStoryboard.Journalist.viewController(MembershipPlanViewControllerJM.self)
                                    //                            self.navigationController?.pushViewController(memberShipVC, animated: true)
                                    let registrationFeeVC = AppStoryboard.PreLogin.viewController(RegistrationPlanViewController.self)
                                    self.navigationController?.pushViewController(registrationFeeVC, animated: true)
                                    
                                }else {
                                    let splashScreen = AppStoryboard.PreLogin.viewController(SplashScreenViewController.self)
                                    splashScreen.newUserSignUp = "membershipPlan"
                                    self.navigationController?.pushViewController(splashScreen, animated: true)
                                }
                            }
                        }
                    } else {
                        if data.mediahouseId != "" {
                            self.handleFirebaseLogin(userID: data.mediahouseId, userType: data.userType)
                        }
                        
                        print("\(data.mediahouseToken)")
                        print("mediaInviteStatus=-=======\(data.prevJouralistData.invitedStatus)")
                        
                        //                    self.getMembershipPlansList(header: data.mediahouseToken)
                        
                        if data.UserInfo.invitedStatus == 0{
                            self.getMembershipPlansList(header: data.mediahouseToken)
                        }else {
                            if self.loginData.stepCount == 0{
                                let companyInfo = AppStoryboard.PreLogin.viewController(InviteUserCompanyInforMHViewController.self)
                                companyInfo.inviteMediaToken = data.mediahouseToken
                            }else if self.loginData.stepCount == 1{
                                let personalInfo2VC = AppStoryboard.PreLogin.viewController(CompanyAddressInfoVC.self)
                                personalInfo2VC.getMediaHouseId = self.loginData.mediahouseId
                                self.navigationController?.pushViewController(personalInfo2VC, animated: true)
                            }else if self.loginData.stepCount == 2{
                                let socialInfoVC = AppStoryboard.PreLogin.viewController(CompanySocialInfoVC.self)
                                socialInfoVC.mediaHouseId = self.loginData.mediahouseId
                                self.navigationController?.pushViewController(socialInfoVC, animated: true)
                            }else {
                                if self.plans.activePlans.count == 0{
                                    let memberShipVC = AppStoryboard.MediaHouse.viewController(ActiveAndCurrentPlansViewControllerMH.self)
                                    self.navigationController?.pushViewController(memberShipVC, animated: true)
                                }else {
                                    let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
                                    self.navigationController?.pushViewController(homeVC, animated: true)
                                }
                            }
                        }
                    }
                }else {
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
        
        func getPlansList(header : String){
            CommonClass.showLoader(withStatus: "Login...")
            Webservices.sharedInstance.plansList(Header: header){(result,message,response) in
                CommonClass.hideLoader()
                print(result)
                if result == 200{
                    if let somecategory = response{
                        self.plansList = somecategory
                        print("\(somecategory)")
                        print("\(self.plansList.activePlans.count)")
                        if self.loginData.stepCount == 0{
                            let step1 = AppStoryboard.PreLogin.viewController(PersonalInformationViewController.self)
                            self.navigationController?.pushViewController(step1, animated: true)
                        }else if self.loginData.stepCount == 1{
                            let step2 = AppStoryboard.PreLogin.viewController(PersonalInformation3Controller.self)
                            step2.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step2, animated: true)
                        } else if self.loginData.stepCount == 2 {
                            
                            let step3 = AppStoryboard.PreLogin.viewController(NewReferenceViewController.self)
                            step3.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step3, animated: true)
                        } else if self.loginData.stepCount == 3 {
                            
                            let step4 = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
                            step4.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step4, animated: true)
                        } else if self.loginData.stepCount == 4 {
                            let step5 = AppStoryboard.PreLogin.viewController(SocialMediaLinksViewController.self)
                            step5.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step5, animated: true)
                            
                        } else if self.loginData.stepCount == 5 {
                            let step6 = AppStoryboard.PreLogin.viewController(PersonalInformation4ViewController.self)
                            step6.journalistId = self.loginData.journalistId
                            self.navigationController?.pushViewController(step6, animated: true)
                        } else if self.loginData.stepCount == 6 {
                            //                        if self.plansList.activePlans.count == 0{
                            if self.loginData.prevJouralistData.registrationPaymentStatus == 0{
                                //                            let memberShipVC = AppStoryboard.Journalist.viewController(MembershipPlanViewControllerJM.self)
                                //                            self.navigationController?.pushViewController(memberShipVC, animated: true)
                                let registrationFeeVC = AppStoryboard.PreLogin.viewController(RegistrationPlanViewController.self)
                                self.navigationController?.pushViewController(registrationFeeVC, animated: true)
                            }else {
                                let splashScreen = AppStoryboard.PreLogin.viewController(SplashScreenViewController.self)
                                splashScreen.newUserSignUp = "membershipPlan"
                                self.navigationController?.pushViewController(splashScreen, animated: true)
                            }
                        }
                    } else{
                        
                    }
                }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
        
        
        
        func getMembershipPlansList(header : String){
            Webservices.sharedInstance.getMediaMemberPlansList(Header: header){(result,message,response) in
                print(result)
                if result == 200{
                    if let somecategory = response{
                        self.plans = somecategory
                        print("\(self.plansList.activePlans.count)")
                        //                    self.calculateTime()
                        //                        self.setUpData()
                        if self.loginData.stepCount == 0{
                            let companyInfo = AppStoryboard.PreLogin.viewController(CompanyPersonalInfoVC.self)
                            self.navigationController?.pushViewController(companyInfo, animated: true)
                        }else if self.loginData.stepCount == 1{
                            let personalInfo2VC = AppStoryboard.PreLogin.viewController(CompanyAddressInfoVC.self)
                            personalInfo2VC.getMediaHouseId = self.loginData.mediahouseId
                            self.navigationController?.pushViewController(personalInfo2VC, animated: true)
                        }else if self.loginData.stepCount == 2{
                            let socialInfoVC = AppStoryboard.PreLogin.viewController(CompanySocialInfoVC.self)
                            socialInfoVC.mediaHouseId = self.loginData.mediahouseId
                            self.navigationController?.pushViewController(socialInfoVC, animated: true)
                        }else {
                            if self.plans.activePlans.count == 0{
                                let memberShipVC = AppStoryboard.MediaHouse.viewController(ActiveAndCurrentPlansViewControllerMH.self)
                                self.navigationController?.pushViewController(memberShipVC, animated: true)
                            }else {
                                let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
                                self.navigationController?.pushViewController(homeVC, animated: true)
                            }
                        }
                        //                    if self.plans.activePlans.count == 0{
                        //                        let memberShipVC = AppStoryboard.MediaHouse.viewController(ActiveAndCurrentPlansViewControllerMH.self)
                        //                        self.navigationController?.pushViewController(memberShipVC, animated: true)
                        //                    }else {
                        //                      let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
                        //                        self.navigationController?.pushViewController(homeVC, animated: true)
                        //                    }
                        
                        print("\(somecategory)")
                    } else{
                        
                    }
                }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
        
        //------TextFields Validations-------
        func isValidate()-> Bool {
            if emailTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email address.")
                return false
            }
            else if !(emailTextField.text?.isValidEmail)!{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid email address.")
                return false
            }
            else if passwordTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the password.")
                return false
            }
            else if !(passwordTextField.text?.isValidPassword)! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Password must be of 8 digits.")
                return false
            }
            
            return true
        }
        
    }
    
    extension LoginViewController {
        func handleFirebaseLogin(userID uuid: String, userType: String) {
            
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uuid)
            
            let onlineValues = ["userType": userType, "lastSeen": ServerValue.timestamp(), "status": "online"] as [String : AnyObject]
            
            usersReference.updateChildValues(onlineValues, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
            })
        }
}




//
//  CompanySocialInfoVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CompanySocialInfoVC: UIViewController {
    
    @IBOutlet weak var textFieldFacebook: UITextField!
    @IBOutlet weak var textFieldYoutube: UITextField!
    @IBOutlet weak var textFieldInstagram: UITextField!
    @IBOutlet weak var textFieldSnapchat: UITextField!
    @IBOutlet weak var textFieldlinkedIn: UITextField!
    @IBOutlet weak var textFieldTwitter: UITextField!
    
    @IBOutlet weak var buttonCheckBox: UIButton!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonPrivacyPolicy: UIButton!
    @IBOutlet weak var buttonAgreement: UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    var checkButtonFlag = false
    var checkButtonFlag2 = false
    var socilaMediaarray = SocialMedialinkModel()
    var mediaHouseId = ""
    var currenUserLogin : User!
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        buttonContinue.makeRoundCorner(20)
    }
    
    
    func setupButton() {
        buttonCheckBox.addTarget(self, action: #selector(checkBoxBtnPreesed(sender:)), for: .touchUpInside)
        buttonContinue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
        buttonPrivacyPolicy.addTarget(self, action: #selector(onClickPrivacyButton), for: .touchUpInside)
        buttonAgreement.addTarget(self, action: #selector(onClickCustomebButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func checkBoxBtnPreesed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            checkButtonFlag = true
        } else {
            checkButtonFlag = false
        }
    }
    
    
    @objc func onClickPrivacyButton(){
        let privacyVC = AppStoryboard.MediaHouse.viewController(PrivacyPolicyVC.self)
        self.navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    @objc func onClickCustomebButton(){
        let customerVC = AppStoryboard.PreLogin.viewController(CustomerAgreementViewController.self)
        self.navigationController?.pushViewController(customerVC, animated: true)
    }
    
    
    @objc func continueButtonpressed() {
        if isValidate() {
            getsocialMediaLink(facebookLink: textFieldFacebook.text!, twitterLink: textFieldTwitter.text!, linkedinLink: textFieldlinkedIn.text!, snapChatLink: textFieldSnapchat.text!, instagramLink: textFieldInstagram.text!, youtubeLink: textFieldYoutube.text!, mediahouseId: mediaHouseId, stepCount: "3")
        }

    }
    
    //------- Api service ---------
    func getsocialMediaLink(facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String, instagramLink: String, youtubeLink: String, mediahouseId: String, stepCount: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.socialMediaLinkData(facebookLink: facebookLink, twitterLink: twitterLink, linkedinLink: linkedinLink, snapChatLink: snapChatLink, instagramLink: instagramLink, youtubeLink: youtubeLink, mediahouseId: mediahouseId, stepCount: stepCount){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    let membershipPlanVC = AppStoryboard.MediaHouse.viewController(ActiveAndCurrentPlansViewControllerMH.self)
                    self.navigationController?.pushViewController(membershipPlanVC, animated: true)
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------- textField Validations --------
    func isValidate()-> Bool {
        
        
        //-------condition for mandatory add 3 links
        counter = 0
        
        if textFieldFacebook.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if textFieldTwitter.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if textFieldlinkedIn.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if textFieldSnapchat.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if textFieldInstagram.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if textFieldYoutube.text == "" {
            counter += 1
            print("====================\(counter)")
        }
        
        
        if counter > 3 {
            print("====================\(counter)")
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add 3 links as it is mandatory.")
            return false
        }
        
        
    //------Normal condition
        
        if textFieldFacebook.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add facebook link as it is mandatory.")
            return false
        }
        else if !(textFieldFacebook.text?.isValidURL())!{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please write valid facebook URL.")
            return false
        }
            
        else if textFieldTwitter.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add twitter link as it is mandatory.")
            return false
        }
            
        else if !(textFieldTwitter.text?.isValidURL())! {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the twitter link.")
            return false
        }
            
        else if textFieldlinkedIn.text != ""{
            if !(textFieldlinkedIn.text?.isValidURL())! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid linkedIn URL.")
                return false
            }
        }
        else if textFieldSnapchat.text != ""{
            if !(textFieldSnapchat.text?.isValidURL())! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the Snapchat URL.")
                return false
            }
        }
            
        else if textFieldInstagram.text != ""{
            if !(textFieldInstagram.text?.isValidURL())! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the Instagram URL.")
                return false
            }
        }
            
        else if textFieldYoutube.text != ""{
            if !(textFieldYoutube.text?.isValidURL())! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the Youtube URL.")
                return false
            }
        }
            
        if checkButtonFlag == false {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please accept our Privacy Policy and Customer Agreement.")
            return false
        }
        
        
        return true
    }
}


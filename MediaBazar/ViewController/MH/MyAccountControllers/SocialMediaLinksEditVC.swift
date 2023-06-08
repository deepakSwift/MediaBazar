//
//  SocialMediaLinksEditVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 11/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksEditVC: UIViewController {

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
    @IBOutlet weak var buttonBack: UIButton!
    
    var getCompanyData = CompanyProfileModel()
    var checkButtonFlag = false
    var socilaMediaarray = SocialMedialinkModel()
    var currenUserLogin : User!
    var Facebook = ""
    var Youtube = ""
    var Instagram = ""
    var Snapchat = ""
    var linkedIn = ""
    var Twitter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        buttonContinue.makeRoundCorner(20)
    }
    
    func setupButton() {
        buttonCheckBox.addTarget(self, action: #selector(checkBoxBtnPreesed(sender:)), for: .touchUpInside)
         buttonContinue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(onClickBackBtn), for: .touchUpInside)
    }
    
    func setupData() {
        textFieldFacebook.text = Facebook
        textFieldYoutube.text = Youtube
        textFieldInstagram.text = Instagram
        textFieldSnapchat.text = Snapchat
        textFieldlinkedIn.text = linkedIn
        textFieldTwitter.text = Twitter
    }
    
    @objc func onClickBackBtn(){
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
    
    @objc func continueButtonpressed() {
        if isValidate() {
            getsocialMediaLink(facebookLink: textFieldFacebook.text!, twitterLink: textFieldTwitter.text!, linkedinLink: textFieldlinkedIn.text!, snapChatLink: textFieldSnapchat.text!, instagramLink: textFieldInstagram.text!, youtubeLink: textFieldYoutube.text!, mediahouseId: currenUserLogin.mediahouseId, stepCount: "3")
        }
//        let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
//        self.navigationController?.pushViewController(homeVC, animated: true)
    }

    //------- Api service ---------
    func getsocialMediaLink(facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String, instagramLink: String, youtubeLink: String, mediahouseId: String, stepCount: String){
            CommonClass.showLoader()
           WebService3.sharedInstance.socialMediaLinkData(facebookLink: facebookLink, twitterLink: twitterLink, linkedinLink: linkedinLink, snapChatLink: snapChatLink, instagramLink: instagramLink, youtubeLink: youtubeLink, mediahouseId: mediahouseId, stepCount: stepCount){(result,response,message) in
               CommonClass.hideLoader()
               print(result)
               if result == 200{
                   if let somecategory = response{
//                       self.socilaMediaarray = somecategory  //need to change data model because of token save data
                     // let url1 = NSURL(string: (socilaMediaarray.))
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Social links updated sucessfully.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                   }
               }else{
                   NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
               }
           }
       }
       
    //-------- textField Validations --------
    func isValidate()-> Bool {
        
        if textFieldFacebook.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter facebook link.")
            return false
        }
        else if textFieldTwitter.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the twitter link.")
            return false
        }
        else if textFieldlinkedIn.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the linkedIn link.")
            return false
        }
        else if textFieldSnapchat.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the snapchat link.")
            return false
        }
        else if textFieldInstagram.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the instagram link.")
            return false
        }
        else if textFieldYoutube.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the youtube link.")
            return false
        } else if checkButtonFlag == false {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please accept the privacy & policy.")
            return false
        }
        return true
    }

}

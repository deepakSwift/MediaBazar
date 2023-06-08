//
//  SocialMediaLinksViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksViewController: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var socialMediaLinkTableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!
    
    var socilaMediaarray = SocialMedialinkModel()
    var checkButtonFlag = false
    var checkButtonFlag2 = false
    var journalistId = ""
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onclickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    func setupUI(){
        self.socialMediaLinkTableView.dataSource = self
        self.socialMediaLinkTableView.delegate = self
        socialMediaLinkTableView.rowHeight = UITableView.automaticDimension
        socialMediaLinkTableView.estimatedRowHeight = 1000
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        
    }
    
    
    
    @objc func onclickContinueButton(){
        
        guard let cell = socialMediaLinkTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SocialMediaLinksTableViewCell else { print("cell not found"); return }
        
        
        func isValidate()-> Bool {
            
            
           //-------condition for mandatory add 3 links
            counter = 0
            
            if cell.textFieldFacebook.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if cell.textFieldTwitter.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if cell.textFieldLinkedInn.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if cell.textFieldSnapchat.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if cell.textFieldInstagram.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if cell.textFieldYoutube.text == "" {
                counter += 1
                print("====================\(counter)")
            }
            
            
            if counter > 3 {
                print("====================\(counter)")
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add 3 links as it is mandatory.")
                //return false
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
          //--------Normal conditon
            
            if cell.textFieldFacebook.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add facebook link as it is mandatory.")
                return false
            }
            else if !(cell.textFieldFacebook.text?.isValidURL())!{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please write valid facebook URL.")
                return false
            }
            else if cell.textFieldTwitter.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please add twitter link as it is mandatory.")
                return false
            }
                
            else if !(cell.textFieldTwitter.text?.isValidURL())! {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid twitter link.")
                return false
            }
            else if cell.textFieldLinkedInn.text != ""{
                if !(cell.textFieldLinkedInn.text?.isValidURL())! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid linkedIn URL.")
                    return false
                }
            }
            else if cell.textFieldSnapchat.text != ""{
                if !(cell.textFieldSnapchat.text?.isValidURL())! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid Snapchat URL.")
                    return false
                }
            }
            else if cell.textFieldInstagram.text != ""{
                if !(cell.textFieldInstagram.text?.isValidURL())! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid Instagram  URL.")
                    return false
                }
            }
            else if cell.textFieldYoutube.text != ""{
                if !(cell.textFieldYoutube.text?.isValidURL())! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid Youtube URL.")
                    return false
                }
            }
                
            else if checkButtonFlag == false {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please accept our Privacy Policy and Customer Agreement.")
                return false
            }
                
            else if checkButtonFlag2 == false {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please agree and accept the terms of the journalist's master contractor and code of ethics.")
                return false
            }
            
            return true
        }
        
        
        
        if isValidate() {
            
            if counter <= 3 {
                print("====================\(counter)")
                getsocialMediaLink(facebookLink: cell.textFieldFacebook.text!, twitterLink: cell.textFieldTwitter.text!, linkedinLink: cell.textFieldLinkedInn.text!, snapChatLink: cell.textFieldSnapchat.text!, instagramLink: cell.textFieldInstagram.text!, youtubeLink: cell.textFieldYoutube.text!, journalistId: journalistId, stepCount: "5")
            }
            
            //            }
        }
        
        
        //let submitVC = AppStoryboard.PreLogin.viewController(PersonalInformation4ViewController.self)
        //self.navigationController?.pushViewController(submitVC, animated: true)
        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getsocialMediaLink(facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String, instagramLink: String, youtubeLink: String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.socialMediaLinkData(facebookLink: facebookLink, twitterLink: twitterLink, linkedinLink: linkedinLink, snapChatLink: snapChatLink, instagramLink: instagramLink, youtubeLink: youtubeLink, journalistId: journalistId, stepCount: stepCount){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.socilaMediaarray = somecategory
                    self.socialMediaLinkTableView.reloadData()
                    // let url1 = NSURL(string: (socilaMediaarray.))
                    let submitVC = AppStoryboard.PreLogin.viewController(PersonalInformation4ViewController.self)
                    submitVC.journalistId = journalistId
                    self.navigationController?.pushViewController(submitVC, animated: true)
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension SocialMediaLinksViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialMediaLinksTableViewCell") as! SocialMediaLinksTableViewCell
        cell.butonPrivatePolicy.addTarget(self, action: #selector(onclickPrivatePolicyButton(_:)), for: .touchUpInside)
        cell.customerButton.addTarget(self, action: #selector(onClickCustomebButton), for: .touchUpInside)
        cell.privacyButton.addTarget(self, action: #selector(onClickPrivacyButton), for: .touchUpInside)
        cell.buttonTermsAndCondition.addTarget(self, action: #selector(onClickTerms2(_:)), for: .touchUpInside)
        cell.contractorButton1.addTarget(self, action: #selector(onClickContractButton), for: .touchUpInside)
        cell.ontractorButton2.addTarget(self, action: #selector(onClickContractButton), for: .touchUpInside)
        cell.ethicsButton.addTarget(self, action: #selector(onClickCodeOFEthicsButton), for: .touchUpInside)
        
        return cell
    }
    
    @objc func onclickPrivatePolicyButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            checkButtonFlag = true
        } else if sender.isSelected == false {
            checkButtonFlag = false
        }
    }
    
    @objc func onClickTerms2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            checkButtonFlag2 = true
        } else if sender.isSelected == false {
            checkButtonFlag2 = false
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
    
    @objc func onClickContractButton(){
        let contractVC = AppStoryboard.Journalist.viewController(JournalisMasterontractorViewController.self)
        self.navigationController?.pushViewController(contractVC, animated: true)
    }
    
    @objc func onClickCodeOFEthicsButton(){
        let ethicsVC = AppStoryboard.Journalist.viewController(CodeOfEthicsViewController.self)
        self.navigationController?.pushViewController(ethicsVC, animated: true)
    }
    
    
}

//
//  SocialMediaLinksViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksViewControllerJM: UIViewController {
    
    @IBOutlet weak var socialMediaLinkTableView : UITableView!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    

    var socialMedia = profileModal()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setupUI()
        setupButton()
        //        apiCall()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(bachButtonPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(clickOnSaveButton), for: .touchUpInside)
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func setupTableView(){
        self.socialMediaLinkTableView.dataSource = self
        self.socialMediaLinkTableView.delegate = self
        socialMediaLinkTableView.rowHeight = UITableView.automaticDimension
        socialMediaLinkTableView.estimatedRowHeight = 1000
    }
    
    
    @objc func bachButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnSaveButton(){
        
        guard let cell = socialMediaLinkTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SocialMediaLinksTableViewCellJM else { print("cell not found"); return }
        
        func isValidate()-> Bool {
            
            if cell.facebookLinkTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter facebook link.")
                return false
            }
            else if cell.twitterLinkTextFiled.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the twitter link.")
                return false
            }
            else if cell.linkedInLinkTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the linkedIn link.")
                return false
            }
            else if cell.snapchatLinkTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the snapchat link.")
                return false
            }
            else if cell.instagramLinkTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the instagram link.")
                return false
            }
            else if cell.youtubeLinkTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the youtube link.")
                return false
            }
            return true
        }
        
        if isValidate() {
            
            getsocialMediaLink(facebookLink: cell.facebookLinkTextField.text!, twitterLink: cell.twitterLinkTextFiled.text!, linkedinLink: cell.linkedInLinkTextField.text!, snapChatLink: cell.snapchatLinkTextField.text!, instagramLink: cell.instagramLinkTextField.text!, youtubeLink: cell.youtubeLinkTextField.text!, journalistId: socialMedia.id, stepCount: "5")
        }
    }
    
    func getsocialMediaLink(facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String, instagramLink: String, youtubeLink: String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.socialMediaLinkData(facebookLink: facebookLink, twitterLink: twitterLink, linkedinLink: linkedinLink, snapChatLink: snapChatLink, instagramLink: instagramLink, youtubeLink: youtubeLink, journalistId: journalistId, stepCount: stepCount){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                self.navigationController?.popViewController(animated: true)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension SocialMediaLinksViewControllerJM: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialMediaLinksTableViewCellJM") as! SocialMediaLinksTableViewCellJM
        cell.facebookLinkTextField.text = socialMedia.facebookLink
        cell.twitterLinkTextFiled.text = socialMedia.twitterLink
        cell.linkedInLinkTextField.text = socialMedia.linkedinLink
        cell.snapchatLinkTextField.text = socialMedia.snapChatLink
        cell.instagramLinkTextField.text = socialMedia.instagramLink
        cell.youtubeLinkTextField.text = socialMedia.youtubeLink
        return cell
    }
    
    
}

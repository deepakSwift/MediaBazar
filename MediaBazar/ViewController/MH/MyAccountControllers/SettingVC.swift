//
//  SettingVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class SettingVC: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewSettings: UITableView!
    @IBOutlet weak var buttonLogout: UIButton!
    
    var currentUserLogin: User!
    var fromVC = ""
    var userDetail = User()
    
    
    
    let journalistArrayTitle = ["Terms and Conditions","Journalist's Master Contract","Code of Ethics","Contact Us","About Us","Privacy Policy","Ethics Committee","Change Password"]
    
    let mediaHouseTitle = ["Terms and Conditions","Media House Contract","Code of Ethics","Contact Us","About Us","Privacy Policy","Ethics Committee","Change Password"]
    
//    var arrayOfTitile = [String]
    var arrayOfTitile: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
        currentUserLogin = User.loadSavedUser()
        
        
        if currentUserLogin.userType == "journalist"{
            arrayOfTitile = journalistArrayTitle
        }else {
            arrayOfTitile = mediaHouseTitle
        }
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonLogout.addTarget(self, action: #selector(logOutBtnPressed), for: .touchUpInside)
    }
    
    func setupTableView() {
        //registered XIB
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logOutBtnPressed(){
        logoutFirebaseStatus()
//        let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
        
        AppSettings.shared.isLoggedIn = false
        if currentUserLogin.userType == "mediahouse"{
            let emptyDict = ["result": ["mediahouseToken": ""]]
            //        let emptyDict = Dictionary <String ,AnyObject>()
            let json = JSON.init(emptyDict)
            userDetail.saveUserJSON(json)
        } else {
            let emptyDict = ["result": ["journalistToken": ""]]
            //        let emptyDict = Dictionary <String ,AnyObject>()
            let json = JSON.init(emptyDict)
            userDetail.saveUserJSON(json)
        }
        //        let emptyDict = ["result": ["journalistToken": ""]]
        ////        let emptyDict = Dictionary <String ,AnyObject>()
        //        let json = JSON.init(emptyDict)
        //        userDetail.saveUserJSON(json)
        
//        self.navigationController?.pushViewController(loginVC, animated: true)
        
        //        AppSettings.shared.isLoggedIn = false
                AppSettings.shared.proceedToLoginModule()
        
        UserDefaults.standard.removeObject(forKey: "keywordArray")
        
    }
    
}


//-- TableView----

extension SettingVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTitile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.labeltitle.text = arrayOfTitile[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let termAndConditionVC = self.storyboard?.instantiateViewController(withIdentifier: "TermAndConditionVC") as! TermAndConditionVC
            self.navigationController?.pushViewController(termAndConditionVC, animated: true)
            
        }else if indexPath.row == 1{
            let contractVC = AppStoryboard.Journalist.viewController(MediaHouseContractorViewController.self)
            self.navigationController?.pushViewController(contractVC, animated: true)
        }else if indexPath.row == 2{
            let codeOfEthicsVC = AppStoryboard.Journalist.viewController(CodeOfEthicsViewController.self)
            self.navigationController?.pushViewController(codeOfEthicsVC, animated: true)
        }else if indexPath.row == 3 {
            let contactUsVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            contactUsVC.fromVC = "SettingVC"
            self.navigationController?.pushViewController(contactUsVC, animated: true)
            
        } else if indexPath.row == 4 {
            let aboutUsVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(aboutUsVC, animated: true)
            
        } else if indexPath.row == 5 {
            let privacyPolicyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
            
        } else if indexPath.row == 6 {
            if fromVC == "JournalistEnquiry"{
                let enquiryJM = AppStoryboard.Journalist.viewController(EnquiryVCViewControllerJM.self)
                self.navigationController?.pushViewController(enquiryJM, animated: true)
            } else {
                let enquiryVC = AppStoryboard.Stories.viewController(EnquiryVC.self)
                enquiryVC.fromVC = "MediaHouseSetting"
                self.navigationController?.pushViewController(enquiryVC, animated: true)
            }
        } else if indexPath.row == 7 {
            let changePasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            changePasswordVC.fromVC = "SettingVC"
            self.navigationController?.pushViewController(changePasswordVC, animated: true)
            
        }
        
    }
    
}

extension SettingVC {
    
    fileprivate func logoutFirebaseStatus() {
        currentUserLogin = User.loadSavedUser()
        if currentUserLogin.userType == "journalist" {
            if currentUserLogin.journalistId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin.journalistId, online: false)
            }
        } else {
            if currentUserLogin.mediahouseId != "" {
                self.handleFirebaseStatus(userID: currentUserLogin.mediahouseId, online: false)
            }
        }
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

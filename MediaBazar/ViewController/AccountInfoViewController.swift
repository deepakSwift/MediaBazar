//
//  AccountInfoViewController.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//  MediaHouse

import UIKit
import SwiftyJSON

class AccountInfoViewController: UIViewController {
    
    @IBOutlet weak var tableViewProfile: UITableView!
    
    var arrayOfImage = [#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "copy-content"),#imageLiteral(resourceName: "earn-money"),#imageLiteral(resourceName: "earn-money"),#imageLiteral(resourceName: "plus-cross"),#imageLiteral(resourceName: "sort-2"),#imageLiteral(resourceName: "id-card"),#imageLiteral(resourceName: "asset-1"),#imageLiteral(resourceName: "asset-1"),#imageLiteral(resourceName: "heart"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "logout")]
    var arrayOfText = ["My Profile","Posted Job","Purchased Stories","Bid Stories"," Post an assignments","Translated & Transcribed","Membership","Support chat","Enquiry Chat","Favourite","Settings","FAQ","Logout"]
    
    var userDetail = User()
    
    var currenUserLogin : User!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        tableViewProfile.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

}

extension AccountInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountInfoTableCell", for: indexPath) as! AccountInfoTableCell
        cell.labelTitleName.text = arrayOfText[indexPath.row]
        cell.imageViewSetImg.image = arrayOfImage[indexPath.row]
        
        
             if indexPath.row == 12{
                cell.cellView.backgroundColor = UIColor.black
               cell.labelTitleName.textColor = UIColor.white
           }else {
               cell.cellView.backgroundColor = UIColor.white
               cell.labelTitleName.textColor = UIColor.black
           }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let myProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            self.navigationController?.pushViewController(myProfileVC, animated: true)
            
        } else if indexPath.row == 1 {
            let postedJobVC = self.storyboard?.instantiateViewController(withIdentifier: "PostedJobListVC") as! PostedJobListVC
            self.navigationController?.pushViewController(postedJobVC, animated: true)
            
        } else if indexPath.row == 2 {
            let purchaseStoriesVC = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseStoriesVC") as! PurchaseStoriesVC
            self.navigationController?.pushViewController(purchaseStoriesVC, animated: true)
            
        } else if indexPath.row == 3{
            let bidStoriVC = AppStoryboard.MediaHouse.viewController(AuctionBiddingStoryVC.self)
            self.navigationController?.pushViewController(bidStoriVC, animated: true)
            
        } else if indexPath.row == 4{
            let assignmentsCommonVC = self.storyboard?.instantiateViewController(withIdentifier: "AssignmentsCommonVC") as! AssignmentsCommonVC
            self.navigationController?.pushViewController(assignmentsCommonVC, animated: true)
            
        } else if indexPath.row == 5 {
            let translatedAndTrancribeVC = self.storyboard?.instantiateViewController(withIdentifier: "TranslatedAndTrancribeListVC") as! TranslatedAndTrancribeListVC
            self.navigationController?.pushViewController(translatedAndTrancribeVC, animated: true)
            
        } else if indexPath.row == 6 {
            let membershipPlanVC = self.storyboard?.instantiateViewController(withIdentifier: "ActiveAndCurrentPlansViewControllerMH") as! ActiveAndCurrentPlansViewControllerMH
            self.navigationController?.pushViewController(membershipPlanVC, animated: true)
            
        } else if indexPath.row == 7 {
//            let supportChatVC = self.storyboard?.instantiateViewController(withIdentifier: "SupportChatVC") as! SupportChatVC
//            self.navigationController?.pushViewController(supportChatVC, animated: true)
            self.supportChat()
            
        } else if indexPath.row == 8 {
            
            let enquiryChatVC = AppStoryboard.MediaHouse.viewController(EnuiryChatViewControllerMH.self)
            self.navigationController?.pushViewController(enquiryChatVC, animated: true)
            
        } else if indexPath.row == 9 {
            let favoriteVC = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteVC") as! FavoriteVC
            
            self.navigationController?.pushViewController(favoriteVC, animated: true)
            
        } else if indexPath.row == 10 {
            let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            
        } else if indexPath.row == 11 {
            let faqViewController = self.storyboard?.instantiateViewController(withIdentifier: "FaqViewController") as! FaqViewController
            self.navigationController?.pushViewController(faqViewController, animated: true)
            
        } else if indexPath.row == 12{
            AppSettings.shared.isLoggedIn = false
            let emptyDict = ["result": ["mediahouseToken": ""]]
            let json = JSON.init(emptyDict)
            userDetail.saveUserJSON(json)

            AppSettings.shared.proceedToLoginModule()

        }
    }
    
    
}

// Chat Extention
extension AccountInfoViewController {
    fileprivate func supportChat() {
        let tempDict: [String : AnyObject] = [
            "senderID": currenUserLogin.mediahouseId as AnyObject,
            "senderImage": currenUserLogin.UserInfo.logo as AnyObject,
            "senderFirstName": currenUserLogin.UserInfo.firstName as AnyObject,
            "senderMiddleName": currenUserLogin.UserInfo.middleName as AnyObject,
            "senderLastName": currenUserLogin.UserInfo.lastName as AnyObject,
            "senderUserType": currenUserLogin.userType as AnyObject,
            "receiverID": "admin" as AnyObject,
            "receiverImage": "" as AnyObject,
            "receiverFirstName": "Support Chat" as AnyObject,
            "receiverMiddleName": "" as AnyObject,
            "receiverLastName": "" as AnyObject,
            "receiverUserType": "" as AnyObject,
            "chatID": currenUserLogin.mediahouseId as AnyObject
        ]

        let chatUser = Users(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController = SupportChatLogController()
        let toUser = chatUser
        chatLogController.tokenID = currenUserLogin.mediahouseToken
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
}

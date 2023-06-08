//
//  MyAccountViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyAccountViewControllerJM: UIViewController {
    
    @IBOutlet weak var myAccountTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    
    var accountArray = ["My Profile","My Story","Saved Story","My Content","My Earnings","Collaboration","Collaborated Stories","Assignment","Find a Job","Translated & Transcribed","Membership","Support chat","Enquiry Chat","Favourite","Settings","FAQ","Logout"]
    var accountImageArray = [#imageLiteral(resourceName: "user"), #imageLiteral(resourceName: "copy-content"), #imageLiteral(resourceName: "bank"), #imageLiteral(resourceName: "story"),#imageLiteral(resourceName: "earn-money") ,#imageLiteral(resourceName: "team"),#imageLiteral(resourceName: "team") ,#imageLiteral(resourceName: "discuss-issue"), #imageLiteral(resourceName: "find"), #imageLiteral(resourceName: "sort-2"), #imageLiteral(resourceName: "id-card"),#imageLiteral(resourceName: "asset-1") ,#imageLiteral(resourceName: "asset-1"),#imageLiteral(resourceName: "heart"),#imageLiteral(resourceName: "settings") , #imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "logout")]
    
    var userDetail = User()
    
    var currenUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupTableView(){
        self.myAccountTableView.dataSource = self
        self.myAccountTableView.delegate = self
    }
    
    func setupUI(){
        topView.applyShadow()
        
    }
    
}

extension MyAccountViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAccountTableViewCellJM") as! MyAccountTableViewCellJM
        cell.titleLabel.text = accountArray[indexPath.row]
        cell.titleImage.image = accountImageArray[indexPath.row]
        
        if indexPath.row == 16{
            cell.backgroundColor = UIColor.black
            cell.titleLabel.textColor = UIColor.white
        }else {
            cell.backgroundColor = UIColor.white
            cell.titleLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let myProfileVC = AppStoryboard.Journalist.viewController(MyProfileViewControllerJM.self)
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        } else if indexPath.row == 1 {
            let myProfileVC = AppStoryboard.Journalist.viewController(MyStoriesViewControllerJM.self)
            self.navigationController?.pushViewController(myProfileVC, animated: true)
        } else if indexPath.row == 2 {
            let savedStoryVC = AppStoryboard.Journalist.viewController(SavedStoryControllerJM.self)
            self.navigationController?.pushViewController(savedStoryVC, animated: true)
        } else if indexPath.row == 3 {
            let contentVC = AppStoryboard.Journalist.viewController(MyContentUpdoadControllerJM.self)
            self.navigationController?.pushViewController(contentVC, animated: true)
        } else if indexPath.row == 4 {
            let myEarningVC = AppStoryboard.Journalist.viewController(MyEarningsViewControllerJM.self)
            self.navigationController?.pushViewController(myEarningVC, animated: true)
        } else if indexPath.row == 5 {
            let collaborationVC = AppStoryboard.Journalist.viewController(CollaborationViewControllerJM.self)
            self.navigationController?.pushViewController(collaborationVC, animated: true)
        } else if indexPath.row == 6 {
            let collaborationStoriesVC = AppStoryboard.Journalist.viewController(CollaboratedStoriesViewControllerJM.self)
            self.navigationController?.pushViewController(collaborationStoriesVC, animated: true)
        } else if indexPath.row == 7 {
            let assignmentVC = AppStoryboard.Journalist.viewController(AssignmentsViewControllerJM.self)
            self.navigationController?.pushViewController(assignmentVC, animated: true)
        } else if indexPath.row == 8{
            let findAJobVC = AppStoryboard.Journalist.viewController(FindAJobViewControllerJM.self)
            self.navigationController?.pushViewController(findAJobVC, animated: true)
        } else if indexPath.row == 9{
            let translateVC = AppStoryboard.Journalist.viewController(TranslateListViewControllerJM.self)
            self.navigationController?.pushViewController(translateVC, animated: true)
        } else if indexPath.row == 10{
            let memberShipVC = AppStoryboard.Journalist.viewController(ActivePlansViewControllerJM.self)
            memberShipVC.purchaseNewMembership = "purchaseNewMembership"
            self.navigationController?.pushViewController(memberShipVC, animated: true)
        } else if indexPath.row == 11{
//            let supportVC = AppStoryboard.Journalist.viewController(SupportChatViewControllerJM.self)
//            self.navigationController?.pushViewController(supportVC, animated: true)
            self.supportChat()
        }else if indexPath.row == 12{
            let enquiryVC = AppStoryboard.Journalist.viewController(EnquiryChatViewControllerJM.self)
            self.navigationController?.pushViewController(enquiryVC, animated: true)
        }else if indexPath.row == 13{
            let favouritVC = AppStoryboard.Journalist.viewController(FavouriteStoryViewControllerJM.self)
            self.navigationController?.pushViewController(favouritVC, animated: true)
        } else if indexPath.row == 14{
           let setingVC = AppStoryboard.MediaHouse.viewController(SettingVC.self)
            setingVC.fromVC = "JournalistEnquiry"
            self.navigationController?.pushViewController(setingVC, animated: true)
        } else if indexPath.row == 15{
            let faqVC = AppStoryboard.MediaHouse.viewController(FaqViewController.self)
            self.navigationController?.pushViewController(faqVC, animated: true)
        } else if indexPath.row == 16{
            AppSettings.shared.isLoggedIn = false
            let emptyDict = ["result": ["journalistToken": ""]]
            let json = JSON.init(emptyDict)
            userDetail.saveUserJSON(json)
            
            AppSettings.shared.proceedToLoginModule()


        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

// Chat Extention
extension MyAccountViewControllerJM {
    fileprivate func supportChat() {
        let tempDict: [String : AnyObject] = [
            "senderID": currenUserLogin.journalistId as AnyObject,
            "senderImage": currenUserLogin.prevJouralistData.profilePic as AnyObject,
            "senderFirstName": currenUserLogin.prevJouralistData.firstName as AnyObject,
            "senderMiddleName": currenUserLogin.prevJouralistData.middleName as AnyObject,
            "senderLastName": currenUserLogin.prevJouralistData.lastName as AnyObject,
            "senderUserType": currenUserLogin.prevJouralistData as AnyObject,
            "receiverID": "admin" as AnyObject,
            "receiverImage": "" as AnyObject,
            "receiverFirstName": "Support Chat" as AnyObject,
            "receiverMiddleName": "" as AnyObject,
            "receiverLastName": "" as AnyObject,
            "receiverUserType": "" as AnyObject,
            "chatID": currenUserLogin.journalistId as AnyObject
        ]

        let chatUser = Users(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController = SupportChatLogController()
        let toUser = chatUser
        chatLogController.tokenID = currenUserLogin.token
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
}

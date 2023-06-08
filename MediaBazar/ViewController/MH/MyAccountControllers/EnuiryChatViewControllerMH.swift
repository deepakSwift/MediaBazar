//
//  EnuiryChatViewControllerMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnuiryChatViewControllerMH: UIViewController {
    
    @IBOutlet weak var chatListTableView: UITableView!
    @IBOutlet weak var topView: UIView!
     @IBOutlet weak var buttonBack: UIButton!

    var allStoryList = [JournalistReplyModel]()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        apiCall()
    }
    
    fileprivate func setupUI() {
        topView.applyShadow()
        tabBarController?.tabBar.isHidden = true

    }
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        chatListTableView.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        chatListTableView.dataSource = self
        chatListTableView.delegate = self
        chatListTableView.tableFooterView = UIView()
        chatListTableView.bounces = false
        chatListTableView.alwaysBounceVertical = false
        chatListTableView.rowHeight = UITableView.automaticDimension
        chatListTableView.estimatedRowHeight = 1000
    }

func setupButton(){
    buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
}

@objc func backButtonPressed() {
    self.navigationController?.popViewController(animated: true)
}
    
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allStoryList.enumerated() {
            let tempData = data.element.createdAt
            tempTimeArray.append(tempData)
        }
        for data1 in tempTimeArray.enumerated() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let formatedStartDate = dateFormatter.date(from: data1.element)
            let currentDate = Date()
            let dayCount = Set<Calendar.Component>([.day])
            let hourCount = Set<Calendar.Component>([.hour])
            let differenceOfDay = Calendar.current.dateComponents(dayCount, from: formatedStartDate!, to: currentDate)
            let differenceOfTimes = Calendar.current.dateComponents(hourCount, from: formatedStartDate!, to: currentDate)
            if differenceOfDay.day == 0 {
                storyTimeArray.append("\(differenceOfTimes.hour!) hr ago")
            } else {
                storyTimeArray.append("\(differenceOfDay.day!) day ago")
            }
        }
    }
    
    func apiCall() {
        getChatList(header: currenUserLogin.mediahouseToken)
    }
    
    //------getChatList-------
    func getChatList(header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.mediaEthicsChatList(header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.allStoryList = somecategory
                    self.allStoryList.append(contentsOf: somecategory.docs)
                    self.chatListTableView.reloadData()
                    self.calculateTime()
                } else{
                    
                }
            }else{
                self.chatListTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

}

extension EnuiryChatViewControllerMH: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        let data = allStoryList[indexPath.row]
        cell.labelName.text = "\(data.ethicsCommitteId.firstName) \(data.ethicsCommitteId.middleName) \(data.ethicsCommitteId.lastName)"
        cell.labelTime.text = storyTimeArray[indexPath.row]
        cell.labelMessage.text = data.message
        let getProfileUrl = "\(self.baseUrl)\(data.ethicsCommitteId.profilePic)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
           cell.imageViewProfiel.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = allStoryList[indexPath.row]
        let senderDetails = selectedUser.mediahouseId
        let receiverDetails = selectedUser.ethicsCommitteId

        let tempDict: [String : AnyObject] = [
            "senderID": senderDetails.id as AnyObject,
            "senderImage": senderDetails.logo as AnyObject,
            "senderFirstName": senderDetails.firstName as AnyObject,
            "senderMiddleName": senderDetails.middleName as AnyObject,
            "senderLastName": senderDetails.lastName as AnyObject,
            "senderUserType": senderDetails.userType as AnyObject,
            "receiverID": receiverDetails.id as AnyObject,
            "receiverImage": receiverDetails.profilePic as AnyObject,
            "receiverFirstName": receiverDetails.firstName as AnyObject,
            "receiverMiddleName": receiverDetails.middleName as AnyObject,
            "receiverLastName": receiverDetails.lastName as AnyObject,
            "receiverUserType": receiverDetails.userType as AnyObject,
            "chatID": (receiverDetails.id + "_" + senderDetails.id) as AnyObject
        ]

        let chatUser = Users(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController = EnquiryChatLogController()
        let toUser = chatUser
        chatLogController.tokenID = currenUserLogin.mediahouseToken
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
}

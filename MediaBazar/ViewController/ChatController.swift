//
//  ChatController.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    
    @IBOutlet weak var chatListTableView: UITableView!
    @IBOutlet weak var topView: UIView!

    var allStoryList = GetJornalistReplyModel()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        apiCall()
    }
    
    fileprivate func setupUI() {
        topView.applyShadow()
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
    
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allStoryList.docs.enumerated() {
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
        WebService3.sharedInstance.chatList(header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.allStoryList = somecategory
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

extension ChatController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        let data = allStoryList.docs[indexPath.row]
        cell.labelName.text = "\(data.journalistId.firstName) \(data.journalistId.middleName) \(data.journalistId.lastName)"
        cell.labelTime.text = storyTimeArray[indexPath.row]
        cell.labelMessage.text = data.message
        let getProfileUrl = "\(self.baseUrl)\(data.journalistId.profilePic)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
           cell.imageViewProfiel.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = allStoryList.docs[indexPath.row]
        let journalistDetails = selectedUser.journalistId
        let mediahouseDetails = selectedUser.mediahouseId
        
        let tempDict: [String : AnyObject] = [
            "senderID": mediahouseDetails.id as AnyObject,
            "senderImage": mediahouseDetails.logo as AnyObject,
            "senderFirstName": mediahouseDetails.firstName as AnyObject,
            "senderMiddleName": mediahouseDetails.middleName as AnyObject,
            "senderLastName": mediahouseDetails.lastName as AnyObject,
            "senderUserType": mediahouseDetails.userType as AnyObject,
            "receiverID": journalistDetails.id as AnyObject,
            "receiverImage": journalistDetails.profilePic as AnyObject,
            "receiverFirstName": journalistDetails.firstName as AnyObject,
            "receiverMiddleName": journalistDetails.middleName as AnyObject,
            "receiverLastName": journalistDetails.lastName as AnyObject,
            "receiverUserType": journalistDetails.userType as AnyObject,
            "chatID": (mediahouseDetails.id + "_" + journalistDetails.id) as AnyObject
        ]
        
        let chatUser = Users(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController = ChatLogController()
        let toUser = chatUser
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    
}

//
//  EditorialChatController.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 02/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditorialChatController: UIViewController {
    
    @IBOutlet weak var chatListTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!

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
        setupButton()
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
    
    fileprivate func setupButton() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
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
//        self.currentUserLogin = User.loadSavedUser()
//        print("\(currentUserLogin.token)")
        getChatList(header: currenUserLogin.token)
    }
    
    //------getChatList-------
    func getChatList(header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.editorialChatList(header:header){(result,message,response) in
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

extension EditorialChatController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        let data = allStoryList.docs[indexPath.row]
        cell.labelName.text = "\(data.editorialBoardId.firstName) \(data.editorialBoardId.middleName) \(data.editorialBoardId.lastName)"
        cell.labelTime.text = storyTimeArray[indexPath.row]
        cell.labelMessage.text = data.message
        let getProfileUrl = "\(self.baseUrl)\(data.editorialBoardId.profilePic)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
           cell.imageViewProfiel.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = allStoryList.docs[indexPath.row]
        let senderDetails = selectedUser.journalistId
        let receiverDetails = selectedUser.editorialBoardId
        
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
        let chatLogController = EditorialChatLogController()
        let toUser = chatUser
        chatLogController.tokenID = currenUserLogin.token
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    
}


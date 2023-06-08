//
//  EnquiryChatViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryChatViewControllerJM: UIViewController {
    
    @IBOutlet weak var enquiryChatTableView : UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    
    var chatData = [storyListModal]()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setupUI()
        setupButton()
        
        self.currenUserLogin = User.loadSavedUser()
        getChatList(header: currenUserLogin.token)
        
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupTableView(){
        self.enquiryChatTableView.dataSource = self
        self.enquiryChatTableView.delegate = self
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in chatData.enumerated() {
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
    
    func getChatList(header: String){
        Webservices.sharedInstance.journalistEthicsChatList(header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    //                        self.chatData = somecategory
                    self.chatData.append(contentsOf: somecategory.docs)
                    self.enquiryChatTableView.reloadData()
                    self.calculateTime()
                    print("\(somecategory)")
                } else{
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}


extension EnquiryChatViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiryChatTableViewCellJM") as! EnquiryChatTableViewCellJM
        let data = chatData[indexPath.row]
        cell.nameLabel.text = ("\(data.ethicsCommitteId.firstName) \(data.ethicsCommitteId.middleName) \(data.ethicsCommitteId.lastName)")
        cell.messageLabel.text = data.message
        
        let getProfileUrl = "\(self.baseUrl)\(data.ethicsCommitteId.profilePic)"
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            cell.mediaImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        
        let time = storyTimeArray[indexPath.row]
        cell.timeLabel.text = time
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = chatData[indexPath.row]
        let senderDetails = selectedUser.journalistId
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
        chatLogController.tokenID = currenUserLogin.token
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}

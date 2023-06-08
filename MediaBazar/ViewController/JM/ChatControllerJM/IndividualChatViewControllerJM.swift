//
//  IndividualChatViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class IndividualChatViewControllerJM: UIViewController {
    
    @IBOutlet weak var individualChatTableView : UITableView!
    
    var chatData = newRequestModal()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        self.currenUserLogin = User.loadSavedUser()
        getChatList(header: currenUserLogin.token)
        
    }
    
    func setupTableView(){
        self.individualChatTableView.dataSource = self
        self.individualChatTableView.delegate = self
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in chatData.docs.enumerated() {
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
        Webservices.sharedInstance.chatListList(header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.chatData = somecategory
                    self.individualChatTableView.reloadData()
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


extension IndividualChatViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualChatTableViewCellJM") as! IndividualChatTableViewCellJM
        let data = chatData.docs[indexPath.row]
        cell.nameLabel.text = ("\(data.mediaHouseID.firstName) \(data.mediaHouseID.middleName) \(data.mediaHouseID.lastName)")
        cell.messageLabel.text = data.message
        
        let getProfileUrl = "\(self.baseUrl)\(data.mediaHouseID.logo)"
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            cell.mediaImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        
        let time = storyTimeArray[indexPath.row]
        cell.timeLabel.text = time
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = chatData.docs[indexPath.row]
        let journalistDetails = selectedUser.journalistId
        let mediahouseDetails = selectedUser.mediaHouseID
        
        let tempDict: [String : AnyObject] = [
            "senderID": journalistDetails.id as AnyObject,
            "senderImage": journalistDetails.profilePic as AnyObject,
            "senderFirstName": journalistDetails.firstName as AnyObject,
            "senderMiddleName": journalistDetails.middleName as AnyObject,
            "senderLastName": journalistDetails.lastName as AnyObject,
            "senderUserType": journalistDetails.userType as AnyObject,
            
            "receiverID": mediahouseDetails.id as AnyObject,
            "receiverImage": mediahouseDetails.logo as AnyObject,
            "receiverFirstName": mediahouseDetails.firstName as AnyObject,
            "receiverMiddleName": mediahouseDetails.middleName as AnyObject,
            "receiverLastName": mediahouseDetails.lastName as AnyObject,
            "receiverUserType": mediahouseDetails.userType as AnyObject,
            
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

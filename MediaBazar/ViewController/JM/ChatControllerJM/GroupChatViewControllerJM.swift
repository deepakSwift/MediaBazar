//
//  GroupChatViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class GroupChatViewControllerJM: UIViewController {
    
    @IBOutlet weak var groupChatTableView : UITableView!
    
    var newGroupData = newRequestModal()
    var curretUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        self.curretUserLogin = User.loadSavedUser()
        getGroupData(searchKey: "", header: curretUserLogin.token)
        
        
    }
    
    func setupTableView(){
        self.groupChatTableView.dataSource = self
        self.groupChatTableView.delegate = self
    }
    
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in newGroupData.docs.enumerated() {
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
    
    
    func getGroupData(searchKey: String, header: String){
        Webservices.sharedInstance.addedGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupData = somecategory
                    self.groupChatTableView.reloadData()
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
extension GroupChatViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newGroupData.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatTableViewCellJM") as! GroupChatTableViewCellJM
        
        let arrdata = newGroupData.docs[indexPath.row]
        let time = storyTimeArray[indexPath.row]
        cell.nameLabel.text = arrdata.collaborationGroupName
        cell.timeLabel.text = time
        cell.messageLabel.text = arrdata.message
        
        let getProfileUrl = "\(self.baseUrl)\(arrdata.collaborationGroupProfile)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            cell.groupImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGroup = newGroupData.docs[indexPath.row]
        let senderDetails = selectedGroup.userId
        let groupMembers = selectedGroup.members
        
        var membersList = [[String : AnyObject]]()
        
        for item in groupMembers {
            let member = item.journalistId
            let tempDict: [String : AnyObject] = [
                "receiverID": member.id,
                "receiverImage": member.profilePic,
                "receiverFirstName": member.firstName,
                "receiverMiddleName": member.middleName,
                "receiverLastName": member.lastName,
                "receiverUserType": member.userType
            ] as [String : AnyObject]
            membersList.append(tempDict)
        }
        
        let tempDict: [String : AnyObject] = [
            "senderID": senderDetails.id,
            "senderImage": senderDetails.profilePic,
            "senderFirstName": senderDetails.firstName,
            "senderMiddleName": senderDetails.middleName,
            "senderLastName": senderDetails.lastName,
            "senderUserType": senderDetails.userType,
            "members": membersList,
            "chatID": selectedGroup.id,
            "groupImage": selectedGroup.collaborationGroupProfile,
            "groupName": selectedGroup.collaborationGroupName
        ] as [String : AnyObject]
        
        let chatUser = Users_Group(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController_group = ChatLogController_Group()
        let toUser = chatUser
        chatLogController_group.user = toUser
        navigationController?.pushViewController(chatLogController_group, animated: true)
    }
}

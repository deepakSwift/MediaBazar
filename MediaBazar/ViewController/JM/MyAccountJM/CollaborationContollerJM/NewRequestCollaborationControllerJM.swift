//
//  NewRequestCollaborationControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NewRequestCollaborationControllerJM: UIViewController {
    
    @IBOutlet weak var newRequestTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    
    
    var newGroupData = newRequestModal()
    var newGroupSearchData = newRequestModal()
    var curretUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var isSearching : Bool = true
    var searchText = ""
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        searchingBar.delegate = self
        self.curretUserLogin = User.loadSavedUser()
        getGroupData(searchKey: "", header: curretUserLogin.token)
        
    }
    
    func setupTableView(){
        self.newRequestTableView.dataSource = self
        self.newRequestTableView.delegate = self
    }
    
    
    
    func calculateTime() {
        if isSearching{
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
        }else {
            var tempTimeArray = [String]()
                for data in newGroupSearchData.docs.enumerated() {
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
    
    }
    
    @objc func onClickAcceptButton(sender: UIButton){
        if isSearching{
            let id = newGroupData.docs[sender.tag].id
            print("id======\(id)")
            requestAcceptReject(groupID: id, status: "1", header: curretUserLogin.token)
        } else{
            let id = newGroupSearchData.docs[sender.tag].id
            print("id======\(id)")
            requestAcceptReject(groupID: id, status: "1", header: curretUserLogin.token)
        }

        
    }
    
    @objc func onClickRejectButton(sender: UIButton){
        if isSearching{
             let id = newGroupData.docs[sender.tag].id
             print("id======\(id)")
             requestAcceptReject(groupID: id, status: "0", header: curretUserLogin.token)
         } else{
             let id = newGroupSearchData.docs[sender.tag].id
             print("id======\(id)")
             requestAcceptReject(groupID: id, status: "0", header: curretUserLogin.token)
         }
    }
    
    func getGroupData(searchKey: String, header: String){
        Webservices.sharedInstance.getNewRequestGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupData = somecategory
                    self.newRequestTableView.reloadData()
                    self.calculateTime()
                    print("\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearchData(searchKey: String, header: String){
        Webservices.sharedInstance.getNewRequestGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupSearchData = somecategory
                    self.newRequestTableView.reloadData()
                    self.calculateTime()
                    print("\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func requestAcceptReject(groupID : String, status: String, header: String){
        Webservices.sharedInstance.requestAcceptRejectGroup(groupID: groupID, status: status, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                self.newRequestTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
       
    }
    
    
}

extension NewRequestCollaborationControllerJM : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return newGroupData.docs.count
        } else {
            return newGroupSearchData.docs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewRequestCollaborationTableViewCellJM") as! NewRequestCollaborationTableViewCellJM
        if isSearching{
            let arrdata = newGroupData.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.groupname.text = arrdata.collaborationGroupName
            cell.crealteLabel.text = ("Created by: \(arrdata.userId.firstName) \(arrdata.userId.lastName)")
            cell.time.text = time
            let getProfileUrl = "\(self.baseUrl)\(arrdata.userId.profilePic)"
            let url = NSURL(string: getProfileUrl)
            cell.profilePic.sd_setImage(with: url! as URL)
            //            cell.acceptButtob.addTarget(self, action: #selector(onClickAcceptButton), for: .touchUpInside)
            //            cell.rejectButton.addTarget(self, action: #selector(onClickRejectButton), for: .touchUpInside)
            
            cell.acceptButtob.tag = indexPath.row
            cell.acceptButtob.addTarget(self, action: #selector(onClickAcceptButton(sender:)), for: .touchUpInside)
            cell.rejectButton.tag = indexPath.row
            cell.rejectButton.addTarget(self, action: #selector(onClickRejectButton(sender:)), for: .touchUpInside)
        } else {
            let arrdata = newGroupData.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.groupname.text = arrdata.collaborationGroupName
            cell.crealteLabel.text = ("Created by: \(arrdata.userId.firstName) \(arrdata.userId.lastName)")
            cell.time.text = time
            let getProfileUrl = "\(self.baseUrl)\(arrdata.collaborationGroupProfile)"
            let url = NSURL(string: getProfileUrl)
            cell.profilePic.sd_setImage(with: url! as URL)
            
            cell.acceptButtob.tag = indexPath.row
            cell.acceptButtob.addTarget(self, action: #selector(onClickAcceptButton(sender:)), for: .touchUpInside)
            cell.rejectButton.tag = indexPath.row
            cell.rejectButton.addTarget(self, action: #selector(onClickRejectButton(sender:)), for: .touchUpInside)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVC = AppStoryboard.Journalist.viewController(ColloborationGroupDetailControllerJM.self)
        if isSearching{
            detailVC.groupDetail = newGroupData.docs[indexPath.row]
            detailVC.time = storyTimeArray[indexPath.row]
        } else {
            detailVC.groupDetail = newGroupSearchData.docs[indexPath.row]
            detailVC.time = storyTimeArray[indexPath.row]
        }
        
            self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}


extension NewRequestCollaborationControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            getSearchData(searchKey: searchBar.text!, header: curretUserLogin.token)
        } else {
            isSearching = true
            getGroupData(searchKey: "", header: curretUserLogin.token)
            
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            getSearchData(searchKey: searchBar.text!, header: curretUserLogin.token)
        } else {
            isSearching = true
            getGroupData(searchKey: "", header: curretUserLogin.token)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == searchingBar {
            isSearching = true
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchingBar {
            isSearching = false
            searchBar.resignFirstResponder()
        }
    }
    
}


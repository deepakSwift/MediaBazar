//
//  AddedCollaborationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AddedCollaborationViewControllerJM: UIViewController {
    
    @IBOutlet weak var addedCollaborationTableView : UITableView!
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


        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.addedCollaborationTableView.dataSource = self
        self.addedCollaborationTableView.delegate = self
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
    
    
    func getGroupData(searchKey: String, header: String){
        Webservices.sharedInstance.addedGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupData = somecategory
                    self.addedCollaborationTableView.reloadData()
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
        Webservices.sharedInstance.addedGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupSearchData = somecategory
                    self.addedCollaborationTableView.reloadData()
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

extension AddedCollaborationViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return newGroupData.docs.count
        } else {
            return newGroupSearchData.docs.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCollaborationTableViewCellJM") as! AddedCollaborationTableViewCellJM
        if isSearching{
            let arrdata = newGroupData.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.groupname.text = arrdata.collaborationGroupName
            cell.crealteLabel.text = ("Created by: \(arrdata.userId.firstName) \(arrdata.userId.lastName)")
            cell.time.text = time
            let getProfileUrl = "\(self.baseUrl)\(arrdata.collaborationGroupProfile)"
            let url = NSURL(string: getProfileUrl)
            cell.profilePic.sd_setImage(with: url! as URL)
        } else {
            let arrdata = newGroupData.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.groupname.text = arrdata.collaborationGroupName
            cell.crealteLabel.text = ("Created by: \(arrdata.userId.firstName) \(arrdata.userId.lastName)")
            cell.time.text = time
            let getProfileUrl = "\(self.baseUrl)\(arrdata.collaborationGroupProfile)"
            let url = NSURL(string: getProfileUrl)
            cell.profilePic.sd_setImage(with: url! as URL)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVC = AppStoryboard.Journalist.viewController(ColloborationGroupDetailControllerJM.self)
        if isSearching{
            detailVC.groupDetail = newGroupData.docs[indexPath.row]
            detailVC.hideButtonView = "hideView"
            detailVC.time = storyTimeArray[indexPath.row]
        } else {
            detailVC.groupDetail = newGroupSearchData.docs[indexPath.row]
            detailVC.hideButtonView = "hideView"
            detailVC.time = storyTimeArray[indexPath.row]
        }
        
            self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}

extension AddedCollaborationViewControllerJM: UISearchBarDelegate {
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



//
//  MyAssignmentsViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyAssignmentsViewControllerJM: UIViewController {
    
    @IBOutlet weak var myAssignmentTableView : UITableView!
    @IBOutlet weak var createAssignmentButton : UIButton!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    var myAssignmentData = listStory()
    var searchAssignmentData = listStory()
    var isSearching : Bool = true
    var currentUserLogin : User!
    var storyTimeArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
        setupTableView()
        setupUI()
        setupButton()
        getAssignmentData(page: "0", header: currentUserLogin.token)
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.myAssignmentTableView.dataSource = self
        self.myAssignmentTableView.delegate = self
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(createAssignmentButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func setupButton(){
        createAssignmentButton.addTarget(self, action: #selector(onClickCreateButton), for: .touchUpInside)
    }
    
    func calculateTime() {
        if isSearching{
            var tempTimeArray = [String]()
            for data in myAssignmentData.docs.enumerated() {
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
            for data in searchAssignmentData.docs.enumerated() {
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
    
    
    @objc func onClickCreateButton(){
        
        let createAssignmentVC = AppStoryboard.Journalist.viewController(CreateAssignmentViewControllerJM.self)
        self.navigationController?.pushViewController(createAssignmentVC, animated: true)
        //        let createScheduleVC = AppStoryboard.Journalist.viewController(CreateScheduleViewControllerJM.self)
        //        self.navigationController?.pushViewController(createScheduleVC, animated: true)
    }
    
    @objc func onClickRemoveButton(_ sender: UIButton){
        let id = myAssignmentData.docs[sender.tag].assignmentID
        print("\(id)")
        
        
//        guard let cell = myAssignmentTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MyAssignmentTableViewCellJM else { print("cell not found"); return }
//
//        if let indexpath = myAssignmentTableView.indexPath(for: cell){
//            self.myAssignmentData.docs.remove(at: indexpath.row)
////            self.removeAssignment(assignmentID: id, header: currentUserLogin.token)
//        }
        self.myAssignmentTableView.reloadData()
        
        self.removeAssignment(assignmentID: id, header: self.currentUserLogin.token)
        
    }
    
    
    func getAssignmentData(page : String,header: String){
        Webservices.sharedInstance.getMyAssignmentList(page: page, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList.removeAll()
                    self.myAssignmentData = somecategory
                    //                    print("myAssignmentTableView===========\(self.myAssignmentTableView)")
                    //                    self.mySaveStoryList.append(contentsOf: somecategory)
                    self.calculateTime()
                    self.myAssignmentTableView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearctAssignment(page : String,searchKey : String, header : String){
        Webservices.sharedInstance.getSearchAssignmentList(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList.removeAll()
                    self.searchAssignmentData = somecategory
                    //                    print("myAssignmentTableView===========\(self.myAssignmentTableView)")
                    //                    self.mySaveStoryList.append(contentsOf: somecategory)
                    self.calculateTime()
                    self.myAssignmentTableView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func removeAssignment(assignmentID: String, header: String){
        Webservices.sharedInstance.removeAssignmentList(assignmentID: assignmentID, header: header){(result,message,response) in
            print(result)
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension MyAssignmentsViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return myAssignmentData.docs.count
        } else{
            return searchAssignmentData.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAssignmentTableViewCellJM") as! MyAssignmentTableViewCellJM
        if isSearching{
            cell.countLabel.text = "\(indexPath.row + 1)."
            let arrData = myAssignmentData.docs[indexPath.row]
            cell.headLineLabel.text = arrData.assignmentHeadline
            cell.brifDescri.text = arrData.assignmentDesc
            let time = storyTimeArray[indexPath.row]
            cell.dateLabel.text = ("\(time) , \(arrData.date.prefix(10)) | \(arrData.country.name)")
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(onClickRemoveButton), for: .touchUpInside)
            return cell
            
        } else {
            cell.countLabel.text = "\(indexPath.row + 1)."
            let arrData = searchAssignmentData.docs[indexPath.row]
            cell.headLineLabel.text = arrData.assignmentHeadline
            cell.brifDescri.text = arrData.assignmentDesc
            let time = storyTimeArray[indexPath.row]
            cell.dateLabel.text = ("\(time) , \(arrData.date.prefix(10)) | \(arrData.country.name)")
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(onClickRemoveButton), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}




extension MyAssignmentsViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            getSearctAssignment(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getAssignmentData(page: "0", header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            getSearctAssignment(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getAssignmentData(page: "0", header: currentUserLogin.token)
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

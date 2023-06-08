//
//  AssignmentListViewControllerJournalist.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AssignmentListViewControllerJournalist: UIViewController {
    
    @IBOutlet weak var myAssignmentTableView : UITableView!
    @IBOutlet weak var createAssignmentButton : UIButton!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var backbutton : UIButton!
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var typeOfData = ""
    var searchText = ""
    var myAssignmentData = [storyListModal]()
    var searchAssignmentData = [storyListModal]()
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
        backbutton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    func calculateTime() {
        if isSearching{
            var tempTimeArray = [String]()
            for data in myAssignmentData.enumerated() {
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
            for data in searchAssignmentData.enumerated() {
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
    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickCreateButton(){
        
        let createAssignmentVC = AppStoryboard.Journalist.viewController(CreateAssignmentViewControllerJM.self)
        self.navigationController?.pushViewController(createAssignmentVC, animated: true)
        //        let createScheduleVC = AppStoryboard.Journalist.viewController(CreateScheduleViewControllerJM.self)
        //        self.navigationController?.pushViewController(createScheduleVC, animated: true)
    }
    
    @objc func onClickRemoveButton(_ sender: UIButton){
        let id = myAssignmentData[sender.tag].assignmentID
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
//                    self.myAssignmentData = somecategory
//                    self.calculateTime()
//                    self.myAssignmentTableView.reloadData()
                        self.typeOfData = "all"
                        self.scrollPage = true
                        self.myAssignmentData.append(contentsOf: somecategory.docs)
                        self.myAssignmentTableView.reloadData()
                        self.calculateTime()
                        self.page = somecategory.page
                        self.totalPages = somecategory.pages
                        if self.page == self.totalPages{
                            self.scrollPage = false
                        }else {
                            self.scrollPage = true
                        }
                        print("page=====\(self.page)")
                        print("\(somecategory)")

                    }
                    if self.myAssignmentData.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myAssignmentTableView.bounds.size.width, height: self.myAssignmentTableView.bounds.size.height))
                        noDataLabel.text = "No Assignment available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.myAssignmentTableView.backgroundView = noDataLabel
                        self.myAssignmentTableView.backgroundColor = UIColor.white
                        self.myAssignmentTableView.separatorStyle = .none
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
//                    self.searchAssignmentData = somecategory
                                        self.myAssignmentTableView.reloadData()
                        self.typeOfData = "search"
                        self.scrollPage = true
                        self.searchAssignmentData.append(contentsOf: somecategory.docs)
                        self.myAssignmentTableView.reloadData()
                        self.calculateTime()
                        self.page = somecategory.page
                        self.totalPages = somecategory.pages
                        if self.page == self.totalPages{
                            self.scrollPage = false
                        }else {
                            self.scrollPage = true
                        }
                        print("page=====\(self.page)")
                        print("\(somecategory)")

                    }
                    if self.searchAssignmentData.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myAssignmentTableView.bounds.size.width, height: self.myAssignmentTableView.bounds.size.height))
                        noDataLabel.text = "No Assignment  available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.myAssignmentTableView.backgroundView = noDataLabel
                        self.myAssignmentTableView.backgroundColor = UIColor.white
                        self.myAssignmentTableView.separatorStyle = .none
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

extension AssignmentListViewControllerJournalist : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return myAssignmentData.count
        } else{
            return searchAssignmentData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAssignmentTableViewCellJM") as! MyAssignmentTableViewCellJM
        if isSearching{
            cell.countLabel.text = "\(indexPath.row + 1)."
            let arrData = myAssignmentData[indexPath.row]
            cell.headLineLabel.text = arrData.assignmentHeadline
            cell.brifDescri.text = arrData.assignmentDesc
            let time = storyTimeArray[indexPath.row]
            cell.dateLabel.text = ("\(time) , \(arrData.date.prefix(10)) | \(arrData.country.name)")
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(onClickRemoveButton), for: .touchUpInside)
            return cell
            
        } else {
            cell.countLabel.text = "\(indexPath.row + 1)."
            let arrData = searchAssignmentData[indexPath.row]
            cell.headLineLabel.text = arrData.assignmentHeadline
            cell.brifDescri.text = arrData.assignmentDesc
            let time = storyTimeArray[indexPath.row]
            cell.dateLabel.text = ("\(time) , \(arrData.date.prefix(10)) | \(arrData.country.name)")
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(onClickRemoveButton), for: .touchUpInside)
            
            return cell
            
        }
    }
 

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let liveVC = AppStoryboard.Journalist.viewController(LiveViewControllerJM.self)
        if isSearching{
            liveVC.assignmentId = myAssignmentData[indexPath.row].assignmentID
        }else {
            liveVC.assignmentId = searchAssignmentData[indexPath.row].assignmentID
        }
        self.navigationController?.pushViewController(liveVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
            totalPaginationPage = myAssignmentData.count
        }else if typeOfData == "search"{
            totalPaginationPage = searchAssignmentData.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            if self.typeOfData == "all"{
                getAssignmentData(page: "\(page)", header: currentUserLogin.token)
            }else if typeOfData == "search"{
            getSearctAssignment(page: "\(page)", searchKey: self.searchText, header: currentUserLogin.token)
    
            }else {
                return
            }
        }
    }
    
}




extension AssignmentListViewControllerJournalist: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchAssignmentData.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearctAssignment(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.myAssignmentData.removeAll()
            self.page = 0
            self.totalPages = 0

            getAssignmentData(page: "0", header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchAssignmentData.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearctAssignment(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.myAssignmentData.removeAll()
            self.page = 0
            self.totalPages = 0
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

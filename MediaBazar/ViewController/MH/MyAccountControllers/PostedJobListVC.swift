//
//  PostedJobListVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PostedJobListVC: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewPostList: UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var buttonFilter: UIButton!
    
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    var isSearching : Bool = true
    var searchText = ""
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var typeOfData = ""
    
    var allStoryList = [GetJobDetailsModel]()
    var SearchAllJobList = [GetJobDetailsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
        setupUI()
        setupButton()
        setupTableView()
        apiCall()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupUI() {
       tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButonPressed), for: .touchUpInside)
    }
    
    func setupTableView(){
        //registered XIB
        tableViewPostList.register(UINib(nibName: "PostedJobTableCell", bundle: Bundle.main), forCellReuseIdentifier: "PostedJobTableCell")
    }
    
    func calculateTime() {
        if isSearching {
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
        } else {
            
            var tempTimeArray = [String]()
            for data in SearchAllJobList.enumerated() {
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
    
    func apiCall() {
        self.getJobList(page: "0", header: currenUserLogin.mediahouseToken)
    }
    

    @objc func backButonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
  
    //-------getJobList -------
    func getJobList(page : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.getJobListing(page: page, header: header) { (result, message, response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.allStoryList = somecategory
//                    self.allStoryList = somecategory.docs
                    
                    self.typeOfData = "all"
                    self.scrollPage = true
                    self.allStoryList.append(contentsOf: somecategory.docs)
                    self.tableViewPostList.reloadData()
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
                if self.allStoryList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewPostList.bounds.size.width, height: self.tableViewPostList.bounds.size.height))
                    noDataLabel.text = "No posted jobs available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewPostList.backgroundView = noDataLabel
                    self.tableViewPostList.backgroundColor = UIColor.white
                    self.tableViewPostList.separatorStyle = .none
                }
            }else{
                self.tableViewPostList.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------SearchJob -------
    func getSearchData(page : String,searchKey: String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.searchJob(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
           CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.SearchAllJobList = somecategory
//                    self.SearchAllJobList = somecategory.docs
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.SearchAllJobList.append(contentsOf: somecategory.docs)
                    self.tableViewPostList.reloadData()
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
                if self.SearchAllJobList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewPostList.bounds.size.width, height: self.tableViewPostList.bounds.size.height))
                    noDataLabel.text = "No posted jobs available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewPostList.backgroundView = noDataLabel
                    self.tableViewPostList.backgroundColor = UIColor.white
                    self.tableViewPostList.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

}

// ---TableView-----
extension PostedJobListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return allStoryList.count
        }else{
            return SearchAllJobList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostedJobTableCell", for: indexPath) as! PostedJobTableCell
        if isSearching {
            let data = allStoryList[indexPath.row]
            cell.labelTitle.text = data.jobKeywordName[0]
            cell.labelSubtitle.text = data.mediahouseId.organizationName
            cell.labelLocation.text = data.city.name
            cell.labelYear.text = data.workExperience
            cell.labelDisclosed.text = data.expectedSalary
            cell.labelDaysCount.text = storyTimeArray[indexPath.row]
            cell.buttonViewDetails.makeRoundCorner(10)
            cell.buttonViewDetails.makeBorder(1, color: .black)
            cell.buttonViewDetails.tag = indexPath.row
            cell.buttonViewDetails.addTarget(self, action: #selector(buttonViewDetail(sender:)), for: .touchUpInside)
        } else {
            let data = SearchAllJobList[indexPath.row]
            cell.labelTitle.text = data.jobKeywordName[0]
            cell.labelSubtitle.text = data.mediahouseId.organizationName
            cell.labelLocation.text = data.city.name
            cell.labelYear.text = data.workExperience
            cell.labelDisclosed.text = data.expectedSalary
            cell.labelDaysCount.text = storyTimeArray[indexPath.row]
            cell.buttonViewDetails.makeRoundCorner(10)
            cell.buttonViewDetails.makeBorder(1, color: .black)
            cell.buttonViewDetails.tag = indexPath.row
            cell.buttonViewDetails.addTarget(self, action: #selector(buttonViewDetail(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func buttonViewDetail(sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postedJobDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PostedJobDetailVC") as! PostedJobDetailVC
        if isSearching {
            postedJobDetailsVC.data = allStoryList[indexPath.row]
            postedJobDetailsVC.daysCount = storyTimeArray[indexPath.row]
        } else {
            postedJobDetailsVC.data = SearchAllJobList[indexPath.row]
            postedJobDetailsVC.daysCount = storyTimeArray[indexPath.row]
        }
        self.navigationController?.pushViewController(postedJobDetailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
            totalPaginationPage = allStoryList.count
        }else if typeOfData == "search"{
            totalPaginationPage = SearchAllJobList.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            if self.typeOfData == "all"{
                getJobList(page: "\(page)", header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "search"{
                getSearchData(page: "\(page)", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)
            }else {
                return
            }
        }
    }

    
}

extension PostedJobListVC: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.SearchAllJobList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getJobList(page: "0", header: currenUserLogin.mediahouseToken)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
             self.searchText = searchBar.text!
            self.SearchAllJobList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getJobList(page: "0", header: currenUserLogin.mediahouseToken)
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

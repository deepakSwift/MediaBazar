//
//  NewEventViewControllerMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NewEventViewControllerMH: UIViewController {
    
    @IBOutlet weak var newEventtableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    
    
//    var newEventList = EventListModel()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var searchText = ""
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var isSearching : Bool = true
    
    var newEventList = [EventListDetailsModel]()
    var searchEventList = [EventListDetailsModel]()
    var typeOfData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        apiCall()
        searchingBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView() {
        self.newEventtableView.dataSource = self
        self.newEventtableView.delegate = self
        self.newEventtableView.bounces = false
        self.newEventtableView.alwaysBounceVertical = false
        self.newEventtableView.rowHeight = UITableView.automaticDimension
        self.newEventtableView.estimatedRowHeight = 1000
        
    }
    
    func apiCall() {
        getEventList(page: "0", SearchKey: "", header: currenUserLogin.mediahouseToken)
    }
    
    func getEventList(page: String,SearchKey : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.newEventlist(page: page, searchKey: SearchKey, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.typeOfData = "all"
                    self.scrollPage = true
                    self.newEventList.append(contentsOf: somecategory.docs)
                    self.newEventtableView.reloadData()
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
                if self.newEventList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.newEventtableView.bounds.size.width, height: self.newEventtableView.bounds.size.height))
                    noDataLabel.text = "No event available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.newEventtableView.backgroundView = noDataLabel
                    self.newEventtableView.backgroundColor = UIColor.white
                    self.newEventtableView.separatorStyle = .none
                }
            }
                //
                //            {
                //                if let somecategory = response{
                //                    self.newEventList = somecategory
                //                    self.newEventtableView.reloadData()
                //                } else{
                //
                //                }
                //            }
            else{
                self.newEventtableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func gerSearchEvelList(page : String, searchKey : String, header : String){
        WebService3.sharedInstance.newEventlist(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchEventList.append(contentsOf: somecategory.docs)
                    self.newEventtableView.reloadData()
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
                if self.searchEventList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.newEventtableView.bounds.size.width, height: self.newEventtableView.bounds.size.height))
                    noDataLabel.text = "No event available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.newEventtableView.backgroundView = noDataLabel
                    self.newEventtableView.backgroundColor = UIColor.white
                    self.newEventtableView.separatorStyle = .none
                }
            }
                //
                //            {
                //                if let somecategory = response{
                //                    self.newEventList = somecategory
                //                    self.newEventtableView.reloadData()
                //                } else{
                //
                //                }
                //            }
            else{
                self.newEventtableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension NewEventViewControllerMH: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newEventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveEventListTableViewCellMH", for: indexPath) as! LiveEventListTableViewCellMH
        if isSearching {
            let arrdata = newEventList[indexPath.row]
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.profileImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            cell.nameLabel.text = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.pricelabel.text = "\(arrdata.currency) \(arrdata.price)"
            cell.headinglabel.text = arrdata.journalistHeadline
            cell.timeDateLabel.text = "\(arrdata.time),\(arrdata.date) | \(arrdata.country.name)"
            cell.descriptionLabel.text = arrdata.journalistDescription
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
        }else {
            let arrdata = searchEventList[indexPath.row]
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.profileImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            cell.nameLabel.text = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.pricelabel.text = "\(arrdata.currency) \(arrdata.price)"
            cell.headinglabel.text = arrdata.journalistHeadline
            cell.timeDateLabel.text = "\(arrdata.time),\(arrdata.date) | \(arrdata.country.name)"
            cell.descriptionLabel.text = arrdata.journalistDescription
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AppStoryboard.MediaHouse.viewController(NewEventDetailViewControllerVC.self)
        if isSearching{
            let arrdata = newEventList[indexPath.row]
            detailVC.headline = arrdata.journalistHeadline
            detailVC.time = arrdata.time
            detailVC.date = arrdata.date
            detailVC.country = arrdata.country.name
            detailVC.currency = arrdata.currency
            detailVC.price = String(arrdata.price)
            detailVC.name = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            detailVC.profileImage = arrdata.journalistId.profilePic
            detailVC.assignmentID = arrdata.ids
            detailVC.descri = arrdata.journalistDescription
        }else {
            let arrdata = searchEventList[indexPath.row]
            detailVC.headline = arrdata.journalistHeadline
            detailVC.time = arrdata.time
            detailVC.date = arrdata.date
            detailVC.country = arrdata.country.name
            detailVC.currency = arrdata.currency
            detailVC.price = String(arrdata.price)
            detailVC.name = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            detailVC.profileImage = arrdata.journalistId.profilePic
            detailVC.assignmentID = arrdata.ids
            detailVC.descri = arrdata.journalistDescription
        }

        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
            totalPaginationPage = newEventList.count
        }else if typeOfData == "search"{
            totalPaginationPage = searchEventList.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            if self.typeOfData == "all"{
                getEventList(page: "\(page)", SearchKey: "", header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "search"{
                gerSearchEvelList(page: "\(page)", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)
            }else {
                return
            }
        }
    }

    
}



extension NewEventViewControllerMH: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchEventList.removeAll()
            self.page = 0
            self.totalPages = 0
            gerSearchEvelList(page: "0", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)

        } else {
            isSearching = true
            self.newEventList.removeAll()
            self.page = 0
            self.totalPages = 0
            getEventList(page: "0", SearchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchEventList.removeAll()
            self.page = 0
            self.totalPages = 0
            gerSearchEvelList(page: "0", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)

        } else {
            isSearching = true
            self.newEventList.removeAll()
            self.page = 0
            self.totalPages = 0
            getEventList(page: "0", SearchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
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

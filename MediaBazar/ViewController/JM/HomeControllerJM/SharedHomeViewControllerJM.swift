//
//  SharedHomeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SharedHomeViewControllerJM: UIViewController {
    @IBOutlet weak var sharedHomeTableView: UITableView!
    @IBOutlet weak var searchingBar: UISearchBar!
    @IBOutlet weak var filterButton : UIButton!
    
    //    var sharedStoryList = [storyListModal]()
    //    var sharedStoryList = listStory()
    //    var searchSharedStoryList = listStory()
    var isSearching : Bool = true
    var storyTimeArray = [String]()
    var favStoryData = AddTofavoriteModel()
    var searchText = ""
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currentUserLogin : User!
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    var storyList = [storyListModal]()
    var searchStoryList = [storyListModal]()
    var getFilterID = ""
    var typeOfData = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setUpButton()
        searchingBar.delegate = self
        searchingBar.barTintColor = UIColor.clear
        //        searchingBar.searchTextField.textColor = .black
        //        searchingBar.searchTextField.backgroundColor = UIColor.white
        searchingBar.isTranslucent = true
        
        self.currentUserLogin = User.loadSavedUser()
        getSharedStoryData(page: "0", key: "Shared", header: currentUserLogin.token)
    }
    
    fileprivate func setupTableView() {
        sharedHomeTableView.dataSource = self
        sharedHomeTableView.delegate = self
        sharedHomeTableView.bounces = false
        sharedHomeTableView.alwaysBounceVertical = false
        sharedHomeTableView.rowHeight = UITableView.automaticDimension
        sharedHomeTableView.estimatedRowHeight = 1000
        sharedHomeTableView.reloadData()
    }
    
    func setUpButton(){
        filterButton.addTarget(self, action: #selector(clickOnFIlterButton), for: .touchUpInside)
    }
    
    
    func calculateTime() {
        if isSearching{
            var tempTimeArray = [String]()
            for data in storyList.enumerated() {
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
            for data in searchStoryList.enumerated() {
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
    
    @objc func clickOnFIlterButton(){
        let filterVC = AppStoryboard.MediaHouse.viewController(SearchFilterVC.self)
        filterVC.delegate = self
        self.storyList.removeAll()
        self.page = 0
        self.totalPages = 0
        self.present(filterVC, animated: true, completion: nil)
        
    }
    
    
    @objc func buttonAddToFav(sender: UIButton){
        if isSearching {
            let id = storyList[sender.tag].id
            print("idSearch=========\(id)")
            self.AddFavoriteStory(storyId: id, header: currentUserLogin.token)
        } else {
            let id = searchStoryList[sender.tag].id
            print("idSearch=========\(id)")
            //self.getSearchData(key: "All", searchKey: self.searchText, header: self.header)
            self.AddFavoriteStory(storyId: id, header: currentUserLogin.token)
            
        }
        
    }
    
    func getSharedStoryData(page : String,key : String, header: String){
        Webservices.sharedInstance.getStoryList(page: page, key: key, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.sharedStoryList = somecategory
                    //                    self.sharedHomeTableView.reloadData()
                    //                    self.calculateTime()
                    //                    //                    self.setupData()
                    //                }
                    self.typeOfData = "shared"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.sharedHomeTableView.reloadData()
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
                
                if self.storyList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.sharedHomeTableView.bounds.size.width, height: self.sharedHomeTableView.bounds.size.height))
                    noDataLabel.text = "No shared story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.sharedHomeTableView.backgroundView = noDataLabel
                    self.sharedHomeTableView.backgroundColor = UIColor.white
                    self.sharedHomeTableView.separatorStyle = .none
                }
                
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSharedFilterStoryData(page : String,key:String, header: String, categoryID : String){
        Webservices.sharedInstance.getFilterStory(page: page, key: key, storyHeader: header, categoryID: categoryID){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.sharedStoryList = somecategory
                    //                    self.sharedHomeTableView.reloadData()
                    //                    self.calculateTime()
                    //                    //                    self.setupData()
                    //                    self.calculateTime()
                    //                }
                    
                    self.typeOfData = "filter"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.sharedHomeTableView.reloadData()
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
                
                if self.storyList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.sharedHomeTableView.bounds.size.width, height: self.sharedHomeTableView.bounds.size.height))
                    noDataLabel.text = "No shared story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.sharedHomeTableView.backgroundView = noDataLabel
                    self.sharedHomeTableView.backgroundColor = UIColor.white
                    self.sharedHomeTableView.separatorStyle = .none
                }
                
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearchData(page: String,key: String, searchKey: String, header: String){
        Webservices.sharedInstance.getSearchAllStoryList(page: page, key: key, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.searchSharedStoryList = somecategory
                    //                    self.sharedHomeTableView.reloadData()
                    //                    self.calculateTime()
                    //                    //                    self.setupData()
                    //                }
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchStoryList.append(contentsOf: somecategory.docs)
                    self.sharedHomeTableView.reloadData()
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
                
                if self.searchStoryList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.sharedHomeTableView.bounds.size.width, height: self.sharedHomeTableView.bounds.size.height))
                    noDataLabel.text = "No shared story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.sharedHomeTableView.backgroundView = noDataLabel
                    self.sharedHomeTableView.backgroundColor = UIColor.white
                    self.sharedHomeTableView.separatorStyle = .none
                }
                
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func AddFavoriteStory(storyId: String, header: String) {
        //CommonClass.showLoader()
        Webservices.sharedInstance.AddFavoriteStroy(storyId: storyId, storyHeader: header)
        { (result, message, response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.favStoryData = somecategory
                    self.sharedHomeTableView.reloadData()
                }
                if self.isSearching == true {
                    self.getSharedStoryData(page: "0", key: "Shared", header: self.currentUserLogin.token)
                    
                }else {
                    self.getSearchData(page: "0", key: "Shared", searchKey: self.searchText, header: self.currentUserLogin.token)
                    
                }
            }else{
                if self.isSearching == true {
                    self.getSharedStoryData(page: "0", key: "Shared", header: self.currentUserLogin.token)
                    
                }else {
                    self.getSearchData(page: "0", key: "Shared", searchKey: self.searchText, header: self.currentUserLogin.token)                }
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

extension SharedHomeViewControllerJM: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            //            return sharedStoryList.docs.count
            return storyList.count
        } else{
            //            return searchSharedStoryList.docs.count
            return searchStoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedTableViewCellJM") as! SharedTableViewCellJM
        if isSearching{
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.timeLabel.text = time
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authorName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")

            cell.userType.text = arrdata.journalistId.userType
            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryName.text = arrdata.categoryId.categoryName
            cell.languageName.text = arrdata.langCode
            cell.countryName.text = arrdata.state.stateName
            cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            cell.descri.text = arrdata.headLine
            cell.soldOutLabel.text = ("\(String(arrdata.soldOut)) times")
            cell.purchaseLabel.text = arrdata.purchasingLimit
            cell.averageRatting.text = (" \(String(arrdata.totalAveargeReview)) ")
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL)
                }
                //              let url = NSURL(string: profilePic)
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keywordName = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
            
        } else{
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.timeLabel.text = time
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authorName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")

            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryName.text = arrdata.categoryId.categoryName
            cell.languageName.text = arrdata.langCode
            cell.countryName.text = arrdata.state.stateName
            cell.averageRatting.text = (" \(String(arrdata.totalAveargeReview)) ")
            cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            cell.descri.text = arrdata.headLine
            cell.soldOutLabel.text = ("\(String(arrdata.soldOut)) times")
            cell.purchaseLabel.text = arrdata.purchasingLimit
            
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL)
                }
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keywordName = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AppStoryboard.Journalist.viewController(HomePageStoriesDetsilViewControllerJM.self)
        
        if isSearching {
            //detailVC.StoryDetails = allStoryList
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)"
            detailVC.categoryType = arrdata.categoryId.categoryName
            detailVC.time = ("\(arrdata.langCode) | \(time) | \(arrdata.city.name)")
            detailVC.price = ("\(arrdata.currency) \(arrdata.price)")
            detailVC.auctionBiddingPrice = ("\(arrdata.currency) \(arrdata.auctionBiddingPrice)")
            detailVC.file = ("\(arrdata.fileCount) Files")
            detailVC.keywords = arrdata.keywordName
            detailVC.descriptions = arrdata.briefDescription
            detailVC.storyCategory = arrdata.storyCategory
            detailVC.reviewCount = arrdata.reviewCount
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                detailVC.imageThumbnail = thumbnailUrl
            }
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            detailVC.imageurl = getProfileUrl
            detailVC.StoryDetails = storyList
            detailVC.storyId = arrdata.id
            detailVC.getTextArray = arrdata.uploadTexts
            detailVC.keywords = arrdata.keywordName
            detailVC.headline = arrdata.headLine
            detailVC.favouriteStatus = arrdata.favouriteStatus
            print("id==================\(arrdata.id)")
            print("id==================\(arrdata.storyCategory)")
            detailVC.hideEditButton = "hide"
            detailVC.hideDeleteButton = "hide"
            detailVC.journalistID = arrdata.journalistId.id

        } else {
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)"
            detailVC.categoryType = arrdata.categoryId.categoryName
            detailVC.time = ("\(arrdata.langCode) | \(time) | \(arrdata.city.name)")
            detailVC.price = ("\(arrdata.currency) \(arrdata.price)")
            detailVC.auctionBiddingPrice = ("\(arrdata.currency) \(arrdata.auctionBiddingPrice)")
            detailVC.file = ("\(arrdata.fileCount) Files")
            detailVC.keywords = arrdata.keywordName
            detailVC.descriptions = arrdata.briefDescription
            detailVC.reviewCount = arrdata.reviewCount
            //detailVC.categoryType = arrdata.storyCategory
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                detailVC.imageThumbnail = thumbnailUrl
            }
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            detailVC.imageurl = getProfileUrl
            detailVC.StoryDetails = searchStoryList
            detailVC.storyId = arrdata.id
            detailVC.getTextArray = arrdata.uploadTexts
            detailVC.keywords = arrdata.keywordName
            detailVC.headline = arrdata.headLine
            detailVC.favouriteStatus = arrdata.favouriteStatus
            print("id==================\(arrdata.id)")
            print("id==================\(arrdata.storyCategory)")
            detailVC.hideEditButton = "hide"
            detailVC.hideDeleteButton = "hide"
            detailVC.journalistID = arrdata.journalistId.id

        }
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "shared"{
            totalPaginationPage = storyList.count
        }else if typeOfData == "filter"{
            totalPaginationPage = storyList.count
        }else if typeOfData == "search"{
            totalPaginationPage = searchStoryList.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            
            if self.typeOfData == "shared"{
                getSharedStoryData(page: "\(page)", key: "Shared", header: currentUserLogin.token)
            }else if typeOfData == "filter"{
                getSharedFilterStoryData(page: "\(page)", key: "Shared", header: currentUserLogin.token, categoryID: getFilterID)
            }else if typeOfData == "search"{
                getSearchData(page: "\(page)", key: "Shared", searchKey: self.searchText, header: currentUserLogin.token)
            }else {
                return
            }
            
        }
        
    }
    
    
    
}


extension SharedHomeViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Shared", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSharedStoryData(page: "0", key: "Shared", header: currentUserLogin.token)
            
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Shared", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSharedStoryData(page: "0", key: "Shared", header: currentUserLogin.token)
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


extension SharedHomeViewControllerJM: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSharedStoryData(page: "0", key: "Shared", header: currentUserLogin.token)
        } else {
            self.getFilterID = id
            self.getSharedFilterStoryData(page: "0", key: "Shared", header: currentUserLogin.token, categoryID: id)
        }
    }
}

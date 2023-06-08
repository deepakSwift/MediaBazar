//
//  ExclusiveHomeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ExclusiveHomeViewControllerJM: UIViewController {
    
    @IBOutlet weak var exclusiveHomeTableView: UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var filterButton : UIButton!
    
    //    var exclusiveStoryList = [storyListModal]()
    //    var exclusiveStoryList = listStory()
    //    var searchExclusiveStoryList = listStory()
    var favStoryData = AddTofavoriteModel()
    var searchText = ""
    var isSearching : Bool = true
    
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    var storyList = [storyListModal]()
    var searchStoryList = [storyListModal]()
    var getFilterID = ""
    var typeOfData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupTableView()
        setUpButton()
        searchingBar.delegate = self
        searchingBar.barTintColor = UIColor.clear
        searchingBar.isTranslucent = true
        
        getAllStoryData(page: "0", key: "Exclusive", header: currenUserLogin.token)
    }
    
    fileprivate func setupTableView() {
        exclusiveHomeTableView.dataSource = self
        exclusiveHomeTableView.delegate = self
        exclusiveHomeTableView.bounces = false
        exclusiveHomeTableView.alwaysBounceVertical = false
        exclusiveHomeTableView.rowHeight = UITableView.automaticDimension
        exclusiveHomeTableView.estimatedRowHeight = 1000
        exclusiveHomeTableView.reloadData()
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
                
                print("tempData======\(tempData)")
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
                
                print("tempData======\(tempData)")
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
            self.AddFavoriteStory(storyId: id, header: currenUserLogin.token)
        } else {
            let id = searchStoryList[sender.tag].id
            print("idSearch=========\(id)")
            //self.getSearchData(key: "All", searchKey: self.searchText, header: self.header)
            self.AddFavoriteStory(storyId: id, header: currenUserLogin.token)
            
        }
        
    }
    
    
    
    //
    
    func getAllStoryData(page : String,key : String, header: String){
        Webservices.sharedInstance.getStoryList(page: page, key: key, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.exclusiveStoryList = somecategory
                    //                    self.exclusiveHomeTableView.reloadData()
                    //                    //                    self.setupData()
                    //                    self.calculateTime()
                    //
                    //                    self.page = self.exclusiveStoryList.page
                    self.typeOfData = "exclusive"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    //                    self.allStoryList = somecategory
                    self.exclusiveHomeTableView.reloadData()
                    //                    self.setupData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.exclusiveHomeTableView.bounds.size.width, height: self.exclusiveHomeTableView.bounds.size.height))
                    noDataLabel.text = "No exclusive story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.exclusiveHomeTableView.backgroundView = noDataLabel
                    self.exclusiveHomeTableView.backgroundColor = UIColor.white
                    self.exclusiveHomeTableView.separatorStyle = .none
                }
                
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getExclusiveFilterStoryData(page : String,key:String, header: String, categoryID : String){
        Webservices.sharedInstance.getFilterStory(page: page, key: key, storyHeader: header, categoryID: categoryID){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.exclusiveStoryList = somecategory
                    //                    self.exclusiveHomeTableView.reloadData()
                    //                    //                    self.setupData()
                    //                    self.calculateTime()
                    self.typeOfData = "filter"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.exclusiveHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.exclusiveHomeTableView.bounds.size.width, height: self.exclusiveHomeTableView.bounds.size.height))
                    noDataLabel.text = "No exclusive story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.exclusiveHomeTableView.backgroundView = noDataLabel
                    self.exclusiveHomeTableView.backgroundColor = UIColor.white
                    self.exclusiveHomeTableView.separatorStyle = .none
                }
                else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getSearchData(page : String,key: String, searchKey: String, header: String){
        Webservices.sharedInstance.getSearchAllStoryList(page: page, key: key, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.searchExclusiveStoryList = somecategory
                    //                    self.exclusiveHomeTableView.reloadData()
                    //                    //                    self.setupData()
                    //                    self.calculateTime()
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchStoryList.append(contentsOf: somecategory.docs)
                    self.exclusiveHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.exclusiveHomeTableView.bounds.size.width, height: self.exclusiveHomeTableView.bounds.size.height))
                    noDataLabel.text = "No exclusive story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.exclusiveHomeTableView.backgroundView = noDataLabel
                    self.exclusiveHomeTableView.backgroundColor = UIColor.white
                    self.exclusiveHomeTableView.separatorStyle = .none
                }
                else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Add to Wishlist -------
    func AddFavoriteStory(storyId: String, header: String) {
        //CommonClass.showLoader()
        Webservices.sharedInstance.AddFavoriteStroy(storyId: storyId, storyHeader: header)
        { (result, message, response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.favStoryData = somecategory
                    self.exclusiveHomeTableView.reloadData()
                }
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Exclusive", header: self.currenUserLogin.token)
                }else {
                    self.getSearchData(page: "0", key: "Exclusive", searchKey: self.searchText, header: self.currenUserLogin.token)
                    
                }
            }else{
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Exclusive", header: self.currenUserLogin.token)
                }else {
                    self.getSearchData(page: "0", key: "Exclusive", searchKey: self.searchText, header: self.currenUserLogin.token)
                }
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    
}

extension ExclusiveHomeViewControllerJM: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            //            return exclusiveStoryList.docs.count
            return storyList.count
        } else {
            //            return searchExclusiveStoryList.docs.count
            return searchStoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveTableViewCellJM") as! ExclusiveTableViewCellJM
        if isSearching{
            //            let arrdata = exclusiveStoryList.docs[indexPath.row]
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authowNAme.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.userType.text = arrdata.journalistId.userType
            cell.fileCount.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = arrdata.langCode
            cell.countryLabel.text = arrdata.country.name
            cell.descri.text = arrdata.headLine
            cell.priceLabel.text = ("\(arrdata.state.symbol)\(String(arrdata.price))")
            cell.timeLabel.text = time
            cell.soldOutLabel.text = ("\(String(arrdata.soldOut)) Times")
            
                    
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL, placeholderImage: #imageLiteral(resourceName: "Group 3009"))
                }
            }
            
            cell.averageRtting.text = " \(String(arrdata.totalAveargeReview)) "
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            
            cell.keywordsCollectionView.reloadData()
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbNailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
            
            
        } else{
            //            let arrdata = searchExclusiveStoryList.docs[indexPath.row]
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authowNAme.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.userType.text = arrdata.journalistId.userType
            cell.fileCount.text =  ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = arrdata.langCode
            cell.countryLabel.text = arrdata.country.name
            cell.descri.text = arrdata.headLine
            cell.priceLabel.text = ("\(arrdata.state.symbol)\(String(arrdata.price))")
            cell.timeLabel.text = time
            cell.soldOutLabel.text = ("\(String(arrdata.soldOut)) Times")
            
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL, placeholderImage: #imageLiteral(resourceName: "Group 3009"))
                }
            }
                        
            cell.averageRtting.text = " \(String(arrdata.totalAveargeReview)) "
            cell.keyword = arrdata.keywordName
            cell.keywordsCollectionView.reloadData()
            
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbNailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
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
        //        let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
        //        if isSearching{
        //            detailVC.detailData = exclusiveStoryList.docs[indexPath.row]
        //            detailVC.time = storyTimeArray[indexPath.row]
        //            detailVC.hideEditButton = "hide"
        //            detailVC.hideDeleteButton = "hide"
        //            detailVC.storyID = exclusiveStoryList.docs[indexPath.row].id
        //        } else{
        //            detailVC.detailData = searchExclusiveStoryList.docs[indexPath.row]
        //            detailVC.time = storyTimeArray[indexPath.row]
        //            detailVC.hideEditButton = "hide"
        //            detailVC.hideDeleteButton = "hide"
        //            detailVC.storyID = searchExclusiveStoryList.docs[indexPath.row].id
        //        }
        //        self.navigationController?.pushViewController(detailVC, animated: true)
        
        let detailVC = AppStoryboard.Journalist.viewController(HomePageStoriesDetsilViewControllerJM.self)
        
        if isSearching {
            //detailVC.StoryDetails = allStoryList
            //            let arrdata = exclusiveStoryList.docs[indexPath.row]
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)"
            detailVC.categoryType = arrdata.categoryId.categoryName
            detailVC.time = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
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
            //            let arrdata = searchExclusiveStoryList.docs[indexPath.row]
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)"
            detailVC.categoryType = arrdata.categoryId.categoryName
            detailVC.time = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
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
        if self.typeOfData == "exclusive"{
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
            
            
            if self.typeOfData == "exclusive"{
                getAllStoryData(page: "\(page)", key: "Exclusive", header: self.currenUserLogin.token)
            }else if typeOfData == "filter"{
                self.getExclusiveFilterStoryData(page: "\(page)", key: "Exclusive", header: currenUserLogin.token, categoryID: getFilterID)
            }else if typeOfData == "search"{
                getSearchData(page: "\(page)", key: "Exclusive", searchKey: self.searchText, header: currenUserLogin.token)
                
            }else {
                return
            }
            
        }
        
    }
    
    
}

extension ExclusiveHomeViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Exclusive", searchKey: searchBar.text!, header: currenUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Exclusive", header: currenUserLogin.token)
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
            getSearchData(page: "0", key: "Exclusive", searchKey: searchBar.text!, header: currenUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Exclusive", header: currenUserLogin.token)
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

extension ExclusiveHomeViewControllerJM: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Exclusive", header: currenUserLogin.token)
        } else {
            self.getFilterID = id
            self.getExclusiveFilterStoryData(page: "0", key: "Exclusive", header: currenUserLogin.token, categoryID: id)
            
        }
    }
}




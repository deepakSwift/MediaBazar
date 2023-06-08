//
//  AllHomeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import SDWebImage

class AllHomeViewControllerJM: UIViewController {
    
    @IBOutlet weak var allHomeTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var filterButton : UIButton!
    
    var allStoryList = listStory()
    var searchAllStoryList = listStory()
    var isSearching : Bool = true{
        didSet{
            storyList.removeAll()
            searchStoryList.removeAll()
        }
    }
    
    var favStoryData = AddTofavoriteModel()
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    var currenUserLogin : User!
    
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
        self.setUpButton()
        searchingBar.delegate = self
        self.currenUserLogin = User.loadSavedUser()
        searchingBar.barTintColor = UIColor.clear
        //        searchingBar.searchTextField.textColor = .black
        //        searchingBar.searchTextField.backgroundColor = UIColor.white
        searchingBar.isTranslucent = true
        getAllStoryData(page: "0", key: "All", header: currenUserLogin.token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currenUserLogin = User.loadSavedUser()
        //        getAllStoryData(page: "0", key: "All", header: currenUserLogin.token)
        
    }
    
    func setupTableView(){
        self.allHomeTableView.dataSource = self
        self.allHomeTableView.delegate = self
        self.allHomeTableView.bounces = false
        self.allHomeTableView.alwaysBounceVertical = false
        self.allHomeTableView.rowHeight = UITableView.automaticDimension
        self.allHomeTableView.estimatedRowHeight = 1000
        self.allHomeTableView.reloadData()
    }
    
    func setUpButton(){
        filterButton.addTarget(self, action: #selector(clickOnFIlterButton), for: .touchUpInside)
    }
    
    
    
    func calculateTime() {
        if isSearching{
            var tempTimeArray = [String]()
            //            for data in allStoryList.docs.enumerated() {
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
            self.AddFavoriteStory(storyId: id, header: currenUserLogin.token)
        } else {
            let id = searchStoryList[sender.tag].id
            print("idSearch=========\(id)")
            //self.getSearchData(key: "All", searchKey: self.searchText, header: self.header)
            self.AddFavoriteStory(storyId: id, header: currenUserLogin.token)
        }
    }
    
    
    
    
    
    func getAllStoryData(page : String,key : String, header : String){
        CommonClass.showLoader()
        Webservices.sharedInstance.getStoryList(page: page, key: key, storyHeader: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.typeOfData = "all"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    //                    self.allStoryList = somecategory
                    self.allHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.allHomeTableView.bounds.size.width, height: self.allHomeTableView.bounds.size.height))
                    noDataLabel.text = "No saved story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.allHomeTableView.backgroundView = noDataLabel
                    self.allHomeTableView.backgroundColor = UIColor.white
                    self.allHomeTableView.separatorStyle = .none
                }else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getAllFilterStoryData(page: String,key:String, header: String, categoryID : String){
        Webservices.sharedInstance.getFilterStory(page: page, key: key, storyHeader: header, categoryID: categoryID){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList = somecategory
                    self.typeOfData = "filter"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.allHomeTableView.reloadData()
                    //                    self.isFilterData = true
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
                    
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearchData(page : String,key: String, searchKey: String,header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.getSearchAllStoryList(page: page, key: key, searchKey: searchKey, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.searchAllStoryList = somecategory
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchStoryList.append(contentsOf: somecategory.docs)
                    self.allHomeTableView.reloadData()
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
                    
                } else{
                    
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
                    self.allHomeTableView.reloadData()
                }
                if self.isSearching == true {
                    self.getAllStoryData(page: "", key: "All", header: self.currenUserLogin.token)
                }else {
                    self.getSearchData(page: "", key: "All", searchKey: self.searchText, header: self.currenUserLogin.token)
                    
                }
            }else{
                if self.isSearching == true {
                    self.getAllStoryData(page: "", key: "All", header: self.currenUserLogin.token)
                }else {
                    self.getSearchData(page: "", key: "All", searchKey: self.searchText, header: self.currenUserLogin.token)
                    
                }
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func increaseStoryView(storyID: String, header: String){
        Webservices.sharedInstance.increaseStoryViews(storyId: storyID, header: header){(result,message,response) in
            print(result)
            if result == 200{
                //                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                //                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension AllHomeViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            //            return allStoryList.docs.count
            return storyList.count
        } else {
            //            return searchAllStoryList.docs.count
            return searchStoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllHomeTableViewCellJM") as! AllHomeTableViewCellJM
        if isSearching{
            
            //            let arrdata = allStoryList.docs[indexPath.row]
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authorName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.journalistType.text = arrdata.journalistId.userType
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            //            cell.priceLabel.text = ("\(arrdata.realCurrencyCode) \(String(arrdata.realPrice))")
            cell.descri.text = arrdata.headLine
            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.soldoutLabel.text = ("\(String(arrdata.soldOut)) times")
            cell.purchaseLimit.text = arrdata.purchasingLimit
            
            //
            //            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            //            let url = NSURL(string: getProfileUrl)
            //            cell.journalistImage.sd_setImage(with: url! as URL)
            
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL, placeholderImage: #imageLiteral(resourceName: "Group 3009"))
                }
            }
            
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            
            cell.keywordsCollectionView.reloadData()
            cell.storyTypeLabel.text = arrdata.storyCategory
            cell.averageRattingLabel.text = (" \(String(arrdata.totalAveargeReview)) ")
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.storyCategory == "Exclusive"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.soldoutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            } else if arrdata.storyCategory == "Shared"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            } else if arrdata.storyCategory == "Free"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                //                cell.priceLabel.text = "Free"
                cell.priceLabel.isHidden = true
                cell.priceLabelHeading.isHidden = true
                cell.soldoutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.lineLabel.isHidden = true
                
            } else if arrdata.storyCategory == "Auction" {
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
                
                cell.soldOutLabelHeading.text = "Time left:"
                let leftTime = arrdata.auctionExpriyTime
                let NewLeftTime = Int(leftTime)!
                //Convert to Date
                let date = NSDate(timeIntervalSince1970: TimeInterval(NewLeftTime))
                //Date formatting
                let dateFormatter = DateFormatter()
                //        dateFormatter.dateFormat = "dd, MMMM yyyy HH:mm:a"
                dateFormatter.dateFormat = "HH:mm:ss"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                let dateString = dateFormatter.string(from: date as Date)
                print("formatted date is = \(dateString)")
                cell.soldoutLabel.text = dateString
            } else {
                cell.storyTypeLabel.isHidden = true
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.isHidden = true
                cell.priceLabelHeading.isHidden = true
                cell.soldoutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.lineLabel.isHidden = true
            }
            
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
        } else {
            //            let arrdata = searchAllStoryList.docs[indexPath.row]
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.authorName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)")
            cell.journalistType.text = arrdata.journalistId.userType
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            //            cell.priceLabel.text = ("\(arrdata.state.symbol)\(String(arrdata.price))")
            cell.descri.text = arrdata.headLine
            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            
            //            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            //            let url = NSURL(string: getProfileUrl)
            //            cell.journalistImage.sd_setImage(with: url! as URL)
            
            if arrdata.journalistId.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
                let profileUrls  = NSURL(string: (profilePic))
                if let temoProfileURs = profileUrls{
                    cell.journalistImage.sd_setImage(with: temoProfileURs as URL, placeholderImage: #imageLiteral(resourceName: "Group 3009"))
                }
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            
            
            cell.keywordsCollectionView.reloadData()
            cell.storyTypeLabel.text = arrdata.storyCategory
            cell.soldoutLabel.text = ("\(String(arrdata.soldOut)) times")
            cell.purchaseLimit.text = arrdata.purchasingLimit
            
            cell.averageRattingLabel.text = (" \(String(arrdata.totalAveargeReview)) ")
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            
            if arrdata.storyCategory == "Exclusive"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                //                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
                cell.soldoutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(format: "%.0f", arrdata.price))"
                
            } else if arrdata.storyCategory == "Shared"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            } else if arrdata.storyCategory == "Free"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.text = "Free"
            } else if arrdata.storyCategory == "Auction" {
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.text = "\(arrdata.currency) \(String(arrdata.price))"
                
                cell.soldOutLabelHeading.text = "Time left:"
                let leftTime = arrdata.auctionExpriyTime
                let NewLeftTime = Int(leftTime)!
                //Convert to Date
                let date = NSDate(timeIntervalSince1970: TimeInterval(NewLeftTime))
                //Date formatting
                let dateFormatter = DateFormatter()
                //        dateFormatter.dateFormat = "dd, MMMM yyyy HH:mm:a"
                dateFormatter.dateFormat = "HH:mm:ss"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                let dateString = dateFormatter.string(from: date as Date)
                print("formatted date is = \(dateString)")
                cell.soldoutLabel.text = dateString
                
            } else {
                cell.storyTypeLabel.isHidden = true
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
                cell.priceLabel.isHidden = true
                cell.priceLabelHeading.isHidden = true
                cell.soldoutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.lineLabel.isHidden = true
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
            //            let arrdata = allStoryList.docs[indexPath.row]
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            detailVC.categoryType = arrdata.categoryId.categoryName
            detailVC.time = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            detailVC.price = ("\(arrdata.currency) \(arrdata.price)")
            detailVC.auctionBiddingPrice = ("\(arrdata.currency) \(arrdata.auctionBiddingPrice)")
            detailVC.file = ("\(arrdata.fileCount) Files")
            detailVC.keywords = arrdata.keywordName
            detailVC.descriptions = arrdata.briefDescription
            detailVC.storyCategory = arrdata.storyCategory
            detailVC.reviewCount = arrdata.reviewCount
            detailVC.totalAverageRatting = Int(arrdata.totalAveargeReview)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                detailVC.imageThumbnail = thumbnailUrl
            }
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            detailVC.imageurl = getProfileUrl
            //            detailVC.StoryDetails = allStoryList
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
            
            self.increaseStoryView(storyID: arrdata.id, header: currenUserLogin.token)
        } else {
            //            let arrdata = searchAllStoryList.docs[indexPath.row]
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
            self.increaseStoryView(storyID: arrdata.id, header: currenUserLogin.token)
            
            detailVC.journalistID = arrdata.journalistId.id

            
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
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
            
            if self.typeOfData == "all"{
                getAllStoryData(page: "\(page)", key: "All", header: self.currenUserLogin.token)
            }else if typeOfData == "filter"{
                getAllFilterStoryData(page: "\(page)", key: "All", header: self.currenUserLogin.token, categoryID: self.getFilterID)
            }else if typeOfData == "search"{
                getSearchData(page: "\(page)", key: "All", searchKey: self.searchText, header: currenUserLogin.token)
            }else {
                return
            }
        }
    }
}


extension AllHomeViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "All", searchKey: searchBar.text!, header: currenUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "All", header: currenUserLogin.token)
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
            getSearchData(page: "0", key: "All", searchKey: searchBar.text!, header: currenUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "All", header: currenUserLogin.token)
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

extension AllHomeViewControllerJM: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getAllStoryData(page: "0", key: "All", header: currenUserLogin.token)
        } else {
            self.getFilterID = id
            self.getAllFilterStoryData(page: "0", key: "All", header: currenUserLogin.token, categoryID: id)
        }
    }
}


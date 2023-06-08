//
//  AuctionHomeControllerMH.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AuctionHomeControllerMH: UIViewController {
    
    @IBOutlet weak var auctionHomeTableView: UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
//    var allStoryList = MediaStroyModel()
//    var searchAllStoryList = MediaStroyModel()
    var favStoryData = AddTofavoriteModel()
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currenUserLogin : User!
    var isSearching : Bool = true
    var storyTimeArray = [String]()
    
    let timeInterval = 1591102983271
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    var storyList = [MediaStroyDocsModel]()
    var searchStoryList = [MediaStroyDocsModel]()
    var getFilterID = ""
    var typeOfData = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchingBar.delegate = self
//        searchingBar.searchTextField.backgroundColor = .white
        self.currenUserLogin = User.loadSavedUser()
        getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
        
        //        //Convert to Date
        //        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        //        //Date formatting
        //        let dateFormatter = DateFormatter()
        //        //        dateFormatter.dateFormat = "dd, MMMM yyyy HH:mm:a"
        //        dateFormatter.dateFormat = "HH:mm:ss"
        //        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        //        let dateString = dateFormatter.string(from: date as Date)
        //        print("formatted date is = \(dateString)")
        
    }
    
    fileprivate func setupTableView() {
        auctionHomeTableView.dataSource = self
        auctionHomeTableView.delegate = self
        auctionHomeTableView.bounces = false
        auctionHomeTableView.alwaysBounceVertical = false
        auctionHomeTableView.rowHeight = UITableView.automaticDimension
        auctionHomeTableView.estimatedRowHeight = 1000
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
    
    
    
    
    @IBAction func buttonActionFilter(_ sender: Any) {
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchFilterVC") as! SearchFilterVC
        filterVC.delegate = self
        self.storyList.removeAll()
        self.page = 0
        self.totalPages = 0
        self.present(filterVC, animated: true, completion: nil)
    }
    
    func getAllStoryData(page: String,key : String, header : String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getStoryList(page: page, key: key, storyHeader: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList.removeAll()
                    //                    self.allStoryList.append(contentsOf: somecategory)
                    
//                    self.allStoryList = somecategory
//                    self.calculateTime()
//                    self.auctionHomeTableView.reloadData()
                    
                    self.typeOfData = "auction"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.auctionHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.auctionHomeTableView.bounds.size.width, height: self.auctionHomeTableView.bounds.size.height))
                    noDataLabel.text = "No story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.auctionHomeTableView.backgroundView = noDataLabel
                    self.auctionHomeTableView.backgroundColor = UIColor.white
                    self.auctionHomeTableView.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Get Filter story -------
    func getFilterStoryData(page: String,key : String, categoryId: String, header : String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getFilterStoryList(page: page, key: key, categoryId: categoryId, storyHeader: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.allStoryList = somecategory
//                    self.calculateTime()
//                    self.auctionHomeTableView.reloadData()
                    
                    self.typeOfData = "filter"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.auctionHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.auctionHomeTableView.bounds.size.width, height: self.auctionHomeTableView.bounds.size.height))
                    noDataLabel.text = "No story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.auctionHomeTableView.backgroundView = noDataLabel
                    self.auctionHomeTableView.backgroundColor = UIColor.white
                    self.auctionHomeTableView.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    //-------Search All story -------
    func getSearchData(page : String,key: String, searchKey: String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getSearchAllStoryList(page: page, key: key, searchKey: searchKey, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.searchAllStoryList = somecategory
//                    self.auctionHomeTableView.reloadData()
                    
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchStoryList.append(contentsOf: somecategory.docs)
                    self.auctionHomeTableView.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.auctionHomeTableView.bounds.size.width, height: self.auctionHomeTableView.bounds.size.height))
                    noDataLabel.text = "No story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.auctionHomeTableView.backgroundView = noDataLabel
                    self.auctionHomeTableView.backgroundColor = UIColor.white
                    self.auctionHomeTableView.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Add to Wishlist -------
    func AddFavoriteStory(storyId: String, header: String) {
        //CommonClass.showLoader()
        WebService3.sharedInstance.AddToFavoriteStroy(storyId: storyId, storyHeader: header) { (result, message, response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.favStoryData = somecategory
                    self.auctionHomeTableView.reloadData()
                }
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
                }else {
                    self.getSearchData(page: "0", key: "Auction", searchKey: self.searchText, header: self.currenUserLogin.mediahouseToken)
                }
            }else{
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
                }else {
                    self.getSearchData(page: "0", key: "Auction", searchKey: self.searchText, header: self.currenUserLogin.mediahouseToken)
                }
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension AuctionHomeControllerMH: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
//            return allStoryList.docs.count
            return storyList.count
        } else {
//            return searchAllStoryList.docs.count
            return searchStoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionHomeTableViewCell") as! AuctionHomeTableViewCell
        if isSearching {
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
             cell.authorName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.city.name)")
            cell.fileCountLabel.text = ("\(arrdata.fileCount) Files")
            let url = NSURL(string: arrdata.journalistId.Image)
            cell.journalistImage.sd_setImage(with: url! as URL)
            cell.descriptionLabel.text = arrdata.headLine
            //cell.soldOutCount.text = String(arrdata.soldOut)
            print("id==================\(arrdata.id)")
            print("arrdata.keywordName==================\(arrdata.keywordName)")
            
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.journalistImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if arrdata.totalAveargeReview == 0{
                cell.ratingLabel.isHidden = true
                cell.rattingStar.isHidden = true
            } else {
                cell.ratingLabel.isHidden = false
                cell.rattingStar.isHidden = false
            }
            
            
            //-----For tag Types
            if arrdata.storyCategory == "Free" {
                cell.buttonType.setTitle("Free", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
                cell.buttonType.isHidden = false
                cell.priceLabel.isHidden = true
                cell.priceTag.isHidden = true
                cell.buttonBuyNow.isHidden = true
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
            } else if arrdata.storyCategory == "Exclusive" {
                cell.buttonType.setTitle("Exclusive", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price) | Sold out: \(arrdata.soldOut) times")
            } else if arrdata.storyCategory == "Shared" {
                cell.buttonType.setTitle("Shared", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.buttonType.isHidden = false
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price) | Sold out: \(arrdata.soldOut) times")
            } else if arrdata.storyCategory == "Auction" {
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.auctionBiddingPrice)")
                
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
                cell.timeLeftLabel.text = dateString
                
            } else {
                cell.priceTag.isHidden = true
                cell.buttonType.isHidden = true
                cell.priceLabel.isHidden = true
                cell.buttonBuyNow.isHidden = true
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
            }
            //-----For tag Types
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
        } else {
            let arrdata = searchStoryList[indexPath.row]
            print("count=======================\(arrdata.price)")
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.authorName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.city.name)")
            //cell.priceLabel.text = ("$ \(arrdata.price)")
            cell.fileCountLabel.text = ("\(arrdata.fileCount) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            let url = NSURL(string: arrdata.journalistId.Image)
            cell.journalistImage.sd_setImage(with: url! as URL)
            cell.descriptionLabel.text = arrdata.headLine
            cell.buttonBuyNow.isHidden = true
            //cell.soldOutCount.text = String(arrdata.soldOut)
            
            cell.buttonFavorite.tag = indexPath.row//Int(searchAllStoryList.docs[indexPath.row].id) ?? 99
            cell.buttonFavorite.addTarget(self, action: #selector(buttonAddToFav(sender:)), for: .touchUpInside)
            
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.journalistImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if arrdata.totalAveargeReview == 0{
                cell.ratingLabel.isHidden = true
                cell.rattingStar.isHidden = true
            } else {
                cell.ratingLabel.isHidden = false
                cell.rattingStar.isHidden = false
            }
            
            
            //-----For tag Types
            if arrdata.storyCategory == "Free" {
                cell.buttonType.setTitle("Free", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
                cell.buttonType.isHidden = false
                cell.priceLabel.isHidden = true
                cell.priceTag.isHidden = true
                cell.buttonBuyNow.isHidden = true
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
            } else if arrdata.storyCategory == "Exclusive" {
                cell.buttonType.setTitle("Exclusive", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price) | Sold out: \(arrdata.soldOut) times")
            } else if arrdata.storyCategory == "Shared" {
                cell.buttonType.setTitle("Shared", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.buttonType.isHidden = false
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price) | Sold out: \(arrdata.soldOut) times")
            } else if arrdata.storyCategory == "Auction" {
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.auctionBiddingPrice)")
            } else {
                cell.priceTag.isHidden = true
                cell.buttonType.isHidden = true
                cell.priceLabel.isHidden = true
                cell.buttonBuyNow.isHidden = true
                cell.ratingLabel.text = String(arrdata.totalAveargeReview)
            }
            //-----For tag Types
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
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
            cell.timeLeftLabel.text = dateString

            
        }
        return cell
    }
    
    @objc func buttonAddToFav(sender: UIButton){
        if isSearching {
            let id = storyList[sender.tag].id
            print("idSearch=========\(id)")
            self.AddFavoriteStory(storyId: id, header: self.currenUserLogin.mediahouseToken)
        } else {
            let id = searchStoryList[sender.tag].id
            print("idSearch=========\(id)")
            //self.getSearchData(key: "All", searchKey: self.searchText, header: self.header)
            self.AddFavoriteStory(storyId: id, header: self.currenUserLogin.mediahouseToken)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AppStoryboard.MediaHouse.viewController(StoryDetailsVC.self)
        
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
            
            detailVC.realBiddingPrice = arrdata.realBiddingPrice
            detailVC.lastBiddingPrice = arrdata.lastBiddingPrice
            detailVC.auctionBiddingPrices = ("\(arrdata.auctionBiddingPrice)")
            detailVC.biddingView = "bidView"
            
            detailVC.JournalistId = arrdata.journalistId.id
            detailVC.firstName = arrdata.journalistId.firstName
            detailVC.middleName = arrdata.journalistId.middleName
            detailVC.lastName = arrdata.journalistId.lastName
            detailVC.userType = arrdata.journalistId.userType
            detailVC.profilePic = arrdata.journalistId.profilePic
            
            detailVC.currency = arrdata.currency
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                detailVC.imageThumbnail = thumbnailUrl
            }
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"//arrdata.journalistId.Image
            detailVC.imageurl = getProfileUrl
            detailVC.StoryDetails = storyList[indexPath.row]
            detailVC.storyId = arrdata.id
            detailVC.getTextArray = arrdata.uploadTexts
            detailVC.keywords = arrdata.keywordName
            detailVC.headline = arrdata.headLine
            detailVC.favouriteStatus = arrdata.favouriteStatus
            print("id==================\(arrdata.id)")
            print("id==================\(arrdata.storyCategory)")
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
            detailVC.StoryDetails = searchStoryList[indexPath.row]
            detailVC.storyId = arrdata.id
            detailVC.getTextArray = arrdata.uploadTexts
            detailVC.keywords = arrdata.keywordName
            detailVC.headline = arrdata.headLine
            detailVC.favouriteStatus = arrdata.favouriteStatus
            print("id==================\(arrdata.id)")
            print("id==================\(arrdata.storyCategory)")
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         // print(indexPath.row)
         //        if isSearching{
         
         if !scrollPage { return }
         var totalPaginationPage = 0
         if self.typeOfData == "auction"{
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
             
             
             if self.typeOfData == "auction"{
                getAllStoryData(page: "\(page)", key: "", header: currenUserLogin.mediahouseToken)
             }else if typeOfData == "filter"{
                getFilterStoryData(page: "\(page)", key: "", categoryId: getFilterID, header: currenUserLogin.mediahouseToken)
             }else if typeOfData == "search"{
                getSearchData(page: "\(page)", key: "", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)
             }else {
                 return
             }
             
         }
         
     }

    
}

extension AuctionHomeControllerMH: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Auction", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Auction", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
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

//------getting Filter data
extension AuctionHomeControllerMH: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getAllStoryData(page: "0", key: "Auction", header: self.currenUserLogin.mediahouseToken)
        } else {
            self.getFilterID = id
            self.getFilterStoryData(page: "0", key: "Auction", categoryId: id, header: self.currenUserLogin.mediahouseToken)
        }
    }
}




extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}


//Date().millisecondsSince1970 // 1476889390939
//Date(milliseconds: 0)

//TimeStamp
//let timeInterval = 1415639000.67457
//print("time interval is \(timeInterval)")



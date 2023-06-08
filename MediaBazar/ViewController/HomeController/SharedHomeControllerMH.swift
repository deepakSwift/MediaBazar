//
//  SharedHomeControllerMH.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SharedHomeControllerMH: UIViewController {
    
    @IBOutlet weak var sharedHomeTableView: UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
//    var allStoryList = MediaStroyModel()
//    var searchAllStoryList = MediaStroyModel()
    var currenUserLogin : User!
    var favStoryData = AddTofavoriteModel()
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var isSearching : Bool = true
    var storyTimeArray = [String]()
    
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
        self.currenUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
//        searchingBar.searchTextField.backgroundColor = .white
        getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
    }
    
    fileprivate func setupTableView() {
        sharedHomeTableView.dataSource = self
        sharedHomeTableView.delegate = self
        sharedHomeTableView.bounces = false
        sharedHomeTableView.alwaysBounceVertical = false
        sharedHomeTableView.rowHeight = UITableView.automaticDimension
        sharedHomeTableView.estimatedRowHeight = 1000
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
                        
//                        self.allStoryList = somecategory
//                        self.calculateTime()
//                        self.sharedHomeTableView.reloadData()
                        
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
                        noDataLabel.text = "No story available."
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
    
    //-------Get Filter story -------
    func getFilterStoryData(page : String,key : String, categoryId: String, header : String){
               CommonClass.showLoader()
        WebService3.sharedInstance.getFilterStoryList(page: page, key: key, categoryId: categoryId, storyHeader: header){(result,message,response) in
                   print(result)
                   CommonClass.hideLoader()
                   if result == 200{
                       if let somecategory = response{
//                           self.allStoryList = somecategory
//                           self.calculateTime()
//                           self.sharedHomeTableView.reloadData()
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
                        noDataLabel.text = "No story available."
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
    
    //-------Search All story -------
    func getSearchData(page : String,key: String, searchKey: String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getSearchAllStoryList(page: page, key: key, searchKey: searchKey, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList.removeAll()
                    //                    self.allStoryList.append(contentsOf: somecategory)
                    
//                    self.searchAllStoryList = somecategory
//                    self.sharedHomeTableView.reloadData()
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
                    noDataLabel.text = "No story available."
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
    
    //-------Add to Wishlist -------
    func AddFavoriteStory(storyId: String, header: String) {
         //CommonClass.showLoader()
        WebService3.sharedInstance.AddToFavoriteStroy(storyId: storyId, storyHeader: header) { (result, message, response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.favStoryData = somecategory
                    self.sharedHomeTableView.reloadData()
                }
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
                }else {
                    self.getSearchData(page: "0", key: "Shared", searchKey: self.searchText, header: self.currenUserLogin.mediahouseToken)
                }
            }else{
                if self.isSearching == true {
                    self.getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
                }else {
                    self.getSearchData(page: "0", key: "Shared", searchKey: self.searchText, header: self.currenUserLogin.mediahouseToken)
                }
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}


extension SharedHomeControllerMH: UITableViewDataSource, UITableViewDelegate {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedHomeTableViewCell") as! SharedHomeTableViewCell
        if isSearching {
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.authorName.text = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            cell.fileCountLabel.text = ("\(arrdata.fileCount) Files")
            let url = NSURL(string: arrdata.journalistId.Image)
            cell.journalistImage.sd_setImage(with: url! as URL)
            cell.descriptionLabel.text = arrdata.headLine
            cell.soldOutCount.text = ("\(String(arrdata.soldOut)) Times")
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
                cell.ratingLabel.text = (" \(String(arrdata.totalAveargeReview)) ")
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price)")
            } else if arrdata.storyCategory == "Auction" {
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                 cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.auctionBiddingPrice) | Time: Time")
            } else {
                //cell.buttonType.setTitle("----", for: .normal)
                //cell.buttonType.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
            cell.authorName.text = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            cell.fileCountLabel.text = ("\(arrdata.fileCount) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            let url = NSURL(string: arrdata.journalistId.Image)
            cell.journalistImage.sd_setImage(with: url! as URL)
            cell.descriptionLabel.text = arrdata.headLine
            cell.soldOutCount.text = "\(String(arrdata.soldOut)) Times"
            
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
                cell.ratingLabel.text = (" \(String(arrdata.totalAveargeReview)) ")
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price)")
            } else if arrdata.storyCategory == "Auction" {
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.buttonType.isHidden = false
                cell.ratingLabel.isHidden = true
                cell.priceTag.isHidden = false
                cell.buttonBuyNow.isHidden = false
                cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                 cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.auctionBiddingPrice) | Time: Time")
            } else {
                //cell.buttonType.setTitle("----", for: .normal)
                //cell.buttonType.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
            
            detailVC.JournalistId = arrdata.journalistId.id
            detailVC.firstName = arrdata.journalistId.firstName
            detailVC.middleName = arrdata.journalistId.middleName
            detailVC.lastName = arrdata.journalistId.lastName
            detailVC.userType = arrdata.journalistId.userType
            detailVC.profilePic = arrdata.journalistId.profilePic
            
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
                getAllStoryData(page: "\(page)", key: "Shared", header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "filter"{
                getFilterStoryData(page: "\(page)", key: "Shared", categoryId: getFilterID, header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "search"{
                getSearchData(page: "\(page)", key: "Shared", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)
            }else {
                return
            }
            
        }
        
    }

    
}


extension SharedHomeControllerMH: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchData(page: "0", key: "Shared", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
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
            getSearchData(page: "0", key: "Shared", searchKey: searchBar.text!, header: self.currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
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
extension SharedHomeControllerMH: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getAllStoryData(page: "0", key: "Shared", header: self.currenUserLogin.mediahouseToken)
        } else {
            self.getFilterID = id
            self.getFilterStoryData(page: "0", key: "Shared", categoryId: id, header: self.currenUserLogin.mediahouseToken)
        }
    }
}


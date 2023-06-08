//
//  PurchaseStoriesVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseStoriesVC: UIViewController {
    
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewPurchaseStories: UITableView!
    
//    var allStoryList = FavoriteDocModel()
//    var searchAllStoryList = FavoriteDocModel()
    var currenUserLogin : User!
    var isSearching : Bool = true
    var storyTimeArray = [String]()
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var allStoryList = [FavoriteStroyDocsModel]()
    var searchAllStoryList = [FavoriteStroyDocsModel]()
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var typeOfData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        setupButton()
        apiCall()
        searchingBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView() {
        tableViewPurchaseStories.alwaysBounceVertical = false
        tableViewPurchaseStories.rowHeight = UITableView.automaticDimension
        tableViewPurchaseStories.estimatedRowHeight = 1000
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func apiCall() {
        getPurchaseList(page: "0", searchKey: "", header: currenUserLogin.mediahouseToken)
    }
    
    func calculateTime() {
        if isSearching {
            var tempTimeArray = [String]()
            for data in self.allStoryList.enumerated() {
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
            for data in self.searchAllStoryList.enumerated() {
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
    
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnDownLoadButton(sender : UIButton){
        
        let storyID = allStoryList[sender.tag].storyId.id
        print("storyID========\(storyID)")
        downloadporchaseStory(storyId: storyID, header: currenUserLogin.mediahouseToken)
        
    }
    

    func downloadporchaseStory(storyId : String, header : String){
        Webservice.sharedInstance.purchaseDownloadStory(storyId: storyId, header: header){(result,response,message) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    //-------Get All story -------
    func getPurchaseList(page : String,searchKey: String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.purchaseStoryList(page: page, searchKey: searchKey, header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.allStoryList = somecategory
                    self.typeOfData = "all"
                    self.scrollPage = true
                    self.allStoryList.append(contentsOf: somecategory.docs)
                    self.tableViewPurchaseStories.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewPurchaseStories.bounds.size.width, height: self.tableViewPurchaseStories.bounds.size.height))
                    noDataLabel.text = "No purchase story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewPurchaseStories.backgroundView = noDataLabel
                    self.tableViewPurchaseStories.backgroundColor = UIColor.white
                    self.tableViewPurchaseStories.separatorStyle = .none
                }
            }else{
                self.tableViewPurchaseStories.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Search All story -------
    func getSearchData(page : String,searchKey: String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.searchPurchaseStory(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.searchAllStoryList = somecategory
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchAllStoryList.append(contentsOf: somecategory.docs)
                    self.tableViewPurchaseStories.reloadData()
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
                if self.searchAllStoryList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewPurchaseStories.bounds.size.width, height: self.tableViewPurchaseStories.bounds.size.height))
                    noDataLabel.text = "No purchase story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewPurchaseStories.backgroundView = noDataLabel
                    self.tableViewPurchaseStories.backgroundColor = UIColor.white
                    self.tableViewPurchaseStories.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

//----------- SearchBar Delegate --------------
extension PurchaseStoriesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchAllStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getPurchaseList(page: "0", searchKey: "", header: currenUserLogin.mediahouseToken)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchAllStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            self.getPurchaseList(page: "0", searchKey: "", header: currenUserLogin.mediahouseToken)
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

//----TableView---
extension PurchaseStoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return allStoryList.count
        } else {
            return searchAllStoryList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseStoryTableCell", for: indexPath) as! PurchaseStoryTableCell
        
        if isSearching {
            let data = allStoryList[indexPath.row]
            cell.labelTitleName.text = data.storyId.categoryId.categoryName
            cell.buttonShared.setTitle(data.storyId.storyCategory, for: .normal)
            cell.labelAddress.text = data.realPrice
            cell.labelPrice.text = "\(data.currency): \(data.amount)"
            cell.labelSubtitle.text = data.headline
            cell.keyword = data.keywordName
            cell.collectionViewKeyWords.reloadData()
            cell.lableDaysCount.text = storyTimeArray[indexPath.row]
            cell.labelAddress.text = " \(data.storyId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.storyId.city.name)"
            cell.labelratings.text = String(data.storyId.totalAveargeReview)
            
            cell.buttonDownload.tag = indexPath.row
            cell.buttonDownload.addTarget(self, action: #selector(clickOnDownLoadButton(sender:)), for: .touchUpInside)
            
            
            if data.storyId.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(data.storyId.uploadThumbnails[0].thumbnale)"
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.imageViewSetImg.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            //-----For tag Types
            if data.storyId.storyCategory == "Free" {
                cell.buttonShared.setTitle("Free", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
            } else if data.storyId.storyCategory == "Exclusive" {
                cell.buttonShared.setTitle("Exclusive", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
            } else if data.storyId.storyCategory == "Shared" {
                cell.buttonShared.setTitle("Shared", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
            } else if data.storyId.storyCategory == "Auction" {
                cell.buttonShared.setTitle("Auction", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
            } else {
                //cell.buttonType.setTitle("----", for: .normal)
                //cell.buttonType.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                //cell.buttonType.isHidden = true
            }
        } else {
            let data = searchAllStoryList[indexPath.row]
            cell.labelTitleName.text = data.storyId.categoryId.categoryName
            cell.buttonShared.setTitle(data.storyId.storyCategory, for: .normal)
            cell.labelAddress.text = data.realPrice
            cell.labelPrice.text = "\(data.currency): \(data.amount)"
            cell.labelSubtitle.text = data.headline
            cell.keyword = data.keywordName
            cell.collectionViewKeyWords.reloadData()
            cell.lableDaysCount.text = storyTimeArray[indexPath.row]
            cell.labelAddress.text = " \(data.storyId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.storyId.city.name)"
            cell.labelratings.text = String(data.storyId.totalAveargeReview)
            
            if data.storyId.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(data.storyId.uploadThumbnails[0].thumbnale)"
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.imageViewSetImg.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            //-----For tag Types
            if data.storyId.storyCategory == "Free" {
                cell.buttonShared.setTitle("Free", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
            } else if data.storyId.storyCategory == "Exclusive" {
                cell.buttonShared.setTitle("Exclusive", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
            } else if data.storyId.storyCategory == "Shared" {
                cell.buttonShared.setTitle("Shared", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
            } else if data.storyId.storyCategory == "Auction" {
                cell.buttonShared.setTitle("Auction", for: .normal)
                cell.buttonShared.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
            } else {
                //cell.buttonType.setTitle("----", for: .normal)
                //cell.buttonType.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                //cell.buttonType.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseStoryDetailsVC") as! PurchaseStoryDetailsVC
        if isSearching {
            let data = allStoryList[indexPath.row]
            detailsVC.StoryDetails = allStoryList[indexPath.row]
            detailsVC.headline = data.headline
            detailsVC.time = " \(data.storyId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.storyId.city.name)"
            detailsVC.price = data.realPrice
            detailsVC.storyCategory = data.storyId.storyCategory
            detailsVC.descriptions = data.storyId.briefDescription
            detailsVC.keywords = data.storyId.keywordName
            detailsVC.categoryType = data.storyId.categoryId.categoryName
            detailsVC.currency = data.storyId.currency
            detailsVC.storyId = data.storyId.id
            detailsVC.allOverRatting = Int(data.storyId.totalAveargeReview)
            detailsVC.file = ("\(data.storyId.fileCount) Files")

            if data.storyId.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(data.storyId.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                          detailsVC.imageThumbnail = thumbnailUrl
            }
            
            
            
        } else {
            let data = searchAllStoryList[indexPath.row]
            detailsVC.StoryDetails = searchAllStoryList[indexPath.row]
            detailsVC.headline = data.headline
            detailsVC.time = " \(data.storyId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.storyId.city.name)"
            detailsVC.price = data.realPrice
            detailsVC.storyCategory = data.storyId.storyCategory
            detailsVC.descriptions = data.storyId.briefDescription
            detailsVC.keywords = data.storyId.keywordName
            detailsVC.categoryType = data.storyId.categoryId.categoryName
            detailsVC.currency = data.storyId.currency
            detailsVC.storyId = data.id
            
            if data.storyId.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(data.storyId.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                          detailsVC.imageThumbnail = thumbnailUrl
            }

        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
            totalPaginationPage = allStoryList.count
        }else if typeOfData == "search"{
            totalPaginationPage = searchAllStoryList.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            if self.typeOfData == "all"{
                getPurchaseList(page: "\(page)", searchKey: "", header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "search"{
            getSearchData(page: "\(page)", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)
            }else {
                return
            }
        }
    }
}

//
//  MyStoriesViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyStoriesViewControllerJM: UIViewController {
    
    @IBOutlet weak var myStoriesTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var filterButton : UIButton!
    
//    var myStorydata = listStory()
//    var searchData = listStory()
    var isSearching : Bool = true
    var currentUserLogin : User!
    //    var thumbnailImage = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    var searchText = ""
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    var storyList = [storyListModal]()
    var searchStoryList = [storyListModal]()
    var getFilterID = ""
    var typeOfData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
        setupTableView()
        setupUI()
        setUpButton()
        getMyStory(page: "0", header: currentUserLogin.token)
        
        searchingBar.isHidden = false
        filterButton.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
//        self.currentUserLogin = User.loadSavedUser()
//        getMyStory(header: currentUserLogin.token)
    }
    
    
    func setupTableView(){
        self.myStoriesTableView.dataSource = self
        self.myStoriesTableView.delegate = self
        myStoriesTableView.bounces = false
        myStoriesTableView.alwaysBounceVertical = false
        myStoriesTableView.rowHeight = UITableView.automaticDimension
        myStoriesTableView.estimatedRowHeight = 1000
        myStoriesTableView.reloadData()
    }
    
    func setupUI(){
        topView.applyShadow()
        
    }
    
    func setUpButton(){
        filterButton.addTarget(self, action: #selector(clickOnFIlterButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
    
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func clickOnFIlterButton(){
        let filterVC = AppStoryboard.MediaHouse.viewController(SearchFilterVC.self)
        filterVC.delegate = self
        self.present(filterVC, animated: true, completion: nil)
        
    }
    
    @objc func clickOnEditButton(){
        
    }
    
    func getMyStory(page : String,header: String){
        Webservices.sharedInstance.getMyStoryList(page: page, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.myStorydata = somecategory
//                    self.myStoriesTableView.reloadData()
//                    self.calculateTime()
                    //                    self.setupData()
                    self.typeOfData = "free"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    //                    self.allStoryList = somecategory
                    self.myStoriesTableView.reloadData()
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
                                  let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myStoriesTableView.bounds.size.width, height: self.myStoriesTableView.bounds.size.height))
                                  noDataLabel.text = "No story available."
                                  noDataLabel.textColor = UIColor.black
                                  noDataLabel.textAlignment = .center
                                  self.myStoriesTableView.backgroundView = noDataLabel
                                  self.myStoriesTableView.backgroundColor = UIColor.white
                                  self.myStoriesTableView.separatorStyle = .none
                              }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getMyStoryFilter(page: String,categoryId : String, header: String){
        Webservices.sharedInstance.getMyStoryFilterStory(page: page, storyHeader: header, categoryID: categoryId){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.myStorydata = somecategory
//                    self.myStoriesTableView.reloadData()
//                    self.calculateTime()
                    //                    self.setupData()
                    self.typeOfData = "filter"
                    self.scrollPage = true
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.myStoriesTableView.reloadData()
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
                                let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myStoriesTableView.bounds.size.width, height: self.myStoriesTableView.bounds.size.height))
                                noDataLabel.text = "No story available."
                                noDataLabel.textColor = UIColor.black
                                noDataLabel.textAlignment = .center
                                self.myStoriesTableView.backgroundView = noDataLabel
                                self.myStoriesTableView.backgroundColor = UIColor.white
                                self.myStoriesTableView.separatorStyle = .none
                            }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getSearchMyStory(page : String,searchKey : String,header: String){
        Webservices.sharedInstance.getSearchMyStoryList(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.searchData = somecategory
//                    self.myStoriesTableView.reloadData()
//                    self.calculateTime()
                    //                    self.setupData()
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.searchStoryList.append(contentsOf: somecategory.docs)
                    self.myStoriesTableView.reloadData()
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
                               let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.myStoriesTableView.bounds.size.width, height: self.myStoriesTableView.bounds.size.height))
                               noDataLabel.text = "No exclusive story available."
                               noDataLabel.textColor = UIColor.black
                               noDataLabel.textAlignment = .center
                               self.myStoriesTableView.backgroundView = noDataLabel
                               self.myStoriesTableView.backgroundColor = UIColor.white
                               self.myStoriesTableView.separatorStyle = .none
                           }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
}

extension MyStoriesViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
//            return myStorydata.docs.count
            return storyList.count
        } else{
//            return searchData.docs.count
            return searchStoryList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyStoriesTableViewCellJM") as! MyStoriesTableViewCellJM
        if isSearching{
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageName.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            //        cell.countryName.text = arrdata.country.name
            cell.descri.text = arrdata.headLine
//            cell.keyword = arrdata.keywordName
            
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            cell.soldOutLabel.text = ("\(String(arrdata.soldOut)) Times")
            cell.purchaselabel.text = arrdata.purchasingLimit
            cell.totalAverageReview.text = String(arrdata.totalAveargeReview)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.totalAveargeReview == 0{
                cell.totalAverageReview.isHidden = true
                cell.starImage.isHidden = true
            } else {
                cell.totalAverageReview.isHidden = true
                cell.starImage.isHidden = true
            }
            
            
            if arrdata.storyCategory == "Free" {
                cell.buttonType.setTitle("Free", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
                cell.soldOutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceLAbel.text = "Free"
                cell.priceHeading.isHidden = false
                cell.lineLabel.isHidden = true
            } else if arrdata.storyCategory == "Exclusive" {
                cell.buttonType.setTitle("Exclusive", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceHeading.isHidden = false
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realPrice)"
            } else if arrdata.storyCategory == "Shared" {
                cell.buttonType.setTitle("Shared", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = false
                cell.purchaselabelHeading.isHidden = false
                cell.priceHeading.isHidden = false
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realPrice)"
            } else if arrdata.storyCategory == "Auction"{
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.soldOutLabelHeading.text = "Time"
                cell.soldOutLabel.text = arrdata.auctionDuration
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realBiddingPrice)"
                cell.priceHeading.isHidden = false
                
            } else {
                cell.buttonType.isHidden = true
                cell.soldOutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceLAbel.isHidden = true
                cell.priceHeading.isHidden = true
                
            }
            
        } else{
            let arrdata = searchStoryList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageName.text = ("\(arrdata.langCode) | \(time) | \(arrdata.country.name)")
            //        cell.countryName.text = arrdata.country.name
            cell.priceLAbel.text = ("$ \(arrdata.price)")
            cell.descri.text = arrdata.headLine
//            cell.keyword = arrdata.keywordName
            
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()

            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.storyCategory == "Free" {
                cell.buttonType.setTitle("Free", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
                cell.soldOutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceLAbel.text = "Free"
                cell.priceHeading.isHidden = false
            } else if arrdata.storyCategory == "Exclusive" {
                cell.buttonType.setTitle("Exclusive", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceHeading.isHidden = false
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realPrice)"
            } else if arrdata.storyCategory == "Shared" {
                cell.buttonType.setTitle("Shared", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = false
                cell.purchaselabelHeading.isHidden = false
                cell.priceHeading.isHidden = false
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realPrice)"
            } else if arrdata.storyCategory == "Auction"{
                cell.buttonType.setTitle("Auction", for: .normal)
                cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.soldOutLabel.isHidden = false
                cell.soldOutLabelHeading.isHidden = false
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.soldOutLabelHeading.text = "Time"
                cell.soldOutLabel.text = arrdata.auctionDuration
                cell.priceHeading.isHidden = false
                cell.priceLAbel.text = "\(arrdata.currency)\(arrdata.realBiddingPrice)"
                
            } else {
                cell.buttonType.isHidden = true
                cell.soldOutLabel.isHidden = true
                cell.soldOutLabelHeading.isHidden = true
                cell.purchaselabel.isHidden = true
                cell.purchaselabelHeading.isHidden = true
                cell.priceLAbel.isHidden = true
                cell.priceHeading.isHidden = true
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailVC = AppStoryboard.Journalist.viewController(AllTypeStoryDetailsViewControllerJM.self)
        if isSearching {
            //detailVC.StoryDetails = allStoryList
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            detailVC.name =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
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
            
            detailVC.detailData = storyList[indexPath.row]
            detailVC.favouriteButon = "hide"
            
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
            
            detailVC.detailData = searchStoryList[indexPath.row]
            detailVC.favouriteButon = "hide"
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 165
//    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "free"{
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
            
            
            if self.typeOfData == "free"{
                getMyStory(page: "\(page)", header: currentUserLogin.token)
            }else if typeOfData == "filter"{
                getMyStoryFilter(page: "\(page)", categoryId: self.getFilterID, header: currentUserLogin.token)

            }else if typeOfData == "search"{
                getSearchMyStory(page: "\(page)", searchKey: self.searchText, header: currentUserLogin.token)
            }else {
                return
            }
            
        }
        
    }
    
}

extension MyStoriesViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.searchStoryList.removeAll()
            self.page = 0
            self.totalPages = 0
            getSearchMyStory(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getMyStory(page: "0", header: currentUserLogin.token)
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
            getSearchMyStory(page: "0", searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getMyStory(page: "0", header: currentUserLogin.token)
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


extension MyStoriesViewControllerJM: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            self.storyList.removeAll()
            self.page = 0
            self.totalPages = 0
            getMyStory(page: "0", header: currentUserLogin.token)
        } else {
            self.getFilterID = id
            self.getMyStoryFilter(page: "0", categoryId: id, header: currentUserLogin.token)
            
        }
    }
}


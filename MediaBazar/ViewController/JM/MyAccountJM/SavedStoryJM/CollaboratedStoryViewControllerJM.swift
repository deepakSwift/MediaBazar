//
//  CollaboratedStoryViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CollaboratedStoryViewControllerJM: UIViewController {
    
    @IBOutlet weak var collabrateStoryTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var filterButton : UIButton!
    
    var mySaveStoryList = listStory()
    var mySearchData = listStory()
    var isSearching : Bool = true
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setUpButtton()
        self.currentUserLogin = User.loadSavedUser()
        getSaveCollobateStory(header: currentUserLogin.token)
        
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.collabrateStoryTableView.dataSource = self
        self.collabrateStoryTableView.delegate = self
    }
    
    func setUpButtton(){
        filterButton.addTarget(self, action: #selector(clickOnFIlterButton), for: .touchUpInside)
    }
    
    func calculateTime() {
        if isSearching{
            var tempTimeArray = [String]()
            for data in mySaveStoryList.docs.enumerated() {
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
            for data in mySearchData.docs.enumerated() {
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
        self.present(filterVC, animated: true, completion: nil)
        
    }
    
    @objc func clickOnPostButton(sender : UIButton){
        if isSearching{
            let id = mySaveStoryList.docs[sender.tag].id
            print("id======\(id)")
            postStoryById(storyId: id, header: currentUserLogin.token)
            
        } else{
            let id = mySearchData.docs[sender.tag].id
            print("id======\(id)")
            postStoryById(storyId: id, header: currentUserLogin.token)
            
        }
    }
    
    
    func getSaveCollobateStory(header: String){
        Webservices.sharedInstance.getSaveCollobrateStoryList(header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.mySaveStoryList = somecategory
                    self.collabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //                    self.setupData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSaveSearchCollobateStory(searchKey: String, header: String){
        Webservices.sharedInstance.getSearchSavedCollobrateStoryList(searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.mySaveStoryList = somecategory
                    self.collabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //                    self.setupData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getFilterCollobrateStory(categoryId : String, header: String){
        Webservices.sharedInstance.getSaveCollobrateStoryFilterStory(storyHeader: header, categoryID: categoryId){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.mySaveStoryList = somecategory
                    self.collabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //                    self.setupData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func postStoryById(storyId: String, header: String){
        Webservices.sharedInstance.saveStoryPostById(storyId: storyId, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                self.collabrateStoryTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    
    
}


extension CollaboratedStoryViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return mySaveStoryList.docs.count
        }else {
            return mySearchData.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollaborateStoryTableViewCellJM") as! CollaborateStoryTableViewCellJM
        if isSearching{
            let arrdata = mySaveStoryList.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.categoryName.text = arrdata.categoryId.categoryName
            cell.languageName.text = ("\(arrdata.langCode) | \(time) | \(arrdata.country.name)")
            cell.priceLabel.text = ("$ \(arrdata.price)")
            cell.descri.text = arrdata.briefDescription
            cell.keyword = arrdata.keywordName
            
            cell.postButton.tag = indexPath.row
            cell.postButton.addTarget(self, action: #selector(clickOnPostButton(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnamilImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.storyCategory == "Free" {
                cell.storyCatButton.setTitle("Free", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
            } else if arrdata.storyCategory == "Exclusive" {
                cell.storyCatButton.setTitle("Exclusive", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
            } else if arrdata.storyCategory == "Shared" {
                cell.storyCatButton.setTitle("Shared", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
            } else if arrdata.storyCategory == "Auction"{
                cell.storyCatButton.setTitle("Auction", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
            } else {
                cell.storyCatButton.isHidden = true
            }
            
        } else {
            let arrdata = mySearchData.docs[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.categoryName.text = arrdata.categoryId.categoryName
            cell.languageName.text = ("\(arrdata.langCode) | \(time) | \(arrdata.country.name)")
            cell.priceLabel.text = ("$ \(arrdata.price)")
            cell.descri.text = arrdata.briefDescription
            cell.keyword = arrdata.keywordName
            
            cell.postButton.tag = indexPath.row
            cell.postButton.addTarget(self, action: #selector(clickOnPostButton(sender:)), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"//arrdata.uploadThumbnails[0].thumbnale
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnamilImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            if arrdata.storyCategory == "Free" {
                cell.storyCatButton.setTitle("Free", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
            } else if arrdata.storyCategory == "Exclusive" {
                cell.storyCatButton.setTitle("Exclusive", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
            } else if arrdata.storyCategory == "Shared" {
                cell.storyCatButton.setTitle("Shared", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
            } else if arrdata.storyCategory == "Auction"{
                cell.storyCatButton.setTitle("Auction", for: .normal)
                cell.storyCatButton.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
            } else {
                cell.storyCatButton.isHidden = true
            }
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if isSearching{
//            let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
//            detailVC.detailData = mySaveStoryList.docs[indexPath.row]
//            let times = storyTimeArray[indexPath.row]
//            detailVC.time = times
//            detailVC.storyID = mySaveStoryList.docs[indexPath.row].id
//
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        } else {
//            let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
//            detailVC.detailData = mySearchData.docs[indexPath.row]
//            let times = storyTimeArray[indexPath.row]
//            detailVC.time = times
//             detailVC.storyID = mySearchData.docs[indexPath.row].id
//            self.navigationController?.pushViewController(detailVC, animated: true)
//        }
        
        
        
        let detailVC = AppStoryboard.Journalist.viewController(AllTypeStoryDetailsViewControllerJM.self)
        if isSearching {
            //detailVC.StoryDetails = allStoryList
            let arrdata = mySaveStoryList.docs[indexPath.row]
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
//            detailVC.StoryDetails = mySaveStoryList
            detailVC.storyId = arrdata.id
            detailVC.getTextArray = arrdata.uploadTexts
            detailVC.keywords = arrdata.keywordName
            detailVC.headline = arrdata.headLine
            detailVC.favouriteStatus = arrdata.favouriteStatus
            print("id==================\(arrdata.id)")
            print("id==================\(arrdata.storyCategory)")
        } else {
            let arrdata = mySearchData.docs[indexPath.row]
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
//            detailVC.StoryDetails = mySearchData
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}


extension CollaboratedStoryViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            getSaveSearchCollobateStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getSaveCollobateStory(header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            getSaveSearchCollobateStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getSaveCollobateStory(header: currentUserLogin.token)
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

extension CollaboratedStoryViewControllerJM: SendNameOfAreaFilter {
    func FilterName(name: String, id: String) {
        if name == "clearFilter" {
            getSaveCollobateStory(header: self.currentUserLogin.token)
        } else {
            self.getFilterCollobrateStory(categoryId: id, header: self.currentUserLogin.token)
            
        }
    }
}

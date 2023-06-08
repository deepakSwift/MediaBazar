//
//  ApprovedCollaboratedStoriesControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ApprovedCollaboratedStoriesControllerJM: UIViewController {
    
    
    @IBOutlet weak var approvedcollabrateStoryTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    var myStorydata = collobrationModal()
    var searchData = collobrationModal()
    var isSearching : Bool = true
    var currentUserLogin : User!
    //    var thumbnailImage = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
        setupTableView()
        getApproveStory(searchKey: "", header: currentUserLogin.token)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.currentUserLogin = User.loadSavedUser()
        getApproveStory(searchKey: "", header: currentUserLogin.token)
        
    }
    
    
    func setupTableView(){
        self.approvedcollabrateStoryTableView.dataSource = self
        self.approvedcollabrateStoryTableView.delegate = self
        approvedcollabrateStoryTableView.reloadData()
    }
    
    
    
    func calculateTime() {
        if isSearching{
            
            var tempTimeArray = [String]()
            for data in myStorydata.docs.enumerated() {
                let tempData = data.element.storyId.createdAt
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
            for data in searchData.docs.enumerated() {
                let tempData = data.element.storyId.createdAt
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
    
    
    @objc func clickOnEditButton(){
        
    }
    
    func getApproveStory(searchKey: String, header: String ){
        Webservices.sharedInstance.getapprovedCollobratedLists(searchkey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.myStorydata = somecategory
                    self.approvedcollabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //                    self.setupData()
                    if self.myStorydata.docs.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.approvedcollabrateStoryTableView.bounds.size.width, height: self.approvedcollabrateStoryTableView.bounds.size.height))
                        noDataLabel.text = "No approved story available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.approvedcollabrateStoryTableView.backgroundView = noDataLabel
                        self.approvedcollabrateStoryTableView.backgroundColor = UIColor.white
                        self.approvedcollabrateStoryTableView.separatorStyle = .none
                    }
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getApproveSearchStory(searchKey: String, header: String ){
        Webservices.sharedInstance.getapprovedCollobratedLists(searchkey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.searchData = somecategory
                    self.approvedcollabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //         self.setupData()
                    if self.searchData.docs.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.approvedcollabrateStoryTableView.bounds.size.width, height: self.approvedcollabrateStoryTableView.bounds.size.height))
                        noDataLabel.text = "No approved story available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.approvedcollabrateStoryTableView.backgroundView = noDataLabel
                        self.approvedcollabrateStoryTableView.backgroundColor = UIColor.white
                        self.approvedcollabrateStoryTableView.separatorStyle = .none
                    }

                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
}

extension ApprovedCollaboratedStoriesControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return myStorydata.docs.count
        } else{
            return searchData.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApprovedCollaboratedStoriesTableViewCellJM") as! ApprovedCollaboratedStoriesTableViewCellJM
        if isSearching{
            
            let arrdata = myStorydata.docs[indexPath.row].storyId
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)")
            cell.journalistType.text = arrdata.journalistId.userType
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) |\(time) | \(arrdata.country.name)")
            cell.priceLabel.text = ("\(arrdata.state.symbol) \(String(arrdata.price))")
            cell.descri.text = arrdata.headLine
            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.soldoutLabel.text = ("\(String(arrdata.soldOut)) Times")
            cell.purchaseLimit.text = arrdata.purchasingLimit
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            let url = NSURL(string: getProfileUrl)
            cell.journalistImage.sd_setImage(with: url! as URL)
            
            
            cell.keyword = arrdata.keywordName
            cell.keywordsCollectionView.reloadData()
            cell.storyTypeLabel.text = arrdata.storyCategory
            
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            
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
            } else if arrdata.storyCategory == "Shared"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = false
                cell.purchaseLimitheading.isHidden = false
            } else if arrdata.storyCategory == "Free"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
            } else if arrdata.storyCategory == "Auction" {
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
            } else {
                cell.storyTypeLabel.isHidden = true
            }
            
            if arrdata.favouriteStatus == 1 {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
            
            
        } else {
            let arrdata = searchData.docs[indexPath.row].storyId
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)")
            cell.journalistType.text = arrdata.journalistId.userType
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.country.name)")
            cell.priceLabel.text = ("\(arrdata.state.symbol)\(String(arrdata.price))")
            cell.descri.text = arrdata.headLine
            cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
            cell.categoryType.text = arrdata.categoryId.categoryName
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            let url = NSURL(string: getProfileUrl)
            cell.journalistImage.sd_setImage(with: url! as URL)
            cell.keyword = arrdata.keywordName
            cell.keywordsCollectionView.reloadData()
            cell.storyTypeLabel.text = arrdata.storyCategory
            cell.soldoutLabel.text = ("\(String(arrdata.soldOut)) Times")
            cell.purchaseLimit.text = arrdata.purchasingLimit
            
            
            cell.buttonFavorite.tag = indexPath.row//Int(storyId) ?? 0
            
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
            } else if arrdata.storyCategory == "Shared"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = false
                cell.purchaseLimitheading.isHidden = false
            } else if arrdata.storyCategory == "Free"{
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
            } else if arrdata.storyCategory == "Auction" {
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.purchaseLimit.isHidden = true
                cell.purchaseLimitheading.isHidden = true
            } else {
                cell.storyTypeLabel.isHidden = true
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
        if isSearching{
            let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
            detailVC.detailData = myStorydata.docs[indexPath.row].storyId
            let times = storyTimeArray[indexPath.row]
            detailVC.time = times
            detailVC.storyID = myStorydata.docs[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
            detailVC.detailData = searchData.docs[indexPath.row].storyId
            let times = storyTimeArray[indexPath.row]
            detailVC.time = times
            detailVC.storyID = searchData.docs[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension ApprovedCollaboratedStoriesControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            getApproveSearchStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getApproveStory(searchKey: "", header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            getApproveSearchStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getApproveStory(searchKey: "", header: currentUserLogin.token)
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




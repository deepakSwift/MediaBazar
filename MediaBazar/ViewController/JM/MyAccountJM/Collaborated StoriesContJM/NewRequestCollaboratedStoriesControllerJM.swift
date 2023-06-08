//
//  NewRequestCollaboratedStoriesControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NewRequestCollaboratedStoriesControllerJM: UIViewController {
    
    @IBOutlet weak var newRequestCollabrateStoryTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    var myStorydata = collobrationModal()
    var searchData = collobrationModal()
    var isSearching : Bool = true
    var currentUserLogin : User!
    //    var thumbnailImage = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    var groupid = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        searchingBar.delegate = self
        setupTableView()
        getInviteStory(searchKey: "", header: currentUserLogin.token)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.currentUserLogin = User.loadSavedUser()
        getInviteStory(searchKey: "", header: currentUserLogin.token)
        
    }
    
    
    func setupTableView(){
        self.newRequestCollabrateStoryTableView.dataSource = self
        self.newRequestCollabrateStoryTableView.delegate = self
        newRequestCollabrateStoryTableView.reloadData()
    }
    
    func setUpData(){
        for data in myStorydata.docs.enumerated(){
            let groupID = data.element.id
            self.groupid = groupID
            print("groupid======\(groupid)")
        }
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
    
    @objc func clickOnApproveButton(sender : UIButton){
        if isSearching{
            let groupID = myStorydata.docs[sender.tag].id
            print("id======\(groupID)")
            self.rejectAndApproveStoryInvitation(groupID: groupID, status: "1", header: currentUserLogin.token)
        } else {
            let groupID = searchData.docs[sender.tag].id
            print("id======\(groupID)")
             self.rejectAndApproveStoryInvitation(groupID: groupID, status: "1", header: currentUserLogin.token)
        }
        
    }
    
    @objc func clickOnRejectButton(sender : UIButton){
        if isSearching{
            let groupID = myStorydata.docs[sender.tag].id
            print("id======\(groupID)")
             self.rejectAndApproveStoryInvitation(groupID: groupID, status: "0", header: currentUserLogin.token)
        } else {
            let groupID = searchData.docs[sender.tag].id
            print("id======\(groupID)")
             self.rejectAndApproveStoryInvitation(groupID: groupID, status: "0", header: currentUserLogin.token)
        }

    }
    
    
    func getInviteStory(searchKey: String, header: String ){
        Webservices.sharedInstance.getInviteCollobratedLists(searchkey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.myStorydata = somecategory
                    self.newRequestCollabrateStoryTableView.reloadData()
                    self.calculateTime()
                    self.setUpData()
                    
                    if self.myStorydata.docs.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.newRequestCollabrateStoryTableView.bounds.size.width, height: self.newRequestCollabrateStoryTableView.bounds.size.height))
                        noDataLabel.text = "No new request story available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.newRequestCollabrateStoryTableView.backgroundView = noDataLabel
                        self.newRequestCollabrateStoryTableView.backgroundColor = UIColor.white
                        self.newRequestCollabrateStoryTableView.separatorStyle = .none
                    }

                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getInviteSearchStory(searchKey: String, header: String ){
        Webservices.sharedInstance.getInviteCollobratedSearchLists(searchkey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.searchData = somecategory
                    self.newRequestCollabrateStoryTableView.reloadData()
                    self.calculateTime()
                    //         self.setupData()
                    
                    if self.searchData.docs.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.newRequestCollabrateStoryTableView.bounds.size.width, height: self.newRequestCollabrateStoryTableView.bounds.size.height))
                        noDataLabel.text = "No new request story available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.newRequestCollabrateStoryTableView.backgroundView = noDataLabel
                        self.newRequestCollabrateStoryTableView.backgroundColor = UIColor.white
                        self.newRequestCollabrateStoryTableView.separatorStyle = .none
                    }

                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func rejectAndApproveStoryInvitation(groupID : String, status : String, header : String){
        Webservices.sharedInstance.invitationCollobratedStoryStatus(groupID: groupID, status: status, header: header){(result,message,response) in
            print(result)
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
}

extension NewRequestCollaboratedStoriesControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return myStorydata.docs.count
        } else{
            return searchData.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewRequestCollaboratedStoriesTableViewCellJM") as! NewRequestCollaboratedStoriesTableViewCellJM
        if isSearching{
            
            let arrdata = myStorydata.docs[indexPath.row].storyId
            let time = storyTimeArray[indexPath.row]
            cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)")
            cell.journalistType.text = arrdata.journalistId.userType
            cell.categoryType.text = arrdata.categoryId.categoryName
            cell.languageLabel.text = ("\(arrdata.langCode) |\(time) | \(arrdata.country.name)")
            cell.priceLabel.text = ("\(arrdata.state.symbol) \(String(arrdata.price))")
            cell.descri.text = arrdata.briefDescription
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
            
            cell.approveButton.tag = indexPath.row
            cell.approveButton.addTarget(self, action: #selector(clickOnApproveButton(sender:)), for: .touchUpInside)
            
            cell.rejectButton.tag = indexPath.row
            cell.rejectButton.addTarget(self, action: #selector(clickOnRejectButton(sender:)), for: .touchUpInside)
            
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
            
            cell.approveButton.tag = indexPath.row
                       cell.approveButton.addTarget(self, action: #selector(clickOnApproveButton(sender:)), for: .touchUpInside)
                       
                       cell.rejectButton.tag = indexPath.row
                       cell.rejectButton.addTarget(self, action: #selector(clickOnRejectButton(sender:)), for: .touchUpInside)
            
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
            detailVC.hideDeleteButton = "hide"
            detailVC.favouriteButon = "hide"
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
            detailVC.detailData = searchData.docs[indexPath.row].storyId
            let times = storyTimeArray[indexPath.row]
            detailVC.time = times
            detailVC.storyID = searchData.docs[indexPath.row].id
            detailVC.hideDeleteButton = "hide"
            detailVC.favouriteButon = "hide"
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 250
    }
    
}

extension NewRequestCollaboratedStoriesControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            getInviteSearchStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getInviteStory(searchKey: "", header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            getInviteSearchStory(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getInviteStory(searchKey: "", header: currentUserLogin.token)
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




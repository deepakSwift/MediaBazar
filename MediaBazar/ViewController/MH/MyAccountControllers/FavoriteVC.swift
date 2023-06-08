//
//  FavoriteVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewFavorite: UITableView!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currenUserLogin : User!
    //    var allStoryList = FavoriteDocModel()
    var favStoryData = AddTofavoriteModel()
    var storyTimeArray = [String]()
    var allStoryList = [FavoriteStroyDocsModel]()
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        apiCall()
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func setupTableView() {
        tableViewFavorite.dataSource = self
        tableViewFavorite.delegate = self
        tableViewFavorite.bounces = false
        tableViewFavorite.alwaysBounceVertical = false
        tableViewFavorite.rowHeight = UITableView.automaticDimension
        tableViewFavorite.estimatedRowHeight = 1000
    }
    
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allStoryList.enumerated() {
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
    
    
    func apiCall() {
        self.geFavList(page: "0", header: currenUserLogin.mediahouseToken)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
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
                    self.tableViewFavorite.reloadData()
                }
                self.geFavList(page: "0", header: self.currenUserLogin.mediahouseToken)
            }else{
                self.geFavList(page: "0", header: self.currenUserLogin.mediahouseToken)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Get All story -------
    func geFavList(page : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.favoriteStoryList(page: page, header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList = somecategory
                    self.scrollPage = true
                    self.allStoryList.append(contentsOf: somecategory.docs)
                    self.tableViewFavorite.reloadData()
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
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewFavorite.bounds.size.width, height: self.tableViewFavorite.bounds.size.height))
                    noDataLabel.text = "No story available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewFavorite.backgroundView = noDataLabel
                    self.tableViewFavorite.backgroundColor = UIColor.white
                    self.tableViewFavorite.separatorStyle = .none
                }
            }else{
                self.tableViewFavorite.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    
}


//-- TableView----
extension FavoriteVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllHomeTableViewCell") as! AllHomeTableViewCell
        let arrdata = allStoryList[indexPath.row].storyId
        //        let time = storyTimeArray[indexPath.row]
        cell.journalistName.text =  "\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)"
        cell.categoryType.text = arrdata.categoryId.categoryName
        cell.languageLabel.text = ("\(arrdata.langCode) | \(time) | \("Eastern")")
        cell.priceLabel.text = ("$ \(arrdata.price)")
        cell.fileCountLabel.text = ("\(arrdata.fileCount) Files")
        let url = NSURL(string: arrdata.journalistId.Image)
        cell.journalistImage.sd_setImage(with: url! as URL)
        cell.keyword = arrdata.keywordName
        cell.keywordsCollectionView.reloadData()
        cell.descriptionLabel.text = arrdata.headLine
        cell.buttonBuyNow.isHidden = true
        cell.keywordsCollectionView.reloadData()
        print("id==================\(arrdata.id)")
        print("id==================\(arrdata.storyCategory)")
        
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
        
        //-----For tag Types
        if arrdata.storyCategory == "Free" {
            cell.buttonType.setTitle("Free", for: .normal)
            cell.buttonType.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
            cell.buttonType.isHidden = false
        } else if arrdata.storyCategory == "Exclusive" {
            cell.buttonType.setTitle("Exclusive", for: .normal)
            cell.buttonType.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
            cell.buttonType.isHidden = false
        } else if arrdata.storyCategory == "Shared" {
            cell.buttonType.setTitle("Shared", for: .normal)
            cell.buttonType.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
            cell.buttonType.isHidden = false
        } else if arrdata.storyCategory == "Auction" {
            cell.buttonType.setTitle("Auction", for: .normal)
            cell.buttonType.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
            cell.buttonType.isHidden = false
        } else {
            //cell.buttonType.setTitle("----", for: .normal)
            //cell.buttonType.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            cell.buttonType.isHidden = true
        }
        //-----For tag Types
        if arrdata.favouriteStatus == 1 {
            cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        } else {
            cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        
        return cell
    }
    
    @objc func buttonAddToFav(sender: UIButton){
        
        let id = allStoryList[sender.tag].storyId.id
        print("idSearch=========\(id)")
        self.AddFavoriteStory(storyId: id, header: self.currenUserLogin.mediahouseToken)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = AppStoryboard.MediaHouse.viewController(FavouriteStoryDetailMediaViewController.self)

        let arrdata = allStoryList[indexPath.row].storyId
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
        detailVC.StoryDetails = allStoryList[indexPath.row]
        detailVC.storyId = arrdata.id
        detailVC.getTextArray = arrdata.uploadTexts
        detailVC.keywords = arrdata.keywordName
        detailVC.headline = arrdata.headLine
        detailVC.favouriteStatus = arrdata.favouriteStatus
        print("id==================\(arrdata.id)")
        print("id==================\(arrdata.storyCategory)")

        self.navigationController?.pushViewController(detailVC, animated: true)

        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !scrollPage { return }
        if (allStoryList.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            geFavList(page: "\(page)", header: currenUserLogin.mediahouseToken)
        }
    }
    
}


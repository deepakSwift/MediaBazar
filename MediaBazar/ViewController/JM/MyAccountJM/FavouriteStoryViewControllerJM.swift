//
//  FavouriteStoryViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 15/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FavouriteStoryViewControllerJM: UIViewController {
    
    @IBOutlet weak var favouriteHomeTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var allStoryList = FavoriteDocModel()
    var favStoryData = AddTofavoriteModel()
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyTimeArray = [String]()
    
    var currenUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setUpUI()
        setUpButton()
        self.currenUserLogin = User.loadSavedUser()
        getFavouriteStoryData(header: currenUserLogin.token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.currenUserLogin = User.loadSavedUser()
        getFavouriteStoryData(header: currenUserLogin.token)
        
    }
    
    func setupTableView(){
        self.favouriteHomeTableView.dataSource = self
        self.favouriteHomeTableView.delegate = self
        self.favouriteHomeTableView.reloadData()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
    }
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allStoryList.docs.enumerated() {
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
    
    
    @objc func buttonAddToFav(sender: UIButton){
        
        let id = allStoryList.docs[sender.tag].id
        print("idSearch=========\(id)")
        self.AddFavoriteStory(storyId: id, header: currenUserLogin.token)
        
        
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func getFavouriteStoryData(header : String){
        Webservices.sharedInstance.getFavouriteStoryList(storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.allStoryList = somecategory
                    self.favouriteHomeTableView.reloadData()
                    //                    self.setupData()
                    self.calculateTime()
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
                    self.favouriteHomeTableView.reloadData()
                    self.getFavouriteStoryData(header: self.currenUserLogin.token)
                }
            }else{
                self.getFavouriteStoryData(header: self.currenUserLogin.token)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension FavouriteStoryViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteStoryTableViewCellJM") as! FavouriteStoryTableViewCellJM
        
        let arrdata = allStoryList.docs[indexPath.row].storyId
        let time = storyTimeArray[indexPath.row]
        cell.journalistName.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)")
        cell.journalistType.text = arrdata.journalistId.userType
        cell.categoryType.text = arrdata.categoryId.categoryName
        cell.languageLabel.text = ("\(arrdata.langCode) |\(time) | \(arrdata.country.name)")
        cell.priceLabel.text = ("\(arrdata.state.symbol) \(String(arrdata.price))")
        cell.descri.text = arrdata.headLine
        cell.fileCountLabel.text = ("\(String(arrdata.fileCount)) Files")
        cell.categoryType.text = arrdata.categoryId.categoryName
//        cell.soldoutLabel.text = ("\(String(arrdata.soldOut)) Times")
        cell.purchaseLimit.text = arrdata.purchasingLimit
        
        let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
        let url = NSURL(string: getProfileUrl)
        cell.journalistImage.sd_setImage(with: url! as URL)
        
        
        cell.keyword = arrdata.keywordName
        cell.keywordsCollectionView.reloadData()
        cell.storyTypeLabel.text = arrdata.storyCategory
        
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
        
        if arrdata.favouriteStatus == 0 {
            cell.buttonFavorite.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        } else {
            cell.buttonFavorite.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
        }
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = AppStoryboard.Stories.viewController(NewExclusiveStoryDetailViewController.self)
//
//        detailVC.favouriteData = allStoryList.docs[indexPath.row]
//        detailVC.time = storyTimeArray[indexPath.row]
//        detailVC.hideEditButton = "hide"
//
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}




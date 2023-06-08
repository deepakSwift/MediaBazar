//
//  AuctionBiddingStoryVC.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AuctionBiddingStoryVC: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewPurchaseStories: UITableView!
    
    //    var allStoryList = FavoriteDocModel()
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    var searchText = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var allStoryList = [FavoriteStroyDocsModel]()
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        setupButton()
        apiCall()
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
        getBidStoryList(page: "0", header: currenUserLogin.mediahouseToken)
    }
    
    func calculateTime() {
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
    }
    
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //-------Get All story -------
    
    func getBidStoryList(page : String,header : String){
        CommonClass.showLoader()
        WebService3.sharedInstance.bidStoryList(page: page, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    //                    self.allStoryList = somecategory
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
                    noDataLabel.text = "No bid story available."
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
}



//----TableView---
extension AuctionBiddingStoryVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuctionBiddingStoryTableViewCell", for: indexPath) as! AuctionBiddingStoryTableViewCell
        
        
        let data = allStoryList[indexPath.row]
        cell.labelTitleName.text = data.storyId.categoryId.categoryName
        cell.buttonShared.setTitle(data.storyId.storyCategory, for: .normal)
        cell.labelAddress.text = data.realPrice
        cell.labelPrice.text = "\(data.storyId.currency): \(data.storyId.biddingPurchaseAmount)"
        cell.labelSubtitle.text = data.headline
        cell.keyword = data.storyId.keywordName
        cell.collectionViewKeyWords.reloadData()
        cell.labelAddress.text = " \(data.storyId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.storyId.state.stateName)"
        
        
        if data.storyId.uploadThumbnails.count != 0 {
            let thumbnailUrl = "\(BASE_URL)\(data.storyId.uploadThumbnails[0].thumbnale)"
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !scrollPage { return }
        if (allStoryList.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            getBidStoryList(page: "\(page)", header: currenUserLogin.mediahouseToken)
        }
    }
    
    
    
}

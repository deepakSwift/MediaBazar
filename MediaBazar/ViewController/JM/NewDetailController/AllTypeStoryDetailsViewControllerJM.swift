//
//  AllTypeStoryDetailsViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 04/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


enum CellTypesDetail: String {
    case collapseCell = "collapse"
    case expandCell =  "expand"
}

struct TableCellDatasDetail {
    var open = Bool()
    var title = String()
    var sectionData = [String]()
}


class AllTypeStoryDetailsViewControllerJM: UIViewController {
    
    @IBOutlet weak var tableViewDropDwonHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewEvenDetails: UITableView!
    @IBOutlet weak var tableViewDropDwon: UITableView!
    @IBOutlet weak var fileCount: UILabel!
    @IBOutlet weak var tableViewReviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewReview: UITableView!
    @IBOutlet weak var reviewButtonConatinerView: UIView!
    @IBOutlet weak var labelReviewCount: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    
    @IBOutlet weak var labelReviewRating: UILabel!
    @IBOutlet weak var buttonAddReview: UIButton!
    @IBOutlet weak var labelReviewTableCount: UILabel!
    
    var tableViewData = [TableCellData]()
    var cellType:CellTypesDetail = .collapseCell
    //        var StoryDetails = MediaStroyModel()
//    var StoryDetails = listStory()
    var StoryDetails = [storyListModal]()
    var detailData = storyListModal()
    
    var titleDatas = ["Text","Image","Videos","Thumbnails Image","Supporting Docs", "Audio"]
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var name = ""
    var categoryType = ""
    var languageLabel = ""
    var price = ""
    var file = ""
    var imageurl = ""
    var imageThumbnail = ""
    var descriptions = ""
    var storyCategory = ""
    var favouriteStatus = 2
    var time = ""
    var storyId = ""
    var headline = ""
    var auctionBiddingPrice = ""
    
    
    var reviewCount = 0
    var getTextArray = [journalistStoryModal]()
    var keywords = [String]()
    var allReviewList = listStory()
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    
    
    var hideEditButton = ""
    var hideDeleteButton = ""
    var favouriteButon = ""
    
    var journalistID = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        
        tableViewDropDwon.tableFooterView = UIView()
        //tableViewReview.isHidden = true
        //reviewButtonConatinerView.isHidden = true
        if reviewCount == 0 {
            setupTableViewData()
            tableViewReview.isHidden = true
            reviewButtonConatinerView.isHidden = true
        } else {
            apiCall()
        }
        
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        fileCount.text = file
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnDeleteButton(){
        deleteStory(storyID: storyId, header: currenUserLogin.token)
        
    }
    
    @objc func onClickProfileButton(){
        let profileVC = AppStoryboard.Stories.viewController(ProfileDeatailsVC.self)
        profileVC.journalistIDByStory = journalistID
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    

    
    
    @objc func clickOnEditStoryButton(){
        
        if detailData.storyCategory == "Exclusive"{
            let exclusiveEditVC = AppStoryboard.Journalist.viewController(EditExclusiveStoryViewControllerJM.self)
            exclusiveEditVC.storyDetailData = detailData
            self.navigationController?.pushViewController(exclusiveEditVC, animated: true)
        } else if detailData.storyCategory == "Shared"{
            let sharedEditVC = AppStoryboard.Journalist.viewController(EditSharedStoryViewControllerJM.self)
            sharedEditVC.storyDetailData = detailData
            self.navigationController?.pushViewController(sharedEditVC, animated: true)
        } else if detailData.storyCategory == "Free"{
            let freeEditVC = AppStoryboard.Journalist.viewController(EditFreeStoryViewControllerJM.self)
            freeEditVC.storyDetailData = detailData
            self.navigationController?.pushViewController(freeEditVC, animated: true)
        } else if detailData.storyCategory == "Auction"{
            let auctionEditVC = AppStoryboard.Journalist.viewController(EditAuctionViewControllerJM.self)
            auctionEditVC.storyDetailData = detailData
            self.navigationController?.pushViewController(auctionEditVC, animated: true)
        } else {
            let blogEditVC = AppStoryboard.Journalist.viewController(EditBlogViewControllerJM.self)
            blogEditVC.storyDetailData = detailData
            self.navigationController?.pushViewController(blogEditVC, animated: true)
        }
    }
    
    
    func setupTableView() {
        //registered TableView XIB
        tableViewEvenDetails.register(UINib(nibName: "EventsDetailsTableCell", bundle: Bundle.main), forCellReuseIdentifier: "EventsDetailsTableCell")
        tableViewDropDwon.register(UINib(nibName: "StoryDeatilsDropdwonCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDeatilsDropdwonCell")
        tableViewDropDwon.register(UINib(nibName: "StoryDetailsDropdownSubTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDetailsDropdownSubTableViewCell")
        tableViewReview.register(UINib(nibName: "ReviewTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ReviewTableCell")
        tableViewDropDwon.separatorInset = UIEdgeInsets.zero
        tableViewDropDwon.separatorColor = UIColor.lightGray
        self.tableViewDropDwon.rowHeight = UITableView.automaticDimension
        self.tableViewDropDwon.estimatedRowHeight = 44.0
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //TableView Popular services resize
        self.tableViewHeight?.constant = self.tableViewEvenDetails.contentSize.height
        self.tableViewDropDwonHeight?.constant = self.tableViewDropDwon.contentSize.height
        self.tableViewReviewHeight?.constant = self.tableViewReview.contentSize.height
    }
    
    func apiCall() {
        getReviews(storyID: storyId, header: currenUserLogin.token)
    }
    
    func setupTableViewData() {
        
        var descData = [String]()
        
        for storyData in StoryDetails.enumerated(){             //for pass specific story data
            if storyData.element.id == self.storyId {
                print(storyData.element.id)
                
                for newData in titleDatas.enumerated() {
                    
                    if newData.element == "Text" {
                        descData.removeAll()
                        for subtitle in storyData.element.uploadTexts {
                            descData.append(subtitle.text)
                            print("===================\(subtitle.text)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                        
                    } else if newData.element == "Image" {
                        descData.removeAll()
                        for subtitle in storyData.element.uploadImages {
                            descData.append(subtitle.Image)
                            print("===================\(subtitle.Image)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                    } else if newData.element == "Videos" {
                        descData.removeAll()
                        for subtitle in storyData.element.uploadVideos {
                            descData.append(subtitle.video)
                            print("===================\(subtitle.Image)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                    } else if newData.element == "Thumbnails Image" {
                        descData.removeAll()
                        for subtitle in storyData.element.uploadThumbnails {
                            descData.append(subtitle.thumbnale)
                            print("===================\(subtitle.thumbnale)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                    } else if newData.element == "Supporting Docs" {
                        descData.removeAll()
                        for subtitle in storyData.element.supportingDocs {
                            descData.append(subtitle.doc)
                            print("===================\(subtitle.Image)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                    } else if newData.element == "Audio" {
                        descData.removeAll()
                        for subtitle in storyData.element.uploadAudios {
                            descData.append(subtitle.audio)
                            print("===================\(subtitle.audio)")
                        }
                        if descData.count == 0 {
                            
                        } else {
                            let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
                            tableViewData.append(contentsOf: cell)
                        }
                    }
                }
            }
        }
        self.tableViewDropDwon.reloadData()
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allReviewList.docs.enumerated() {
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
    
    
    func getReviews(storyID : String, header : String){
        Webservices.sharedInstance.getReviewByStoryID(storyId: storyID, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.allReviewList = somecategory
                    
                    if self.allReviewList.docs.count == 0 {
                        self.setupTableViewData()
                        self.tableViewReview.isHidden = true
                        self.reviewButtonConatinerView.isHidden = true
                    } else {
                        self.calculateTime()
                        self.labelReviewTableCount.text = "Reviews (\(self.allReviewList.docs.count))"
                        self.tableViewReview.reloadData()
                        self.setupTableViewData()
                    }
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func deleteStory(storyID: String, header: String){
        Webservices.sharedInstance.deleteStory(storyId: storyID, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                self.tableViewEvenDetails.reloadData()
                let myStoryVC = AppStoryboard.Journalist.viewController(MyStoriesViewControllerJM.self)
                self.navigationController?.pushViewController(myStoryVC, animated: true)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    
    
    
    
}

// -----TableView------
extension AllTypeStoryDetailsViewControllerJM: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewEvenDetails {
            return 1
        } else if tableView == tableViewDropDwon {
            return tableViewData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewEvenDetails {
            return 1
        } else if tableView == tableViewDropDwon {
            if tableViewData[section].open == true {
                return tableViewData[section].sectionData.count + 1
            } else {
                return 1
            }
        } else {
            return allReviewList.docs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewEvenDetails {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventsDetailsTableCell", for: indexPath) as! EventsDetailsTableCell
                
                
                
                if hideEditButton == "hide"{
                    cell.editButton.isHidden = true
                } else{
                    cell.editButton.isHidden = false
                }
                
                if hideDeleteButton == "hide"{
                    cell.deleteButton.isHidden = true
                } else {
                    cell.deleteButton.isHidden = false
                }
                
                if favouriteButon == "hide"{
                    cell.buttonHeart.isHidden = true
                }else {
                    cell.buttonHeart.isHidden = false
                }
                
                
               cell.labelProfileName.text = name
                cell.labelEventName.text = headline
                cell.labelTime.text = time
                // cell.labelPriceRete.text = price
                cell.labelTechnology.text = categoryType
             
                //cell.storyCategoryLabel.text = storyCategory
//                cell.keyword = self.keywords
                
                var allKeywords = self.keywords
                allKeywords.append("")
                cell.keyword = allKeywords
                
                cell.labelDetails.text = descriptions
                cell.keywordCollectionView.reloadData()
                
                cell.editButton.addTarget(self, action: #selector(clickOnEditStoryButton), for: .touchUpInside)
                cell.deleteButton.addTarget(self, action: #selector(clickOnDeleteButton), for: .touchUpInside)
                
                if let profileUrls = NSURL(string: (imageThumbnail)) {
                    cell.thumbnailImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                }
                if let profileUrls = NSURL(string: (imageurl)) {
                    cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                }
                
                cell.profileButton.addTarget(self, action: #selector(onClickProfileButton), for: .touchUpInside)
                
                //-----For tag Types
                if storyCategory == "Free" {
                    cell.storyCategoryLabel.isHidden = true
                    cell.buttonBuyNow.isHidden = true
                    cell.labelPriceRete.isHidden = true
                     cell.biddingView.isHidden = true
                } else if storyCategory == "Exclusive" {
                    cell.storyCategoryLabel.text = "Exclusive"
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = true
                    cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                    cell.labelPriceRete.text = price
                     cell.biddingView.isHidden = true
                } else if storyCategory == "Shared" {
                    cell.storyCategoryLabel.text = "Shared"
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = true
                    cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                    cell.labelPriceRete.text = price
                     cell.biddingView.isHidden = true
                } else if storyCategory == "Auction" {
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                    cell.storyCategoryLabel.text = "Auction"
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = true
                    cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                   // cell.labelSoldOut.text = file
                    cell.labelPriceRete.text = auctionBiddingPrice
                     cell.biddingView.isHidden = true
                } else {
                    //cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    //cell.storyCategoryLabel.text = "---"
                    cell.storyCategoryLabel.isHidden = true
                    cell.buttonBuyNow.isHidden = true
                    cell.labelPriceRete.isHidden = true
                     cell.biddingView.isHidden = true
                }
                
                //-----For tag Types
                if favouriteStatus == 1 {
                    cell.buttonHeart.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                } else {
                    cell.buttonHeart.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
                }
                
                return cell
            }
        } else if tableView == tableViewDropDwon {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StoryDeatilsDropdwonCell", for: indexPath) as! StoryDeatilsDropdwonCell
                cell.titlelbl.text = tableViewData[indexPath.section].title
                
                if cellType == .expandCell {
                    cell.DropBtn.setImage(#imageLiteral(resourceName: "Vector"), for: .normal)
                } else if cellType == .collapseCell {
                    cell.DropBtn.setImage(#imageLiteral(resourceName: "right-thin-chevron"), for: .normal)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StoryDetailsDropdownSubTableViewCell", for: indexPath) as!  StoryDetailsDropdownSubTableViewCell
                cell.subtitlelbl.text = tableViewData[indexPath.section].sectionData[indexPath.row-1]
                
                return cell
            }
            
        }else if tableView == tableViewReview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! ReviewTableCell
            
            
            let arrdata = allReviewList.docs[indexPath.row]
            
            let time = storyTimeArray[indexPath.row]
            cell.labelName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.lastName)")
            cell.labelTime.text = ("\(arrdata.langCode) | \(time) | \(arrdata.mediaHouseID.state.stateName)")
            cell.labelDetails.text = arrdata.mediahouseComment
            cell.labelRating.text = String(arrdata.averageRating)
            
            let getlogoUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
            let logoUrl = NSURL(string: getlogoUrl)
            cell.imageViewProfile.sd_setImage(with: logoUrl! as URL)
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewEvenDetails {
            
        } else {
            if tableViewData[indexPath.section].open == true{
                tableViewData[indexPath.section].open = false
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
                cellType = .expandCell
            } else {
                tableViewData[indexPath.section].open = true
                let section = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(section, with: .none)
                cellType = .collapseCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    //
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if tableView == tableViewReview {
    //            return 100
    //        } else {
    //            return UITableView.automaticDimension
    //        }
    //    }
    
}



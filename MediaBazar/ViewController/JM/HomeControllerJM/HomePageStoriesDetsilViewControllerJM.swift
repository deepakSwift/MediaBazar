//
//  HomePageStoriesDetsilViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class HomePageStoriesDetsilViewControllerJM: UIViewController {
    
    @IBOutlet weak var detailTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    
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
    var totalAverageRatting = 0
    var getTextArray = [journalistStoryModal]()
    var keywords = [String]()
    var allReviewList = listStory()
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    
    
    var hideEditButton = ""
    var hideDeleteButton = ""
    var favouriteButon = ""
    
    var journalistID = ""
    
    var StoryDetails = [storyListModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setUpTableView()
        setupButton()
        setUpUI()
        apiCall()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.detailTableView.bounces = false
        self.detailTableView.alwaysBounceVertical = false
        self.detailTableView.rowHeight = UITableView.automaticDimension
        self.detailTableView.estimatedRowHeight = 1000
        self.detailTableView.reloadData()
    }
    
    func apiCall() {
        getReviews(storyID: storyId, header: currenUserLogin.token)
    }

    func setUpUI(){
        detailTableView.makeBorder(0.5, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
    }
    
    func setupButton() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickProfileButton(){
        let journalistProfileVC = AppStoryboard.Journalist.viewController(ProfileDeatailsVC.self)
        journalistProfileVC.journalistIDByStory = journalistID
        self.navigationController?.pushViewController(journalistProfileVC, animated: true)
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
                    self.detailTableView.reloadData()
                    self.calculateTime()
//                    if self.allReviewList.docs.count == 0 {
//                        self.detailTableView.reloadData()
//                        self.calculateTime()
////                        self.setupTableViewData()
////                        self.tableViewReview.isHidden = true
////                        self.reviewButtonConatinerView.isHidden = true
//                    }else {
//
//                    }
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    
    
}

extension HomePageStoriesDetsilViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else {
            return allReviewList.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageStoryDetailTableViewCellJM") as! HomePageStoryDetailTableViewCellJM
            
            cell.journalistName.text = name
            cell.headlineLabel.text = headline
            cell.langTimeStateLabel.text = time
            cell.authorName.text = name
            cell.storyCategoryLabel.text = categoryType
            var allKeywords = self.keywords
            allKeywords.append("")
            cell.keyword = allKeywords
            
            cell.storyDescription.text = descriptions
            
            cell.reviewCount.text = "Reviews (\(reviewCount))"
            cell.totalAverageReviewRatting.text = String(totalAverageRatting)
            cell.keywordCollectionView.reloadData()
            
            if reviewCount == 0{
                cell.reviewView.isHidden = true
            }else {
                cell.reviewView.isHidden = false
            }
            
            if let profileUrls = NSURL(string: (imageThumbnail)) {
                cell.storyTumbnailImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            if let profileUrls = NSURL(string: (imageurl)) {
                cell.profileImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            cell.profileButton.addTarget(self, action: #selector(onClickProfileButton), for: .touchUpInside)

            
            //-----For tag Types
            if storyCategory == "Free" {
                cell.storyTypeLabel.text = "Free"
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                cell.storyTypeLabel.isHidden = false
                //            cell.buttonBuyNow.isHidden = true
                cell.labelPriceRete.isHidden = true
                //            cell.biddingView.isHidden = true
            } else if storyCategory == "Exclusive" {
                cell.storyTypeLabel.text = "Exclusive"
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.storyTypeLabel.isHidden = false
                //            cell.buttonBuyNow.isHidden = true
                //            cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.labelPriceRete.isHidden = false
                cell.labelPriceRete.text = price
                //            cell.biddingView.isHidden = true
            } else if storyCategory == "Shared" {
                cell.storyTypeLabel.text = "Shared"
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.storyTypeLabel.isHidden = false
                //            cell.buttonBuyNow.isHidden = true
                //            cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                cell.labelPriceRete.isHidden = false
                cell.labelPriceRete.text = price
                //            cell.biddingView.isHidden = true
            } else if storyCategory == "Auction" {
                cell.storyTypeLabel.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.storyTypeLabel.text = "Auction"
                cell.storyTypeLabel.isHidden = false
                //            cell.buttonBuyNow.isHidden = true
                //            cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                cell.labelPriceRete.isHidden = false
                //            // cell.labelSoldOut.text = file
                cell.labelPriceRete.text = auctionBiddingPrice
                //            cell.biddingView.isHidden = true
            } else {
                //cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                //cell.storyCategoryLabel.text = "---"
                cell.storyTypeLabel.isHidden = true
                //            cell.buttonBuyNow.isHidden = true
                cell.labelPriceRete.isHidden = true
                
                //            cell.biddingView.isHidden = true
            }
            
            //-----For tag Types
            if favouriteStatus == 1 {
                cell.buttonHeart.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            } else {
                cell.buttonHeart.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
            }
            
            return cell
            
        }else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageJournalistReviewTableViewCellJM") as! HomePageJournalistReviewTableViewCellJM
            
            let arrdata = allReviewList.docs[indexPath.row]
            
            let time = storyTimeArray[indexPath.row]
            cell.labelName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.lastName)")
            cell.labelTime.text = ("\(arrdata.mediaHouseID.langCode) | \(time) | \(arrdata.mediaHouseID.state.stateName)")
            cell.labelDetails.text = arrdata.mediahouseComment
            cell.labelRating.text = String(arrdata.averageRating)
            
            let getlogoUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
            let logoUrl = NSURL(string: getlogoUrl)
            cell.imageViewProfile.sd_setImage(with: logoUrl! as URL)

            return cell
        }

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
        }

    
}

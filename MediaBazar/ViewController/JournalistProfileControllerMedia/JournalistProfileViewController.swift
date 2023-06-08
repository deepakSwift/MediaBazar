//
//  JournalistProfileViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 10/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var journalistName : UILabel!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var profileData = profileModal()
    var myAssignmentData = [storyListModal]()
    var storyList = [MediaStroyDocsModel]()
    
    var journalistIDByStory = ""
    var currentUserLogin : User!
    
    var targetAudiance = [String]()
    var areaOfInterest = [String]()
    var storyTimeArray = [String]()
    var totalAssignment = 0
    var totalStory = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setUpTableView()
        setupButton()
        
        getProfileData(journalistID: journalistIDByStory, header: currentUserLogin.mediahouseToken)
        getAssignmentData(journalistID: journalistIDByStory, page: "0", header: currentUserLogin.mediahouseToken)
        getAllStoryData(page: "0", journalistID: journalistIDByStory, header: currentUserLogin.mediahouseToken)
        
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.profileTableView.dataSource = self
        self.profileTableView.delegate = self
        self.profileTableView.bounces = false
        self.profileTableView.alwaysBounceVertical = false
        self.profileTableView.rowHeight = UITableView.automaticDimension
        self.profileTableView.estimatedRowHeight = 1000
        
    }
    
    func setupButton() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    
    func setUpData(){
        
        for data in profileData.targetAudience.enumerated(){
            let tempData = data.element.name
            targetAudiance.append(tempData)
            print("=============\(targetAudiance)")
            
        }
        
        for data in profileData.areaOfInterest.enumerated(){
            let tempData = data.element.categoryName
            areaOfInterest.append(tempData)
            print("=============\(areaOfInterest)")
        }
        
        
    }
    
    func calculateTime() {
        
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
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickFaceBookButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.facebookLink = profileData.facebookLink
        mediaLinkVC.socialLink = "facebook"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickLinkedInButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.linkedInLink = profileData.linkedinLink
        mediaLinkVC.socialLink = "linkedIn"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickTwitterButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.twitterLink = profileData.twitterLink
        mediaLinkVC.socialLink = "twitter"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickYouTubeButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.youTubeLink = profileData.youtubeLink
        mediaLinkVC.socialLink = "youtube"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickInstgramButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.instagramlink = profileData.instagramLink
        mediaLinkVC.socialLink = "instagram"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickSnapChatButton(){
        let mediaLinkVC = AppStoryboard.Journalist.viewController(JournalistSocialLinkViewController.self)
        mediaLinkVC.snapChatLink = profileData.snapChatLink
        mediaLinkVC.socialLink = "snapchat"
        self.navigationController?.pushViewController(mediaLinkVC, animated: true)
    }
    
    @objc func onClickMoreStoryButton(){
        let storiesVC = AppStoryboard.Journalist.viewController(JournalistStoryListByIDViewController.self)
        storiesVC.jornalistID = journalistIDByStory
        self.navigationController?.pushViewController(storiesVC, animated: true)
    }
    
    @objc func onClickMoreAssignmentButton(){
        let assignementVC = AppStoryboard.Journalist.viewController(JournalistAssignmentByIDViewController.self)
        assignementVC.assignment = myAssignmentData
        self.navigationController?.pushViewController(assignementVC, animated: true)
    }

    
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func getProfileData(journalistID : String, header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.getMediaHouseJournalistDataByStory(journalistID: journalistID, header: header){(result,message,response)  in
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory = response {
                    self.profileData = somecategory
                    self.setUpData()
                    self.profileTableView.reloadData()
                    print("profileData=======\(somecategory)")
                }
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getAssignmentData(journalistID : String, page : String ,header: String){
        Webservices.sharedInstance.getMediaAssignmentByJournalistID(journalistID: journalistID, page: page, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.myAssignmentData.append(contentsOf: somecategory.docs)
                    self.profileTableView.reloadData()
                    self.totalAssignment = somecategory.total
                    //                        self.calculateTime()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //-------Get All story -------
    func getAllStoryData(page : String,journalistID : String, header : String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getStoryListByJournalistID(journalistID: journalistID, page: page, storyHeader: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.storyList.append(contentsOf: somecategory.docs)
                    self.profileTableView.reloadData()
                    self.calculateTime()
                    self.totalStory = somecategory.total
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension JournalistProfileViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        } else if section == 1{
            return myAssignmentData.count
        } else if section == 2{
            return 1
        }else {
            return storyList.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistProfileTableViewCell") as! JournalistProfileTableViewCell
            
            if profileData.profilePic != ""{
                let profilePic = "\(self.baseUrl)\(profileData.profilePic)"
                let profileUrls = NSURL(string: profilePic)
                if let tempProfileUrls = profileUrls{
                    cell.profileImage.sd_setImage(with: tempProfileUrls as URL, placeholderImage: #imageLiteral(resourceName: "Group 3009"))
                    
                }
            }
            
            //            if profileData.shortVideo != ""{
            let imageVideo = "\(self.baseUrl)\(profileData.shortVideo)"
            let strWithNoSpace = imageVideo.replacingOccurrences(of: " ", with: "%20")
            let url1 = NSURL(string: strWithNoSpace)
            if let thumbnailImage = getThumbnailImage(forUrl: url1 as! URL) {
                cell.profileVideo.image = thumbnailImage
            }
            
            //            }
            cell.averageRateingLabel.text = String(profileData.totalAveargeReview)
            cell.nameLabel.text = ("\(profileData.firstName) \(profileData.middleName) \(profileData.lastName)")
            cell.userTypeLabel.text = profileData.userType
            cell.lastNameLabel.text = profileData.lastName
            cell.locationLabel.text = "\(profileData.country.currencyName) | \(profileData.state.stateName)(\(profileData.pinCode))"
            cell.storyDescri.text = profileData.shortBio
            cell.targetAudienceLAbel.text = targetAudiance.joined(separator: ", " )
            cell.areaOfInterestLabel.text = areaOfInterest.joined(separator: ", " )
            
            cell.totalAssignment.text = "Assignment(\(totalAssignment))"
            
            
            if profileData.facebookLink == ""{
                cell.faceBookButton.isHidden = true
            }else {
                cell.faceBookButton.isHidden = false
                cell.faceBookButton.addTarget(self, action: #selector(onClickFaceBookButton), for: .touchUpInside)
            }
            
            if profileData.linkedinLink == ""{
                cell.linkedInButton.isHidden = true
            }else {
                cell.linkedInButton.isHidden = false
                cell.linkedInButton.addTarget(self, action: #selector(onClickLinkedInButton), for: .touchUpInside)
            }
            
            if profileData.twitterLink == ""{
                cell.twitterButton.isHidden = true
            }else {
                cell.twitterButton.isHidden = false
                cell.twitterButton.addTarget(self, action: #selector(onClickTwitterButton), for: .touchUpInside)
            }
            
            if profileData.snapChatLink == ""{
                cell.snapchatButton.isHidden = true
            }else {
                cell.snapchatButton.isHidden = false
                cell.snapchatButton.addTarget(self, action: #selector(onClickSnapChatButton), for: .touchUpInside)
            }
            
            if profileData.youtubeLink == ""{
                cell.youtubeButton.isHidden = true
            }else {
                cell.youtubeButton.isHidden = false
                cell.youtubeButton.addTarget(self, action: #selector(onClickYouTubeButton), for: .touchUpInside)
            }
            
            if profileData.instagramLink == ""{
                cell.instagramButton.isHidden = true
            }else {
                cell.instagramButton.isHidden = false
                cell.instagramButton.addTarget(self, action: #selector(onClickInstgramButton), for: .touchUpInside)
            }

            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistAssignmentTableViewCell") as! JournalistAssignmentTableViewCell
            
            cell.countLabel.text = "\(indexPath.row + 1)."
            let arrData = myAssignmentData[indexPath.row]
            cell.headLineLabel.text = arrData.assignmentHeadline
            cell.brifDescri.text = arrData.assignmentDesc
            cell.dateLabel.text = "\(arrData.date) | \(arrData.time) | \(arrData.country.name)"
            
            var allKeywords = arrData.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if indexPath.row == 2{
                cell.seeMoreButton.isHidden = false
            }else {
                cell.seeMoreButton.isHidden = true
            }
            
            cell.seeMoreButton.addTarget(self, action: #selector(onClickMoreAssignmentButton), for: .touchUpInside)
            
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistStoryHeadingTableViewCell") as! JournalistStoryHeadingTableViewCell
            cell.totalStoryLabel.text = "Stories(\(totalStory))"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistStoriesTableViewCell") as! JournalistStoriesTableViewCell
            
            let arrdata = storyList[indexPath.row]
            let time = storyTimeArray[indexPath.row]
            cell.categoryTypeLAbel.text = arrdata.categoryId.categoryName
            cell.langTimeStateLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
            cell.headlineLabel.text = arrdata.headLine
            
            if indexPath.row == 2{
                cell.seeMoreButton.isHidden = false
            }else {
                cell.seeMoreButton.isHidden = true
            }
            
            cell.seeMoreButton.addTarget(self, action: #selector(onClickMoreStoryButton), for: .touchUpInside)
            
            if arrdata.uploadThumbnails.count != 0 {
                let thumbnailUrl = "\(self.baseUrl)\(arrdata.uploadThumbnails[0].thumbnale)"
                let urls = NSURL(string: (thumbnailUrl))
                if let tempUrl = urls {
                    cell.thumbnailImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "bank"))
                }
            }
            
            var allKeywords = arrdata.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            //-----For tag Types
            if arrdata.storyCategory == "Free" {
                cell.storyTypeButton.setTitle("Free", for: .normal)
                cell.storyTypeButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3843137255, blue: 0.8588235294, alpha: 1)
                cell.storyTypeButton.isHidden = false
                cell.priceLabel.text = "Free"
                
            } else if arrdata.storyCategory == "Exclusive" {
                cell.storyTypeButton.setTitle("Exclusive", for: .normal)
                cell.storyTypeButton.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                cell.storyTypeButton.isHidden = false
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price)")
                
            } else if arrdata.storyCategory == "Shared" {
                cell.storyTypeButton.setTitle("Shared", for: .normal)
                cell.storyTypeButton.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                cell.storyTypeButton.isHidden = false
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.price)")
            } else if arrdata.storyCategory == "Auction" {
                cell.storyTypeButton.setTitle("Auction", for: .normal)
                cell.storyTypeButton.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                cell.storyTypeButton.isHidden = false
                cell.priceLabel.text = ("\(arrdata.currency)\(arrdata.auctionBiddingPrice)")
                
                //                let leftTime = arrdata.auctionExpriyTime
                //                let NewLeftTime = Int(leftTime)!
                //                //Convert to Date
                //                let date = NSDate(timeIntervalSince1970: TimeInterval(NewLeftTime))
                //                //Date formatting
                //                let dateFormatter = DateFormatter()
                //                dateFormatter.dateFormat = "HH:mm:ss"
                //                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                //                let dateString = dateFormatter.string(from: date as Date)
                //                print("formatted date is = \(dateString)")
                //                cell.timeLeftlabel.text = dateString
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
        }else if indexPath.section == 1{
            
        }else if indexPath.section == 2{
            
        }else {
            
        }
    }
    
    
}

//
//  NewExclusiveStoryDetailViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


class NewExclusiveStoryDetailViewController: UIViewController {
    
    @IBOutlet weak var exclusiveTableView : UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var detailData = storyListModal()
    var reviewData = listStory()
    var favouriteData = FavoriteDocModel()
    var thumbnailImage = ""
    var textUrl = ""
    var imageUrl = ""
    var thumbnailUrl = ""
    var videoUrl = ""
    var supportingTextUrl = ""
    var audioUrl = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var time = ""
    
    var storyID = ""
    var storyTimeArray = [String]()
    var currentUserLogin : User!
    
    var totalNoReview = ""
    
    var hideEditButton = ""
    var hideDeleteButton = ""
    var favouriteButon = ""
    
    let headerData = ["","Test","Image","Video","Thumbnail Image","Supporting Document","Audio", "",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpButton()
        //        setupData()
        self.currentUserLogin = User.loadSavedUser()
        getReviewByStoryID(storyID: storyID, header: currentUserLogin.token)
        
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.exclusiveTableView.dataSource = self
        self.exclusiveTableView.delegate = self
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
    }
    
    func setupData() {
        
        for data in detailData.uploadThumbnails.enumerated() {
            let tempData = data.element.thumbnale
            thumbnailImage = tempData
        }
        
        for data1 in detailData.uploadTexts.enumerated() {
            let tempData = data1.element.text
            textUrl = tempData
        }
        
        for data2 in detailData.uploadImages.enumerated() {
            let tempData = data2.element.Image
            imageUrl = tempData
        }
        
        for data3 in detailData.uploadThumbnails.enumerated() {
            let tempData = data3.element.thumbnale
            thumbnailUrl = tempData
        }
        
        for data4 in detailData.uploadVideos.enumerated() {
            let tempData = data4.element.video
            videoUrl = tempData
        }
        
        for data5 in detailData.supportingDocs.enumerated() {
            let tempData = data5.element.doc
            supportingTextUrl = tempData
        }
        
        for data6 in detailData.uploadAudios.enumerated() {
            let tempData = data6.element.audio
            audioUrl = tempData
        }
        
        
        
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in reviewData.docs.enumerated() {
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
    
    
    
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buyNowbuttonPreesed() {
        let buyEventVC = self.storyboard?.instantiateViewController(withIdentifier: "BuyExclusiveEventsVC") as! BuyExclusiveEventsVC
        self.navigationController?.pushViewController(buyEventVC, animated: true)
    }
    
    @objc func nameButtonPressed(){
        let ProfileDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDeatailsVC") as! ProfileDeatailsVC
        ProfileDetailVC.journalistIDByStory = detailData.journalistId.id
        self.navigationController?.pushViewController(ProfileDetailVC, animated: true)
    }
    
    @objc func clickOnDeleteButton(){
        deleteStory(storyID: storyID, header: currentUserLogin.token)
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
    
    
    func getReviewByStoryID(storyID : String, header : String){
        Webservices.sharedInstance.getReviewByStoryID(storyId: storyID, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.reviewData = somecategory
                    self.exclusiveTableView.reloadData()
                    self.setupData()
                    self.calculateTime()
                    print("somecategory==============\(somecategory)")
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
                self.exclusiveTableView.reloadData()
                let myStoryVC = AppStoryboard.Journalist.viewController(MyStoriesViewControllerJM.self)
                self.navigationController?.pushViewController(myStoryVC, animated: true)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    
    
}

extension NewExclusiveStoryDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 7{
            if detailData.storyCategory == "Free"{
                return 1
            }else if detailData.storyCategory == ""{
                return 1
            } else {
                return 0
            }
        } else if section == 8{
            return reviewData.docs.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveFirstTableViewCell", for: indexPath) as! ExclusiveFirstTableViewCell
            
            
            if hideEditButton == "hide"{
                cell.buttonEdit.isHidden = true
            } else{
                cell.buttonEdit.isHidden = false
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
            
            if detailData.storyCategory == "Exclusive"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                cell.labelPriceRete.isHidden = false
                cell.labelSoldOut.isHidden = true
                cell.soldOutHeadlineLabel.isHidden = true
            } else if detailData.storyCategory == "Shared"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.labelPriceRete.isHidden = false
                cell.labelSoldOut.isHidden = false
                cell.soldOutHeadlineLabel.isHidden = false
            } else if detailData.storyCategory == "Free"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                cell.labelPriceRete.isHidden = true
                cell.labelSoldOut.isHidden = true
                cell.soldOutHeadlineLabel.isHidden = true
            } else if detailData.storyCategory == "Auction"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                cell.labelPriceRete.isHidden = false
                cell.labelSoldOut.isHidden = true
                cell.soldOutHeadlineLabel.isHidden = true
            } else {
                cell.storyCategoryLabel.isHidden = true
                cell.labelPriceRete.isHidden = true
                cell.labelSoldOut.isHidden = true
                cell.soldOutHeadlineLabel.isHidden = true
            }
            
            cell.buttonBuyNow.isHidden = true
            // cell.labelSoldOut.isHidden = true
            //   cell.soldOutHeadlineLabel.isHidden = true
            
            cell.buttonMessage.isHidden = true
            cell.buttonHeart.isHidden = false
            cell.buttonShare.isHidden = true
            cell.buttonName.addTarget(self, action: #selector(nameButtonPressed), for: .touchUpInside)
            cell.buttonBuyNow.addTarget(self, action: #selector(buyNowbuttonPreesed), for: .touchUpInside)
            cell.buttonEdit.addTarget(self, action: #selector(clickOnEditStoryButton), for: .touchUpInside)
            cell.labelProfileName.text = ("\(detailData.journalistId.firstName) \(detailData.journalistId.lastName)")
            cell.labelEventName.text = detailData.headLine
            cell.labelTechnology.text = detailData.storyCategory
            cell.labelTime.text = ("\(detailData.langCode) | \(self.time) | \(detailData.country.currencyName)")
            cell.labelPriceRete.text = ("\(detailData.realCurrencyCode)\(String(detailData.realPrice))")
            cell.storyCategoryLabel.text = detailData.storyCategory
            cell.labelSoldOut.text = detailData.purchasingLimit
            cell.fileCount.text = String("\(detailData.fileCount) Files")
            
            let getProfileUrl = "\(self.baseUrl)\(detailData.journalistId.profilePic)"
            let profileUrl = NSURL(string: getProfileUrl)
            cell.imageViewSetImg.sd_setImage(with: profileUrl! as URL)
            
            let getthumbnail = "\(self.baseUrl)\(thumbnailImage)"
            let url = NSURL(string: getthumbnail)
            cell.thumbnailImage.sd_setImage(with: url! as URL)
            cell.labelDescription.text = detailData.briefDescription
            
            cell.keyword = detailData.keywordName
            cell.keywordCollectionView.reloadData()
            
            
            cell.deleteButton.addTarget(self, action: #selector(clickOnDeleteButton), for: .touchUpInside)
            
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveTextTableViewCell") as! ExclusiveTextTableViewCell
            cell.textUrlLabel.text = textUrl
            return cell
        } else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveImageTableViewCell") as! ExclusiveImageTableViewCell
            cell.imageUrlLabel.text = imageUrl
            return cell
        }  else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveVideoTableViewCell") as! ExclusiveVideoTableViewCell
            cell.videoUrlLabel.text = videoUrl
            return cell
        } else if indexPath.section == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExcluxiveThumbnailTableViewCell") as! ExcluxiveThumbnailTableViewCell
            cell.thumbnailImageUrlLabel.text = thumbnailUrl
            return cell
        }else if indexPath.section == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveSupportingDeviceTableViewCell") as! ExclusiveSupportingDeviceTableViewCell
            cell.supportinTextUrlLabel.text = supportingTextUrl
            return cell
        }else if indexPath.section == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExclusiveAudioTableViewCell") as! ExclusiveAudioTableViewCell
            cell.audioUrlLabel.text = audioUrl
            return cell
        }else if indexPath.section == 7{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewHeadingTableViewCell") as! ReviewHeadingTableViewCell
            cell.rattingLabel.text = String(detailData.totalAveargeReview)
            cell.noOfReviewLabel.text = ("| Reviews (\(detailData.reviewCount))")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell") as! ReviewsTableViewCell
            let arrdata = reviewData.docs[indexPath.row]
            
            if detailData.storyCategory == "Free"{
                let time = storyTimeArray[indexPath.row]
                cell.nameLabel.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.lastName)")
                cell.timeLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.mediaHouseID.state.stateName)")
                cell.reviewDetail.text = arrdata.mediahouseComment
                cell.rattingLabel.text = String(arrdata.averageRating)
                
                let getlogoUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
                let logoUrl = NSURL(string: getlogoUrl)
                cell.reviewImage.sd_setImage(with: logoUrl! as URL)
            } else if detailData.storyCategory == ""{
                let time = storyTimeArray[indexPath.row]
                cell.nameLabel.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.lastName)")
                cell.timeLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.mediaHouseID.state.stateName)")
                cell.reviewDetail.text = arrdata.mediahouseComment
                cell.rattingLabel.text = String(arrdata.averageRating)
                
                let getlogoUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
                let logoUrl = NSURL(string: getlogoUrl)
                cell.reviewImage.sd_setImage(with: logoUrl! as URL)
            } else {
                cell.nameLabel.isHidden = true
                cell.timeLabel.isHidden = true
                cell.reviewDetail.isHidden = true
                cell.reviewDetail.isHidden = true
                cell.reviewImage.isHidden = true
                cell.rattingLabel.isHidden = true
                
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return UITableView.automaticDimension
        }else if indexPath.section == 1{
            if textUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }else if indexPath.section == 2{
            if imageUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }else if indexPath.section == 3{
            if videoUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }else if indexPath.section == 4{
            if thumbnailUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }else if indexPath.section == 5{
            if supportingTextUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }else if indexPath.section == 6{
            if audioUrl == ""{
                return 0
            }else{
                return UITableView.automaticDimension
            }
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        } else if section == 7{
            return 0
        } else if section == 8{
            return 0
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.headerData[section]
    }
    
}

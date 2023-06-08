//
//  PurchaseStoryDetailsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 20/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

//enum expandCellTypes: String {
//    case collapseCell = "collapse"
//    case expandCell =  "expand"
//}
//
//struct TableCellFillData {
//    var open = Bool()
//    var title = String()
//    var sectionData = [String]()
//}
//
//class PurchaseStoryDetailsVC: UIViewController {
//
//    @IBOutlet weak var tableViewDropDwonHeight: NSLayoutConstraint!
//    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
//    @IBOutlet weak var buttonBack: UIButton!
//    @IBOutlet weak var tableViewEvenDetails: UITableView!
//    @IBOutlet weak var tableViewDropDwon: UITableView!
//    @IBOutlet weak var fileCount: UILabel!
//
//    var tableViewData = [TableCellData]()
//    var cellType:expandCellTypes = .collapseCell
//    var StoryDetails = FavoriteDocModel()
//    var titleDatas = ["Text","Image","Videos","Thumbnails Image","Supporting Docs", "Audio"]
//    var baseUrl = "https://apimediaprod.5wh.com/"
//
//    var name = ""
//    var categoryType = ""
//    var languageLabel = ""
//    var price = ""
//    var file = ""
//    var imageurl = ""
//    var imageThumbnail = ""
//    var descriptions = ""
//    var storyCategory = ""
//    var favouriteStatus = 2
//    var time = ""
//    var storyId = ""
//    var headline = ""
//    var currency = ""
//    var getTextArray = [journalistStoryModal]()
//    var keywords = [String]()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableViewData()
//        setupUI()
//        setupButton()
//        setupTableView()
//        tableViewDropDwon.tableFooterView = UIView()
//    }
//
//    func setupUI() {
//        tabBarController?.tabBar.isHidden = true
//        fileCount.text = file
//    }
//
//    func setupButton() {
//        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
//    }
//
//    @objc func backButtonPressed() {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func setupTableView() {
//        //registered TableView XIB
//        tableViewEvenDetails.register(UINib(nibName: "PurchaseStoryDetailTableCell", bundle: Bundle.main), forCellReuseIdentifier: "PurchaseStoryDetailTableCell")
//        tableViewDropDwon.register(UINib(nibName: "StoryDeatilsDropdwonCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDeatilsDropdwonCell")
//        tableViewDropDwon.register(UINib(nibName: "StoryDetailsDropdownSubTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDetailsDropdownSubTableViewCell")
//        tableViewDropDwon.separatorInset = UIEdgeInsets.zero
//        tableViewDropDwon.separatorColor = UIColor.lightGray
//        self.tableViewDropDwon.rowHeight = UITableView.automaticDimension
//        self.tableViewDropDwon.estimatedRowHeight = 44.0
//    }
//
//    override func viewWillLayoutSubviews() {
//           super.updateViewConstraints()
//           //TableView Popular services resize
//        self.tableViewHeight?.constant = self.tableViewEvenDetails.contentSize.height
//           self.tableViewDropDwonHeight?.constant = self.tableViewDropDwon.contentSize.height
//       }
//
//    func setupTableViewData() {
//
//        var descData = [String]()
//
//        for storyData in StoryDetails.docs.enumerated(){             //for pass specific story data
//            if storyData.element.id == self.storyId {
//               print(storyData.element.id)
//
//                for newData in titleDatas.enumerated() {
//
//                    if newData.element == "Text" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.uploadTexts {
//                            descData.append(subtitle.text)
//                            print("===================\(subtitle.text)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    } else if newData.element == "Image" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.uploadImages {
//                            descData.append(subtitle.Image)
//                            print("===================\(subtitle.Image)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    } else if newData.element == "Videos" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.uploadVideos {
//                            descData.append(subtitle.video)
//                            print("===================\(subtitle.video)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    } else if newData.element == "Thumbnails Image" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.uploadThumbnails {
//                            descData.append(subtitle.thumbnale)
//                            print("===================\(subtitle.thumbnale)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    } else if newData.element == "Supporting Docs" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.supportingDocs {
//                            descData.append(subtitle.doc)
//                            print("===================\(subtitle.Image)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    } else if newData.element == "Audio" {
//                        descData.removeAll()
//                        for subtitle in storyData.element.storyId.uploadAudios {
//                            descData.append(subtitle.audio)
//                            print("===================\(subtitle.audio)")
//                        }
//                        let cell = [TableCellData(open: false, title: newData.element, sectionData: descData)]
//                        tableViewData.append(contentsOf: cell)
//                    }
//                }
//            }
//        }
//        self.tableViewDropDwon.reloadData()
//      }
//
//    }
//
//// -----TableView------
//extension PurchaseStoryDetailsVC: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if tableView == tableViewEvenDetails {
//            return 1
//        } else {
//            return tableViewData.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == tableViewEvenDetails {
//            return 1
//        } else {
//            if tableViewData[section].open == true {
//                return tableViewData[section].sectionData.count + 1
//            } else {
//                return 1
//            }
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if tableView == tableViewEvenDetails {
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseStoryDetailTableCell", for: indexPath) as! PurchaseStoryDetailTableCell
//                cell.labelEventName.text = headline
//                cell.labelTime.text = time
//                cell.labelPriceRete.text = "\(currency) \(price)"
//                cell.labelTechnology.text = categoryType
//                //cell.labelSoldOut.text = file
//                //cell.storyCategoryLabel.text = storyCategory
//                cell.keyword = self.keywords
//                cell.labelDetails.text = descriptions
//                cell.keywordCollectionView.reloadData()
//
//
//                if let profileUrls = NSURL(string: (imageThumbnail)) {
//                   cell.thumbnailImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
//                }
//
//                //-----For tag Types
//                if storyCategory == "Free" {
//                    cell.storyCategoryLabel.isHidden = true
//                    cell.buttonBuyNow.isHidden = true
//                } else if storyCategory == "Exclusive" {
//                    cell.storyCategoryLabel.text = "Exclusive"
//                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
//                    cell.storyCategoryLabel.isHidden = false
//                     cell.buttonBuyNow.isHidden = false
//                } else if storyCategory == "Shared" {
//                    cell.storyCategoryLabel.text = "Shared"
//                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
//                    cell.storyCategoryLabel.isHidden = false
//                    cell.buttonBuyNow.isHidden = false
//                } else if storyCategory == "Auction" {
//                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
//                    cell.storyCategoryLabel.text = "Auction"
//                    cell.storyCategoryLabel.isHidden = false
//                    cell.buttonBuyNow.isHidden = false
//                } else {
//                    //cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//                    //cell.storyCategoryLabel.text = "---"
//                    cell.storyCategoryLabel.isHidden = true
//                    cell.buttonBuyNow.isHidden = true
//
//                }
//                return cell
//            }
//        } else if tableView == tableViewDropDwon {
//            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "StoryDeatilsDropdwonCell", for: indexPath) as! StoryDeatilsDropdwonCell
//                cell.titlelbl.text = tableViewData[indexPath.section].title
//
//                if cellType == .expandCell {
//                    cell.DropBtn.setImage(#imageLiteral(resourceName: "Vector"), for: .normal)
//                } else if cellType == .collapseCell {
//                    cell.DropBtn.setImage(#imageLiteral(resourceName: "right-thin-chevron"), for: .normal)
//                }
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "StoryDetailsDropdownSubTableViewCell", for: indexPath) as!  StoryDetailsDropdownSubTableViewCell
//                cell.subtitlelbl.text = tableViewData[indexPath.section].sectionData[indexPath.row-1]
//
//                return cell
//            }
//
//        }
//
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == tableViewEvenDetails {
//
//        } else {
//            if tableViewData[indexPath.section].open == true{
//                tableViewData[indexPath.section].open = false
//                let section = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(section, with: .none)
//                cellType = .expandCell
//            } else {
//                tableViewData[indexPath.section].open = true
//                let section = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(section, with: .none)
//                cellType = .collapseCell
//            }
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.viewWillLayoutSubviews()
//    }
//
//
//}



enum expandCellTypes: String {
    case collapseCell = "collapse"
    case expandCell =  "expand"
}

struct TableCellFillData {
    var open = Bool()
    var title = String()
    var sectionData = [String]()
}

class PurchaseStoryDetailsVC: UIViewController {
    
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
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    @IBOutlet weak var collectionViewThumbImage: UICollectionView!
    @IBOutlet weak var collectionViewText: UICollectionView!
    @IBOutlet weak var colllectionViewAudio: UICollectionView!
    @IBOutlet weak var collectionViewVideo: UICollectionView!
    @IBOutlet weak var collectionViewSupportingFile: UICollectionView!
    
    @IBOutlet weak var imageViewDropAero: UIImageView!
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    @IBOutlet weak var imageViewText: UIImageView!
    @IBOutlet weak var imageViewAudio: UIImageView!
    @IBOutlet weak var imageViewVidio: UIImageView!
    @IBOutlet weak var imageViewSupprtingDoc: UIImageView!
    
    @IBOutlet weak var textContainerView: UIView!
     @IBOutlet weak var imageContainerView: UIView!
     @IBOutlet weak var thumbnailContainerView: UIView!
     @IBOutlet weak var audioContainerView: UIView!
     @IBOutlet weak var videoContainerView: UIView!
     @IBOutlet weak var docContainerView: UIView!
    
    var flag1 = true
    var flag2 = true
    var flag3 = true
    var flag4 = true
    var flag5 = true
    var flag6 = true
    
    var tableViewData = [TableCellData]()
    var cellType:expandCellTypes = .collapseCell
//    var StoryDetails = MediaStroyModel()
    var StoryDetails = FavoriteStroyDocsModel()
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
    
    var lastBiddingPrice = ""
    var realBiddingPrice = ""
    var auctionBiddingPrices = ""
    var biddingView = ""
    
    var reviewCount = 0
    var getTextArray = [journalistStoryModal]()
    var keywords = [String]()
    var allReviewList = GetJornalistReplyModel()
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    
    
    var JournalistId = ""
    var firstName = ""
    var lastName = ""
    var middleName = ""
    var profilePic = ""
    var userType = ""
    
    var currency = ""
    
    
    var allOverRatting = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currenUserLogin = User.loadSavedUser()
//        setupTableViewData()
        setupUI()
        MediaDataSetup()
        setupButton()
        setupTableView()
        MediaDataSetup()
        apiCall()
        
        labelRating.text = "\(allOverRatting)"
        
        //tableViewDropDwon.tableFooterView = UIView()
        //tableViewReview.isHidden = true
        //reviewButtonConatinerView.isHidden = true
//        if reviewCount == 0 {
//            //setupTableViewData()
//            tableViewReview.isHidden = false
//            reviewButtonConatinerView.isHidden = false
//        } else {
//            apiCall()
//        }
        
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        fileCount.text = file
        
        collectionViewImages.delegate = self
        collectionViewImages.dataSource = self
        collectionViewThumbImage.delegate = self
        collectionViewThumbImage.dataSource = self
        collectionViewText.dataSource = self
        collectionViewText.delegate = self
        collectionViewVideo.delegate = self
        collectionViewVideo.dataSource = self
        collectionViewSupportingFile.delegate = self
        collectionViewSupportingFile.dataSource = self
        colllectionViewAudio.delegate = self
        colllectionViewAudio.dataSource = self
        
        collectionViewImages.isHidden = true
        collectionViewThumbImage.isHidden = true
        collectionViewText.isHidden = true
        colllectionViewAudio.isHidden = true
        collectionViewVideo.isHidden = true
        collectionViewSupportingFile.isHidden = true
        
//        textContainerView.isHidden = true
//        imageContainerView.isHidden = true
//        thumbnailContainerView.isHidden = true
//        audioContainerView.isHidden = true
//        videoContainerView.isHidden = true
//        docContainerView.isHidden = true
        
        imageViewDropAero.image = #imageLiteral(resourceName: "Vector")
        imageViewThumbnail.image = #imageLiteral(resourceName: "Vector")
        imageViewText.image = #imageLiteral(resourceName: "Vector")
        imageViewAudio.image = #imageLiteral(resourceName: "Vector")
        imageViewVidio.image = #imageLiteral(resourceName: "Vector")
        imageViewSupprtingDoc.image = #imageLiteral(resourceName: "Vector")
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonAddReview.addTarget(self, action: #selector(onClickAddReview), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func onClickAddReview() {
        let postReviewVC = AppStoryboard.MediaHouse.viewController(PostReviewVC.self)
        postReviewVC.storyId = storyId
        self.navigationController?.pushViewController(postReviewVC, animated: true)
    }
    
    func setupTableView() {
        
        //registered CollectionView XIB
         collectionViewImages.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewThumbImage.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewText.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        colllectionViewAudio.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewVideo.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewSupportingFile.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        
        //registered TableView XIB
        
        
        tableViewEvenDetails.register(UINib(nibName: "PurchaseStoryDetailTableCell", bundle: Bundle.main), forCellReuseIdentifier: "PurchaseStoryDetailTableCell")

//        tableViewEvenDetails.register(UINib(nibName: "EventsDetailsTableCell", bundle: Bundle.main), forCellReuseIdentifier: "EventsDetailsTableCell")
        
        
        
        //tableViewDropDwon.register(UINib(nibName: "StoryDeatilsDropdwonCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDeatilsDropdwonCell")
       // tableViewDropDwon.register(UINib(nibName: "StoryDetailsDropdownSubTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "StoryDetailsDropdownSubTableViewCell")
        tableViewReview.register(UINib(nibName: "ReviewTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ReviewTableCell")
        //tableViewDropDwon.separatorInset = UIEdgeInsets.zero
        //tableViewDropDwon.separatorColor = UIColor.lightGray
        //self.tableViewDropDwon.rowHeight = UITableView.automaticDimension
        //self.tableViewDropDwon.estimatedRowHeight = 44.0
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        //TableView Popular services resize
        self.tableViewHeight?.constant = self.tableViewEvenDetails.contentSize.height
        //self.tableViewDropDwonHeight?.constant = self.tableViewDropDwon.contentSize.height
        self.tableViewReviewHeight?.constant = self.tableViewReview.contentSize.height
    }
    
    func MediaDataSetup() {
        
        if StoryDetails.storyId.uploadTexts.count == 0 {
            textContainerView.isHidden = true
        } else {
            textContainerView.isHidden = false
        }
        
        if StoryDetails.storyId.uploadImages.count == 0 {
            imageContainerView.isHidden = true
        } else {
            imageContainerView.isHidden = false
        }
        
        if StoryDetails.storyId.uploadThumbnails.count == 0 {
            thumbnailContainerView.isHidden = true
        } else {
            thumbnailContainerView.isHidden = false
        }
        
        if StoryDetails.storyId.uploadAudios.count == 0 {
            audioContainerView.isHidden = true
        } else {
            audioContainerView.isHidden = false
        }
        
        if StoryDetails.storyId.uploadVideos.count == 0 {
            videoContainerView.isHidden = true
        } else {
            videoContainerView.isHidden = false
        }
        
        if StoryDetails.storyId.supportingDocs.count == 0 {
            docContainerView.isHidden = true
        } else {
            docContainerView.isHidden = false
        }
    }
    
    
    func apiCall() {
        getReviews(storyId: storyId, header: currenUserLogin.mediahouseToken)
    }
    
    @IBAction func buttonActionText(_ sender: Any) {
        if flag1 == false {
            flag1 = true
            collectionViewText.isHidden = true
            imageViewText.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag1 = false
            collectionViewText.isHidden = false
            imageViewText.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @IBAction func buttonActionImage(_ sender: Any) {
        if flag2 == false {
            flag2 = true
            collectionViewImages.isHidden = true
            imageViewDropAero.image = #imageLiteral(resourceName: "Vector")
        } else {
             flag2 = false
            collectionViewImages.isHidden = false
            imageViewDropAero.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @IBAction func buttonActionThumbnailsImg(_ sender: Any) {
        if flag3 == false {
            flag3 = true
            collectionViewThumbImage.isHidden = true
            imageViewThumbnail.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag3 = false
            collectionViewThumbImage.isHidden = false
            imageViewThumbnail.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @IBAction func buttonActionAudio(_ sender: Any) {
        if flag4 == false {
            flag4 = true
            colllectionViewAudio.isHidden = true
            imageViewAudio.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag4 = false
            colllectionViewAudio.isHidden = false
            imageViewAudio.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @IBAction func buttonActionVideo(_ sender: Any) {
        if flag5 == false {
            flag5 = true
            collectionViewVideo.isHidden = true
            imageViewVidio.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag5 = false
            collectionViewVideo.isHidden = false
            imageViewVidio.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @IBAction func buttonActionSupportingDoc(_ sender: Any) {
        if flag6 == false {
            flag6 = true
            collectionViewSupportingFile.isHidden = true
            imageViewSupprtingDoc.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag6 = false
            collectionViewSupportingFile.isHidden = false
            imageViewSupprtingDoc.image = #imageLiteral(resourceName: "Vector-1")
        }
    }
    
    @objc func onClickProfileButton(){
        let journalistProfileVC = AppStoryboard.Journalist.viewController(JournalistProfileViewController.self)
        journalistProfileVC.journalistIDByStory = JournalistId
        self.navigationController?.pushViewController(journalistProfileVC, animated: true)
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
    
    func getReviews(storyId: String, header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.reviewList(storyId: storyId, header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.allReviewList = somecategory
                    if self.allReviewList.docs.count == 0 {
                        //self.setupTableViewData()
                        self.tableViewReview.isHidden = true
                        self.reviewButtonConatinerView.isHidden = false
                        self.labelReviewTableCount.text = "Reviews (\(self.allReviewList.docs.count))"
                    } else {
                        self.calculateTime()
                        self.labelReviewTableCount.text = "Reviews (\(self.allReviewList.docs.count))"
                        self.tableViewReview.reloadData()
                        //self.setupTableViewData()
                    }
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func downloadporchaseStory(storyId : String, header : String){
        Webservice.sharedInstance.purchaseDownloadStory(storyId: storyId, header: header){(result,response,message) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

    
    
    
}

// -----TableView------
extension PurchaseStoryDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewEvenDetails {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewEvenDetails {
            return 1
        } else {
            return allReviewList.docs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewEvenDetails {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseStoryDetailTableCell", for: indexPath) as! PurchaseStoryDetailTableCell
//
//                if lastBiddingPrice == ""{
//                    cell.biddingPrice.text = auctionBiddingPrices
//                } else {
//                    cell.biddingPrice.text = realBiddingPrice
//                }
//
//                cell.editButton.isHidden = true
//                cell.deleteButton.isHidden = true
//
//                cell.labelProfileName.text = name
                cell.labelEventName.text = headline
                cell.labelTime.text = time
                // cell.labelPriceRete.text = price
                cell.labelTechnology.text = categoryType
                //cell.labelSoldOut.text = file
                //cell.storyCategoryLabel.text = storyCategory
                //                cell.keyword = self.keywords
                var allKeywords = keywords
                allKeywords.append("")
                cell.keyword = allKeywords
                
                cell.labelDetails.text = descriptions
                cell.keywordCollectionView.reloadData()
                
                cell.buttonBuyNow.tag = indexPath.row
                cell.buttonBuyNow.addTarget(self, action: #selector(clickOnDownLoadButton(sender:)), for: .touchUpInside)
                                
                if let profileUrls = NSURL(string: (imageThumbnail)) {
                    cell.thumbnailImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                }
//                if let profileUrls = NSURL(string: (imageurl)) {
//                    cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
//                }
                
                //-----For tag Types
                if storyCategory == "Free" {
                    cell.storyCategoryLabel.isHidden = true
                    cell.buttonBuyNow.isHidden = false
                    cell.labelPriceRete.isHidden = true
//                    cell.biddingView.isHidden = true
                } else if storyCategory == "Exclusive" {
                    cell.storyCategoryLabel.text = "Exclusive"
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = false
//                    cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                    cell.labelPriceRete.text = price
//                    cell.biddingView.isHidden = true
                } else if storyCategory == "Shared" {
                    cell.storyCategoryLabel.text = "Shared"
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.4457011819, green: 0.8212516904, blue: 0.8868162036, alpha: 1)
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = false
//                    cell.buttonBuyNow.setTitle("BUY NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                    cell.labelPriceRete.text = price
//                    cell.biddingView.isHidden = true
                } else if storyCategory == "Auction" {
                    cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
                    cell.storyCategoryLabel.text = "Auction"
                    cell.storyCategoryLabel.isHidden = false
                    cell.buttonBuyNow.isHidden = false
//                    cell.buttonBuyNow.setTitle("BID NOW", for: .normal)
                    cell.labelPriceRete.isHidden = false
                    cell.labelPriceRete.text = auctionBiddingPrice
//                    cell.biddingView.isHidden = false
                } else {
                    //cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                    //cell.storyCategoryLabel.text = "---"
                    cell.storyCategoryLabel.isHidden = true
                    cell.buttonBuyNow.isHidden = false
                    cell.labelPriceRete.isHidden = true
//                    cell.biddingView.isHidden = true
                }
                
                //-----For tag Types
//                if favouriteStatus == 1 {
//                    cell.buttonHeart.setImage(#imageLiteral(resourceName: "like"), for: .normal)
//                } else {
//                    cell.buttonHeart.setImage(#imageLiteral(resourceName: "heart-1"), for: .normal)
//                }
                
                return cell
            }
        } else if tableView == tableViewReview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! ReviewTableCell
            let data = allReviewList.docs[indexPath.row]
            cell.labelName.text = "\(data.mediahouseId.firstName) \(data.mediahouseId.middleName) \(data.mediahouseId.lastName)"
            cell.labelDetails.text = data.mediahouseComment
            cell.labelTime.text = "\(data.mediahouseId.langCode) | \(storyTimeArray[indexPath.row]) | \(data.mediahouseId.state.stateName)"
            cell.labelRating.text = (data.averageRating)
            let getProfileUrl = "\(self.baseUrl)\(data.mediahouseId.logo)"//arrdata.journalistId.Image
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.imageViewProfile.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            return cell
        }
        
        return UITableViewCell()
    }
            
       @objc func clickOnDownLoadButton(sender : UIButton){
            print("storyID========\(storyId)")
            downloadporchaseStory(storyId: storyId, header: currenUserLogin.mediahouseToken)
            
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


// MARK:- Chat Method
extension PurchaseStoryDetailsVC: AccessEventDetailCell {
    func initiateChat(_ sender: UIButton) {
        let tempDict: [String : AnyObject] = [
            "senderID": currenUserLogin.mediahouseId as AnyObject,
            "senderImage": currenUserLogin.UserInfo.logo as AnyObject,
            "senderFirstName": currenUserLogin.UserInfo.firstName as AnyObject,
            "senderMiddleName": currenUserLogin.UserInfo.middleName as AnyObject,
            "senderLastName": currenUserLogin.UserInfo.lastName as AnyObject,
            "senderUserType": currenUserLogin.userType as AnyObject,
            "receiverID": self.JournalistId as AnyObject,
            "receiverImage": self.profilePic as AnyObject,
            "receiverFirstName": self.firstName as AnyObject,
            "receiverMiddleName": self.middleName as AnyObject,
            "receiverLastName": self.lastName as AnyObject,
            "receiverUserType": self.userType as AnyObject,
            "chatID": (currenUserLogin.mediahouseId + "_" + self.JournalistId) as AnyObject
        ]
        
        let chatUser = Users(dictionary: tempDict)
        print(chatUser.description)
        let chatLogController = ChatLogController()
        let toUser = chatUser
        chatLogController.user = toUser
        navigationController?.pushViewController(chatLogController, animated: true)
    }
}

//extension StoryDetailsVC: DismissPopUpDelagate{
//    func NavigateBuyAuction(price: String) {
//        let buyVC = AppStoryboard.Stories.viewController(BuyAuctionEventVC.self)
//
//
//        buyVC.storyCategory = self.storyCategory
//        buyVC.time = self.time
//        buyVC.categoryType = self.categoryType
//        buyVC.biddingPrice = self.lastBiddingPrice
//        buyVC.desc = self.descriptions
//        buyVC.headline = self.headline
//        buyVC.storyId = self.storyId
//        buyVC.currency = self.currency
//        buyVC.price = price
//        print("price=========\(price)")
//        print("storyId=======\(storyId)")
//        self.navigationController?.pushViewController(buyVC, animated: true)
//    }
//
//
//}

// -----CollectionView------

extension PurchaseStoryDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewImages {
            return StoryDetails.storyId.uploadImages.count
        } else if collectionView == collectionViewThumbImage {
            return StoryDetails.storyId.uploadThumbnails.count
        } else if collectionView == collectionViewText {
            return StoryDetails.storyId.uploadTexts.count
        } else if collectionView == colllectionViewAudio {
            return StoryDetails.storyId.uploadAudios.count
        } else if collectionView == collectionViewVideo {
            return StoryDetails.storyId.uploadVideos.count
        } else if collectionView == collectionViewSupportingFile {
            return StoryDetails.storyId.supportingDocs.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentsFileCollectionCell", for: indexPath) as! AttachmentsFileCollectionCell
        if collectionView == collectionViewImages {
            let imgUrl = StoryDetails.storyId.uploadImages[indexPath.item].Image
            let getProfileUrl = "\(self.baseUrl)\(imgUrl)"//arrdata.journalistId.Image
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                //cell.labelImageName.text = StoryDetails.uploadImages[indexPath.item].filename
            }
        } else if collectionView == collectionViewThumbImage {
            let imgUrl = StoryDetails.storyId.uploadThumbnails[indexPath.item].thumbnale
            let getProfileUrl = "\(self.baseUrl)\(imgUrl)"//arrdata.journalistId.Image
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                //cell.labelImageName.text = StoryDetails.uploadImages[indexPath.item].filename
            }
        } else if collectionView == collectionViewText {
            cell.imageViewSetImg.image = #imageLiteral(resourceName: "Documents")
            //cell.labelImageName.text = StoryDetails.uploadTexts[indexPath.item].text
        } else if collectionView == colllectionViewAudio {
             cell.imageViewSetImg.image = #imageLiteral(resourceName: "images-2")
            //cell.labelImageName.text = StoryDetails.uploadAudios[indexPath.item].audio
        } else if collectionView == collectionViewVideo {
             cell.imageViewSetImg.image = #imageLiteral(resourceName: "gallery")
            //cell.labelImageName.text = StoryDetails.uploadVideos[indexPath.item].videoNote
        } else if collectionView == collectionViewSupportingFile {
             cell.imageViewSetImg.image = #imageLiteral(resourceName: "story")
            //cell.labelImageName.text = StoryDetails.supportingDocs[indexPath.item].docNote
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 50, height: 60)
    }
    
}


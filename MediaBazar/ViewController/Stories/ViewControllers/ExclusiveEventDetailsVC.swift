//
//  ExclusiveEventDetailsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


class ExclusiveEventDetailsVC: UIViewController {
    
    @IBOutlet weak var tableViewReviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewEvenDetails: UITableView!
    @IBOutlet weak var tableViewReviews: UITableView!
    
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
    
    
    var flag1 = true
    var flag2 = true
    var flag3 = true
    var flag4 = true
    var flag5 = true
    var flag6 = true
    
//    var detailData = listStory()
//    var detailData = [listStory]()
    var detailData = storyListModal()
    var thumbnailImage = ""
    var jouranlistId = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
        setupData()
    }
    
    func setupUI() {
        
        tabBarController?.tabBar.isHidden = true
        
        collectionViewImages.isHidden = true
        collectionViewThumbImage.isHidden = true
        collectionViewText.isHidden = true
        colllectionViewAudio.isHidden = true
        collectionViewVideo.isHidden = true
        collectionViewSupportingFile.isHidden = true
        
        imageViewDropAero.image = #imageLiteral(resourceName: "Vector")
        imageViewThumbnail.image = #imageLiteral(resourceName: "Vector")
        imageViewText.image = #imageLiteral(resourceName: "Vector")
        imageViewAudio.image = #imageLiteral(resourceName: "Vector")
        imageViewVidio.image = #imageLiteral(resourceName: "Vector")
        imageViewSupprtingDoc.image = #imageLiteral(resourceName: "Vector")
    }
    
    func setupData() {
        
        for data in detailData.uploadThumbnails.enumerated() {
            let tempData = data.element.thumbnale
            thumbnailImage = tempData
//            for thumbnail in tempData {
//                thumbnailImage = thumbnail.thumbnale
//
//            }
        }
//
//        for journalistDataID in detailData.docs.enumerated(){
//            let temData = journalistDataID.element.journalistId.id
//            jouranlistId = temData
//            print("=============\(jouranlistId)")
//        }
                

                
    }

    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        
        tableViewEvenDetails.reloadData()
        
        //registered TableView XIB
        tableViewEvenDetails.register(UINib(nibName: "EventsDetailsTableCell", bundle: Bundle.main), forCellReuseIdentifier: "EventsDetailsTableCell")
        
        tableViewReviews.register(UINib(nibName: "ReviewTableCell", bundle: Bundle.main), forCellReuseIdentifier: "ReviewTableCell")
        
        //registered CollectionView XIB
        collectionViewImages.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewThumbImage.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewText.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        colllectionViewAudio.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewVideo.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
        collectionViewSupportingFile.register(UINib(nibName: "AttachmentsFileCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttachmentsFileCollectionCell")
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeight.constant = tableViewEvenDetails.contentSize.height
        self.tableViewReviewHeight.constant = tableViewReviews.contentSize.height
    }
    
    @IBAction func buttonActionText(_ sender: Any) {
        if flag1 == false {
            flag1 = true
            collectionViewText.isHidden = true
            imageViewText.image = #imageLiteral(resourceName: "Vector")
        } else {
            flag1 = false
            collectionViewText.isHidden = false
            imageViewText.image = #imageLiteral(resourceName: "Vector-2")
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
            imageViewDropAero.image = #imageLiteral(resourceName: "Vector-2")
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
            imageViewThumbnail.image = #imageLiteral(resourceName: "Vector-2")
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
            imageViewAudio.image = #imageLiteral(resourceName: "Vector-2")
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
            imageViewVidio.image = #imageLiteral(resourceName: "Vector-2")
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
            imageViewSupprtingDoc.image = #imageLiteral(resourceName: "Vector-2")
        }
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
    
}

// -----TableView------

extension ExclusiveEventDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewEvenDetails {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewEvenDetails {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EventsDetailsTableCell", for: indexPath) as! EventsDetailsTableCell
//                cell.buttonfree.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.4784313725, blue: 0.8117647059, alpha: 1)
//                cell.buttonfree.setTitle("Exclusive", for: .normal)
                cell.buttonBuyNow.isHidden = true
//                cell.labelSoldOut.isHidden = true
                cell.soldOutHeadlineLabel.isHidden = true
                cell.buttonName.addTarget(self, action: #selector(nameButtonPressed), for: .touchUpInside)
                cell.buttonBuyNow.addTarget(self, action: #selector(buyNowbuttonPreesed), for: .touchUpInside)
                
                
//                let arrdata = detailData.docs[indexPath.row]
//                let arrdata = detailData[indexPath.row]
//                cell.labelProfileName.text = detailData.journalistId
                
                cell.labelProfileName.text = ("\(detailData.journalistId.firstName) \(detailData.journalistId.lastName)")
                cell.labelEventName.text = detailData.headLine
                cell.labelTechnology.text = detailData.storyCategory
                cell.labelTime.text = ("\(detailData.langCode) | \(detailData.createdAt) | \(detailData.country.name)")
                cell.labelPriceRete.text = String(detailData.price)
                cell.storyCategoryLabel.text = detailData.storyCategory
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

                let url = NSURL(string: thumbnailImage)
                cell.thumbnailImage.sd_setImage(with: url! as URL)
                cell.labelDescription.text = detailData.briefDescription

                cell.keyword = detailData.keywordName
                cell.keywordCollectionView.reloadData()
                

                
                return cell
            }
            
        } else if tableView == tableViewReviews {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableCell", for: indexPath) as! ReviewTableCell
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableViewEvenDetails {
            return UITableView.automaticDimension
            //            if indexPath.row == 0 {
            //                return UITableView.automaticDimension
            //            } else if indexPath.row == 1 {
            //                return 30
            //            }
        } else if tableView == tableViewReviews {
            return 110
        }
        
        return UITableView.automaticDimension
    }
    
}


// -----CollectionView------

extension ExclusiveEventDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentsFileCollectionCell", for: indexPath) as! AttachmentsFileCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 50, height: 120)
    }
    
}




//
//  JournalistStoryListByIDViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 13/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistStoryListByIDViewController: UIViewController {
    
    @IBOutlet weak var storiesTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var stories = [MediaStroyDocsModel]()
    var storyTimeArray = [String]()
    
    var currentUserLogin : User!
    var jornalistID = ""
    var page = 0
    var totalPages = 0
    var scrollPage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupButton()
        calculateTime()
        self.currentUserLogin = User.loadSavedUser()
        getAllStoryData(page: "0", journalistID: jornalistID, header: currentUserLogin.mediahouseToken)

        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.storiesTableView.dataSource = self
        self.storiesTableView.delegate = self
        self.storiesTableView.bounces = false
        self.storiesTableView.alwaysBounceVertical = false
        self.storiesTableView.rowHeight = UITableView.automaticDimension
        self.storiesTableView.estimatedRowHeight = 1000
        self.storiesTableView.reloadData()
        
    }
    
    func setupButton() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }


    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in stories.enumerated() {
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

    func getAllStoryData(page : String,journalistID : String, header : String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getStoryListByJournalistID(journalistID: journalistID, page: page, storyHeader: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.scrollPage = true
                    self.stories.append(contentsOf: somecategory.docs)
                    self.storiesTableView.reloadData()
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
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

}

extension JournalistStoryListByIDViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistStoriesTableViewCell") as! JournalistStoriesTableViewCell
        
        let arrdata = stories[indexPath.row]
        let time = storyTimeArray[indexPath.row]
        cell.categoryTypeLAbel.text = arrdata.categoryId.categoryName
        cell.langTimeStateLabel.text = ("\(arrdata.langCode) | \(time) | \(arrdata.state.stateName)")
        cell.headlineLabel.text = arrdata.headLine
        
        
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !scrollPage { return }
        if (stories.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            getAllStoryData(page: "\(page)", journalistID: jornalistID, header: currentUserLogin.mediahouseToken)

        }
    }
    
    
}

//
//  SharedEarningViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SharedEarningViewControllerJM: UIViewController {
    
    @IBOutlet weak var sharedEarningTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var totalEarningLabel : UILabel!
    @IBOutlet weak var storyCategoryLabel : UILabel!
    @IBOutlet weak var headlinelabel : UILabel!
    @IBOutlet weak var soldOutLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var totalEarn : UILabel!
    
    @IBOutlet weak var heading : UILabel!
    
    var currentLocation : User!
    var storyID = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var earningDataByID = earningModalByStoryID()
    var storyTimeArray = [String]()

    var headingLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupButton()
        setupTableView()
        self.heading.text = headingLabel
        self.currentLocation = User.loadSavedUser()
        getEarningDataByID(storyID: storyID, header: currentLocation.token)
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView(){
        self.sharedEarningTableView.dataSource = self
        self.sharedEarningTableView.delegate = self
    }
    
    func calculateTime() {
          
          var tempTimeArray = [String]()
        for data in earningDataByID.mediahouseData.enumerated() {
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
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getEarningDataByID(storyID : String, header : String){
        Webservices.sharedInstance.getEarningStoryByID(storyID: storyID, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.earningDataByID = somecategory
                    self.sharedEarningTableView.reloadData()
                    self.totalEarningLabel.text = "\(self.earningDataByID.currency) \(String(self.earningDataByID.totalEarning))"
                    self.storyCategoryLabel.text = self.earningDataByID.storyData.storyCategory
                    self.headlinelabel.text = self.earningDataByID.storyData.headLine
                    self.soldOutLabel.text = "\(String(self.earningDataByID.storyData.soldOut)) Times"
                    self.priceLabel.text = "$ \(self.earningDataByID.storyData.price)"
                      self.totalEarn.text = "\(self.earningDataByID.currency) \(String(self.earningDataByID.totalEarning))"
                    self.sharedEarningTableView.reloadData()
                    
                    if self.earningDataByID.storyData.storyCategory == "Exclusive"{
                        self.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                    } else if self.earningDataByID.storyData.storyCategory == "Shared"{
                        self.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                    } else if self.earningDataByID.storyData.storyCategory == "Free"{
                        self.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                    } else if self.earningDataByID.storyData.storyCategory == "Auction" {
                        self.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                    } else {
                        self.storyCategoryLabel.isHidden = true
                    }

                    self.calculateTime()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

extension SharedEarningViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earningDataByID.mediahouseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedEarningTableViewCellJM") as! SharedEarningTableViewCellJM
        let arrdata = earningDataByID.mediahouseData[indexPath.row]
        let time = storyTimeArray[indexPath.row]
        cell.titleLabel.text = "\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.middleName) \(arrdata.mediaHouseID.lastName)"
        cell.transactionID.text = arrdata.transactionId
        cell.priceLabel.text = "\(earningDataByID.currency) \(arrdata.realPrice)"
        cell.timeLabel.text = time
        cell.dateLabel.text = String(arrdata.updatedAt.prefix(10))
        
        let getLogoUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
        let url = NSURL(string: getLogoUrl)
        cell.logoImage.sd_setImage(with: url! as URL)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

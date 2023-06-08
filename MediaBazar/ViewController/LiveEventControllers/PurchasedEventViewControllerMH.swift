//
//  PurchasedEventViewControllerMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchasedEventViewControllerMH: UIViewController {

    @IBOutlet weak var purchaseTableview : UITableView!
        
        var newEventList = [PurchaseDetailsModel]()
//        var newEventList = PurchaseListModel()
        var currenUserLogin : User!
        var baseUrl = "https://apimediaprod.5wh.com/"


        override func viewDidLoad() {
            super.viewDidLoad()
            self.currenUserLogin = User.loadSavedUser()
            setupUI()
            setupTableView()
            apiCall()
            // Do any additional setup after loading the view.
        }
        
        func setupUI(){
            tabBarController?.tabBar.isHidden = true
        }
        
        func setupTableView() {
            self.purchaseTableview.dataSource = self
            self.purchaseTableview.delegate = self
            self.purchaseTableview.bounces = false
            self.purchaseTableview.alwaysBounceVertical = false
            self.purchaseTableview.rowHeight = UITableView.automaticDimension
            self.purchaseTableview.estimatedRowHeight = 1000
     
        }
        
        func apiCall() {
            getEventList(SearchKey: "", header: currenUserLogin.mediahouseToken)
        }

        func getEventList(SearchKey : String,header: String) {
            CommonClass.showLoader()
            WebService3.sharedInstance.purchaseList(searchKey: SearchKey, header: header){(result,message,response) in
                print(result)
                CommonClass.hideLoader()
                if result == 200{
                    if let somecategory = response{
//                        self.newEventList = somecategory
                        self.newEventList.append(contentsOf: somecategory)
                        self.purchaseTableview.reloadData()
                    } else{
                        
                    }
                }else{
                    self.purchaseTableview.reloadData()
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }

    }

    extension PurchasedEventViewControllerMH: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newEventList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseEvetListTableViewCellMH", for: indexPath) as! PurchaseEvetListTableViewCellMH
            let arrdata = newEventList[indexPath.row].assignmentId
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
            if let profileUrls = NSURL(string: (getProfileUrl)) {
               cell.profileImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            cell.nameLabel.text = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            cell.pricelabel.text = "\(arrdata.currency) \(arrdata.price)"
            cell.headinglabel.text = arrdata.journalistHeadline
            cell.timeDateLabel.text = "\(arrdata.time),\(arrdata.date) | \(arrdata.country.name)"
            cell.descriptionLabel.text = arrdata.journalistDescription
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVC = AppStoryboard.MediaHouse.viewController(PurchaseEventDetailViewControllerMH.self)
            let arrdata = newEventList[indexPath.row].assignmentId
            detailVC.headline = arrdata.journalistHeadline
            detailVC.time = arrdata.time
            detailVC.date = arrdata.date
            detailVC.country = arrdata.country.name
            detailVC.currency = arrdata.currency
            detailVC.price = String(arrdata.price)
            detailVC.name = "\(arrdata.journalistId.firstName) \(arrdata.journalistId.middleName) \(arrdata.journalistId.lastName)"
            detailVC.profileImage = arrdata.journalistId.profilePic
            detailVC.assignmentID = arrdata.ids
            detailVC.descri = arrdata.journalistDescription
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        
    }

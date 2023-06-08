//
//  NotificationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NotificationViewControllerJM: UIViewController {

        @IBOutlet weak var notificationTableView: UITableView!
        @IBOutlet weak var topView: UIView!
        @IBOutlet weak var backButton: UIButton!
        @IBOutlet weak var buttonClear: UIButton!
        
        var notificationData = [NotificationList]()
        var currenUserLogin : User!
        var notificationIdArray = [String]()
        var notificationIdConvertedFormat = ""

        override func viewDidLoad() {
            super.viewDidLoad()
            self.currenUserLogin = User.loadSavedUser()
            setupUI()
            setupTableView()
            setupButton()
            apiCall()
        }
        
        fileprivate func setupUI() {
            tabBarController?.tabBar.isHidden = true
            topView.applyShadow()
        }
        
        fileprivate func setupTableView() {
            notificationTableView.dataSource = self
            notificationTableView.delegate = self
            notificationTableView.bounces = false
            notificationTableView.alwaysBounceVertical = false
            notificationTableView.rowHeight = UITableView.automaticDimension
            notificationTableView.estimatedRowHeight = 1000
            buttonClear.makeBorder(1, color: .darkGray)
        }
        
        fileprivate func setupButton() {
            backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
            buttonClear.addTarget(self, action: #selector(onclickClearBtn), for: .touchUpInside)
        }
        
        @objc func popViewController() {
            navigationController?.popViewController(animated: true)
        }
        
        @objc func onclickClearBtn() {
            for data in notificationData.enumerated() {
                notificationIdArray.append(data.element.notificationId)
            }
            let langData = "\(notificationIdArray)"
            var notificationId = langData.replacingOccurrences(of: "[", with: "")
            notificationId = notificationId.replacingOccurrences(of: "]", with: "")
            notificationId = notificationId.replacingOccurrences(of: "\"", with: "")
            notificationId = notificationId.replacingOccurrences(of: " ", with: "")
            self.notificationIdConvertedFormat = notificationId
            
            self.cleanNotificationList(token: currenUserLogin.token, notificationId: notificationIdConvertedFormat)
        }
        
        func setupData() {
               
        }
        
        func apiCall() {
            self.getNotificationList(token: currenUserLogin.token)
        }
    
        
        func getNotificationList(token: String){
            CommonClass.showLoader()
            Webservices.sharedInstance.notificationLists(header: token){(result,response,message) in
                CommonClass.hideLoader()
                print(result)
                if result == 200 {
                    if let somecategory = response{
                        self.notificationData.append(contentsOf: somecategory)
                        self.setupData()
                        self.notificationTableView.reloadData()
                    }
                    if self.notificationData.count == 0 {
                        self.buttonClear.isHidden = true
                    }
                }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
        
        func cleanNotificationList(token: String, notificationId: String){
            CommonClass.showLoader()
            Webservices.sharedInstance.clearNotificationLists(notificationId: notificationId, header: token){(result,response,message) in
                CommonClass.hideLoader()
                print(result)
                if result == 200 {
                    self.notificationTableView.reloadData()
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }else{
                    self.notificationTableView.reloadData()
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
    }

    extension NotificationViewControllerJM: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notificationData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCellJM") as! NotificationTableViewCellJM
            cell.labelTitle.text = notificationData[indexPath.row].title
            cell.labelDescription.text = notificationData[indexPath.row].descriptions
            cell.labelTime.text = notificationData[indexPath.row].createdAt
           // cell.buttonClear.tag = indexPath.row
            return cell
        }
        
    }


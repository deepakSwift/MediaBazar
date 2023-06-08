//
//  NotificationController.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NotificationController: UIViewController {
    
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var topViewHeaderView: UIView!
    
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
        
        self.cleanNotificationList(token: currenUserLogin.mediahouseToken, notificationId: notificationIdConvertedFormat)
    }
    
    func setupData() {
           
    }
    
    func apiCall() {
        self.getNotificationList(token: currenUserLogin.mediahouseToken)
    }
    
    func getNotificationList(token: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.notificationList(header: token){(result,response,message) in
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
                    self.topViewHeaderView.isHidden = true
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.notificationTableView.bounds.size.width, height: self.notificationTableView.bounds.size.height))
                    noDataLabel.text = "No notification available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.notificationTableView.backgroundView = noDataLabel
                    self.notificationTableView.backgroundColor = UIColor.white
                    self.notificationTableView.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func cleanNotificationList(token: String, notificationId: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.clearNotificationList(notificationId: notificationId, header: token){(result,response,message) in
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

extension NotificationController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.labelTitle.text = notificationData[indexPath.row].title
        cell.labelDescription.text = notificationData[indexPath.row].descriptions
        cell.labelTime.text = notificationData[indexPath.row].createdAt
        cell.buttonClear.tag = indexPath.row
        return cell
    }
    
}


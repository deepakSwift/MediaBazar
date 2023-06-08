//
//  RepliesDetailsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 23/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class RepliesDetailsVC: UIViewController {

    @IBOutlet weak var tableViewReply: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    
    var allStoryList = GetJornalistReplyModel()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var getId = ""
    var dataCount = 0
    var storyTimeArray = [String]()
    
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
        buttonBack.addTarget(self, action: #selector(onClickBack), for: .touchUpInside)
    }
    
    func setupTableView() {
        //registered XIB
        tableViewReply.register(UINib(nibName: "JournalismAssignmentTableCell", bundle: Bundle.main), forCellReuseIdentifier: "JournalismAssignmentTableCell")
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in allStoryList.docs.enumerated() {
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
    
    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func apiCall() {
        getAssignmentReply(assignmentId: self.getId, header: currenUserLogin.mediahouseToken)
    }
    
    //------getAssignmetdata-------
    func getAssignmentReply(assignmentId: String ,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.replyList(assignmentId: assignmentId, header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.allStoryList = somecategory
                    self.tableViewReply.reloadData()
                    self.calculateTime()
                } else{
                    
                }
            }else{
                self.tableViewReply.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


//---- TableView ----
extension RepliesDetailsVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.docs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalismAssignmentTableCell", for: indexPath) as! JournalismAssignmentTableCell
        let data = allStoryList.docs[indexPath.row]
        cell.labelName.text = "\(data.journalistId.firstName) \(data.journalistId.middleName) \(data.journalistId.lastName)"
        cell.labelTitle.text = "\(data.journalistId.langCode) | \(data.journalistId.country.name) | \(data.journalistId.state.stateName)"
        cell.labelTime.text = data.journalistComment
        cell.labelDescription.text = storyTimeArray[indexPath.row]
        let getProfileUrl = "\(self.baseUrl)\(data.journalistId.profilePic)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
           cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

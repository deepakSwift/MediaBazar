//
//  JournalistAssignmentVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistAssignmentVC: UIViewController {

    @IBOutlet weak var tableViewJournalismAssignments: UITableView!
    
//    var allStoryList = AssignmentListModel()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var allStoryList = [AssignmentListDetailsModel]()
    var page = 0
    var totalPages = 0
    var scrollPage = true

    
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
        //registered XIB
        tableViewJournalismAssignments.register(UINib(nibName: "JournalismAssignmentTableCell", bundle: Bundle.main), forCellReuseIdentifier: "JournalismAssignmentTableCell")
    }
    
    func apiCall() {
        getAssignmentData(page: "0", header: currenUserLogin.mediahouseToken)
    }
    
    //------getAssignmetdata-------
    func getAssignmentData(page : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.journalistAssgnmentList(page: page, header:header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
//                    self.allStoryList = somecategory
                    
                    self.scrollPage = true
                    self.allStoryList.append(contentsOf: somecategory.docs)
                    self.tableViewJournalismAssignments.reloadData()
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
                if self.allStoryList.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewJournalismAssignments.bounds.size.width, height: self.tableViewJournalismAssignments.bounds.size.height))
                    noDataLabel.text = "No Assignments available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewJournalismAssignments.backgroundView = noDataLabel
                    self.tableViewJournalismAssignments.backgroundColor = UIColor.white
                    self.tableViewJournalismAssignments.separatorStyle = .none
                }
            }else{
                self.tableViewJournalismAssignments.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


//-- TableView----

extension JournalistAssignmentVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalismAssignmentTableCell", for: indexPath) as! JournalismAssignmentTableCell
        let data = allStoryList[indexPath.row]
        cell.viewContainer.makeBorder(1, color: .lightGray)
        cell.labelName.text = "\(data.journalistId.firstName) \(data.journalistId.middleName) \(data.journalistId.lastName)"
        cell.labelTitle.text = data.journalistHeadline
        cell.labelDescription.text = data.journalistDescription
        let getDate = data.date.getDate(Date.dateFormatDDMMMYYYYHHMMSSADashed(), Date.dateFormatHHMM())
        cell.labelTime.text = "\(data.time) | \(getDate) | \(data.country.name)"
        let getProfileUrl = "\(self.baseUrl)\(data.journalistId.profilePic)"
        if let profileUrls = NSURL(string: (getProfileUrl)) {
           cell.imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        
        var allKeywords = data.keywordName
        allKeywords.append("")
        cell.keyword = allKeywords
        cell.keywordsCollectionView.reloadData()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ReporterAssignmentDetailsVC") as! ReporterAssignmentDetailsVC
//        let data = allStoryList[indexPath.row]
//        detailsVC.name = "\(data.journalistId.firstName) \(data.journalistId.middleName)"
//        detailsVC.imgUrl = "\(self.baseUrl)\(data.journalistId.profilePic)"
//        detailsVC.getTitle = data.journalistHeadline
//        detailsVC.getDescription = data.journalistDescription
//        let getDate = data.date.getDate(Date.dateFormatDDMMMYYYYHHMMSSADashed(), Date.dateFormatHHMM())
//        detailsVC.time = "\(data.time) | \(getDate) | \(data.country.name)"
//        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
        if !scrollPage { return }
        if (allStoryList.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            getAssignmentData(page: "\(page)", header: currenUserLogin.token)

        }
    }

}

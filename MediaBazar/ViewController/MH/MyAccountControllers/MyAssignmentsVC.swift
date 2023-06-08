//
//  MyAssignmentsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyAssignmentsVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonFilter: UIButton!
    @IBOutlet weak var tableViewMyAssignments: UITableView!
    @IBOutlet weak var buttinPostAssignments: UIButton!
    
    
//    var allStoryList = AssignmentListModel()
//    var getSearchData = AssignmentListModel()
    var currenUserLogin : User!
    var storyTimeArray = [String]()
    var isSearching : Bool = true
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var typeOfData = ""
    
    var searchText = ""
    var allStoryList = [AssignmentListDetailsModel]()
    var getSearchData = [AssignmentListDetailsModel]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        apiCall()
        // Do any additional setup after loading the view.
    }
    

    func setupUI(){
       tabBarController?.tabBar.isHidden = true
       searchBar.delegate = self
    }
    
    func setupButton(){
        buttinPostAssignments.addTarget(self, action: #selector(buttonPostAssPressed), for: .touchUpInside)
    }
    
    func setupTableView() {
        //registered XIB
        tableViewMyAssignments.register(UINib(nibName: "MyAssignmentsTableCell", bundle: Bundle.main), forCellReuseIdentifier: "MyAssignmentsTableCell")
    }
    
    func apiCall() {
        getAssignmentData(page: "0", header: currenUserLogin.mediahouseToken)
    }
    
    @objc func buttonPostAssPressed() {
        let postAssignmentVC = self.storyboard?.instantiateViewController(withIdentifier: "PostAssignmentVC") as! PostAssignmentVC
        self.navigationController?.pushViewController(postAssignmentVC, animated: true)
    }
    
    func calculateTime() {
        if isSearching {
            var tempTimeArray = [String]()
            for data in self.allStoryList.enumerated() {
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
        } else {
            var tempTimeArray = [String]()
            for data in self.getSearchData.enumerated() {
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
    }
    
    //------getAssignmetdata-------
    func getAssignmentData(page : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.assgnmentList(page: page, header:header){(result,message,response) in
                print(result)
                CommonClass.hideLoader()
                if result == 200{
                    if let somecategory = response{
//                        self.allStoryList = somecategory
                        self.typeOfData = "all"
                        self.scrollPage = true
                        self.allStoryList.append(contentsOf: somecategory.docs)
                        self.tableViewMyAssignments.reloadData()
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
                    if self.allStoryList.count == 0 {
                        //-----Showing label in case data not found
                        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewMyAssignments.bounds.size.width, height: self.tableViewMyAssignments.bounds.size.height))
                        noDataLabel.text = "No Assignments available."
                        noDataLabel.textColor = UIColor.black
                        noDataLabel.textAlignment = .center
                        self.tableViewMyAssignments.backgroundView = noDataLabel
                        self.tableViewMyAssignments.backgroundColor = UIColor.white
                        self.tableViewMyAssignments.separatorStyle = .none
                    }
                }else{
                    self.tableViewMyAssignments.reloadData()
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
    }
    
    //-------Search All story -------
    func getAssignmentSearchData(page : String,searchKey: String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.getSearchAssignments(page: page, searchKey: searchKey, header: header){(result,message,response) in
            print(result)
           CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.typeOfData = "search"
                    self.scrollPage = true
                    self.getSearchData.append(contentsOf: somecategory.docs)
                    self.tableViewMyAssignments.reloadData()
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
                
                if self.getSearchData.count == 0 {
                    //-----Showing label in case data not found
                    let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewMyAssignments.bounds.size.width, height: self.tableViewMyAssignments.bounds.size.height))
                    noDataLabel.text = "No Assignments available."
                    noDataLabel.textColor = UIColor.black
                    noDataLabel.textAlignment = .center
                    self.tableViewMyAssignments.backgroundView = noDataLabel
                    self.tableViewMyAssignments.backgroundColor = UIColor.white
                    self.tableViewMyAssignments.separatorStyle = .none
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension MyAssignmentsVC: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            self.getSearchData.removeAll()
            self.page = 0
            self.totalPages = 0

            self.getAssignmentSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0

            self.getAssignmentData(page: "0", header: currenUserLogin.mediahouseToken)
        }
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
             self.searchText = searchBar.text!
            self.getSearchData.removeAll()
            self.page = 0
            self.totalPages = 0

            self.getAssignmentSearchData(page: "0", searchKey: searchBar.text!, header: currenUserLogin.mediahouseToken)
        } else {
            isSearching = true
            self.allStoryList.removeAll()
            self.page = 0
            self.totalPages = 0

            self.getAssignmentData(page: "0", header: currenUserLogin.mediahouseToken)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == searchBar {
            isSearching = true
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchBar {
            isSearching = false
            searchBar.resignFirstResponder()
        }
    }
}

//-- TableView----
extension MyAssignmentsVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return allStoryList.count
        } else {
           return getSearchData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAssignmentsTableCell", for: indexPath) as! MyAssignmentsTableCell
        
        if isSearching {
            let data = allStoryList[indexPath.row]
            cell.labelPrice.text = "Price: \(data.currency) \(data.price)"
            cell.labelTitle.text = data.assignmentTitle
            cell.labelDescription.text = data.assignmentDescription
            cell.labelTime.text = storyTimeArray[indexPath.row]
            cell.labelPlace.text = " \(data.langCode) | \(storyTimeArray[indexPath.row]) | \(data.country.name)"
            
            var allKeywords = data.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()
            
            if data.journalistReply.count == 0 {
             cell.reviewButttonConatinerView.isHidden = true
            } else {
               cell.reviewButttonConatinerView.isHidden = false
               cell.buttonReply.setTitle("Replies(\(data.replyCount))", for: .normal)
            }
            cell.buttonReply.tag = indexPath.row
            cell.buttonReply.addTarget(self, action: #selector(buttonReplyAction(sender:)), for: .touchUpInside)
            return cell
        } else {
            let data = getSearchData[indexPath.row]
            cell.labelPrice.text = "Price: \(data.currency) \(data.price)"
            cell.labelTitle.text = data.assignmentTitle
            cell.labelDescription.text = data.assignmentDescription
            cell.labelTime.text = storyTimeArray[indexPath.row]
            cell.labelPlace.text = " \(data.langCode) | \(storyTimeArray[indexPath.row]) | \(data.country.name)"
            
            var allKeywords = data.keywordName
            allKeywords.append("")
            cell.keyword = allKeywords
            cell.keywordsCollectionView.reloadData()

            
            if data.journalistReply.count == 0 {
             cell.reviewButttonConatinerView.isHidden = true
            } else {
               cell.reviewButttonConatinerView.isHidden = false
               cell.buttonReply.setTitle("Replies(\(data.replyCount))", for: .normal)
            }
            cell.buttonReply.tag = indexPath.row
            cell.buttonReply.addTarget(self, action: #selector(buttonReplyAction(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // print(indexPath.row)
        //        if isSearching{
        
        if !scrollPage { return }
        var totalPaginationPage = 0
        if self.typeOfData == "all"{
            totalPaginationPage = allStoryList.count
        }else if typeOfData == "search"{
            totalPaginationPage = getSearchData.count
        }else {
            return
        }
        
        if (totalPaginationPage - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page --- \(page)")
            
            if self.typeOfData == "all"{
                getAssignmentData(page: "\(page)", header: currenUserLogin.mediahouseToken)
            }else if typeOfData == "search"{
                getAssignmentSearchData(page: "\(page)", searchKey: self.searchText, header: currenUserLogin.mediahouseToken)

            }else {
                return
            }
        }
    }


    
    @objc func buttonReplyAction(sender: UIButton){

        //let cell = tableViewMyAssignments.cellForRow(at: IndexPath(row: 0, section: 0)) as! MyAssignmentsTableCell
          if isSearching {
            let id = allStoryList[sender.tag].id
            print("id=========\(id)")
            let replyVC = AppStoryboard.MediaHouse.viewController(RepliesDetailsVC.self)
            replyVC.getId = id
            self.navigationController?.pushViewController(replyVC, animated: true)
          } else {
             let id = getSearchData[sender.tag].id
             print("idSearch=========\(id)")
              let replyVC = AppStoryboard.MediaHouse.viewController(RepliesDetailsVC.self)
             replyVC.getId = id
              self.navigationController?.pushViewController(replyVC, animated: true)
          }
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

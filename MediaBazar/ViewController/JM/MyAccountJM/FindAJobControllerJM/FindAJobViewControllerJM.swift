//
//  FindAJobViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FindAJobViewControllerJM: UIViewController {
    
    @IBOutlet weak var findAJobTableview : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton :UIButton!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    
    var currentUserLogin : User!
    var jobList = listStory()
    var searchJobList = listStory()
    var isSearching : Bool = true
    var jobKeyword = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var keys = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        searchingBar.delegate = self
        getJobList(header: currentUserLogin.token)
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.findAJobTableview.dataSource = self
        self.findAJobTableview.delegate = self
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnViewDetailsButton(){
        let jobDetails = AppStoryboard.Journalist.viewController(FindAJobDetailViewController.self)
        self.navigationController?.pushViewController(jobDetails, animated: true)
    }
    
    func setUpdata(){
        //        if isSearching{
        //            for data in jobList.docs.enumerated(){
        //                let tempData = data.element.jobKeywordName
        //                self.keys = tempData
        //                //                    targetAudiance.append(tempData)
        //                print("=============\(keys)")
        //                //                    labelAreaAudience.text = targetAudiance.joined(separator: ", " )
        //            }
        //        } else{
        //            for data in searchJobList.docs.enumerated(){
        //                let tempData = data.element.jobKeywordName
        //                self.keys = tempData
        //                //                    targetAudiance.append(tempData)
        //                print("=============\(keys)")
        //                //                    labelAreaAudience.text = targetAudiance.joined(separator: ", " )
        //            }
        //        }
        
        
        
        //        for data in jobList.docs.enumerated(){
        //            let tempData = data.element.jobKeywordName
        //            self.keys = tempData
        //            //                    targetAudiance.append(tempData)
        //            print("=============\(keys)")
        //            //                    labelAreaAudience.text = targetAudiance.joined(separator: ", " )
        //        }
        
    }
    
    
    
    func getJobList(header: String){
        Webservices.sharedInstance.getJobList(header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.jobList = somecategory
                    self.setUpdata()
                    self.findAJobTableview.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearchJob(searchKey : String, header : String){
        Webservices.sharedInstance.getSearchJobList(searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.searchJobList = somecategory
                    self.setUpdata()
                    self.findAJobTableview.reloadData()
                    
                    print("somecategory=======\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension FindAJobViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return jobList.docs.count
        }else {
            return searchJobList.docs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindAJobTableViewCellJM") as! FindAJobTableViewCellJM
        if isSearching{
            let arrdata = jobList.docs[indexPath.row]
            cell.labelName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.middleName) \(arrdata.mediaHouseID.lastName)")
            cell.keywordName.text = arrdata.jobKeywordName.joined(separator: ", ")
            //            cell.keywordName.text = keys.joined(separator: ", " )
            cell.jobDiscription.text = arrdata.mediaHouseID.organizationName
            cell.workExpLabel.text = ("\(arrdata.workExperience) year")
            cell.cityLabel.text = arrdata.city.name
            cell.salleryLabel.text = "\(arrdata.expectedSalary) \(arrdata.currency)"
            cell.viewDetailsButton.addTarget(self, action: #selector(clickOnViewDetailsButton), for: .touchUpInside)
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
            let url = NSURL(string: getProfileUrl)
            cell.profileImage.sd_setImage(with: url! as URL)
            
            return cell
            
        }else {
            let arrdata = searchJobList.docs[indexPath.row]
            cell.labelName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.middleName) \(arrdata.mediaHouseID.lastName)")
            cell.keywordName.text = arrdata.jobKeywordName.joined(separator: ", ")
            //            cell.keywordName.text = keys.joined(separator: ", " )
            cell.jobDiscription.text = arrdata.mediaHouseID.organizationName
            cell.workExpLabel.text = ("\(arrdata.workExperience) year")
            cell.cityLabel.text = arrdata.city.name
            cell.salleryLabel.text = "\(arrdata.expectedSalary) \(arrdata.currency)"
            cell.viewDetailsButton.addTarget(self, action: #selector(clickOnViewDetailsButton), for: .touchUpInside)
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.mediaHouseID.logo)"
            let url = NSURL(string: getProfileUrl)
            cell.profileImage.sd_setImage(with: url! as URL)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = AppStoryboard.Journalist.viewController(FindAJobDetailViewController.self)
        if isSearching{
            detailVC.detailData = jobList.docs[indexPath.row]
        }else {
            detailVC.detailData = searchJobList.docs[indexPath.row]
        }
        detailVC.detailData = jobList.docs[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    
}

extension FindAJobViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            getSearchJob(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getJobList(header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            getSearchJob(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getJobList(header: currentUserLogin.token)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar == searchingBar {
            isSearching = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchingBar {
            isSearching = false
            searchBar.resignFirstResponder()
        }
    }
    
}


//
//  MyEarningsViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyEarningsViewControllerJM: UIViewController {
    
    @IBOutlet weak var myEaringsTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var totalEarningLabel : UILabel!
    @IBOutlet weak var searchingBar : UISearchBar!
    @IBOutlet weak var totalEarning : UILabel!
    
    var earningData = earningModal()
    var searchEarning = earningModal()
    var searchText = ""
    var isSearching : Bool = true
    
    
    var currentUserLogin : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupTableView()
        setupButton()
        setupUI()
        searchingBar.delegate = self
        self.currentUserLogin = User.loadSavedUser()
        getEarnndData(searchKey: "", header: currentUserLogin.token)
        
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView(){
        self.myEaringsTableView.dataSource = self
        self.myEaringsTableView.delegate = self
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getEarnndData(searchKey : String,header: String){
        Webservices.sharedInstance.getEarningStoryList(searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.earningData = somecategory
                    self.myEaringsTableView.reloadData()
                    self.totalEarningLabel.text = "\(self.earningData.currency) \(String(self.earningData.totalEarning))"
                    self.totalEarning.text = "\(self.earningData.currency) \(String(self.earningData.totalEarning))"
                    //                    self.setupData()
                    //                    self.calculateTime()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getEarnndSearchData(searchKey : String,header: String){
        Webservices.sharedInstance.getEarningStoryList(searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.searchEarning = somecategory
                    self.myEaringsTableView.reloadData()
                    self.totalEarningLabel.text = "\(self.searchEarning.currency) \(String(self.searchEarning.totalEarning))"
                    self.totalEarning.text = "\(self.searchEarning.currency) \(String(self.searchEarning.totalEarning))"
                    //                    self.setupData()
                    //                    self.calculateTime()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
}

extension MyEarningsViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return earningData.storyData.count
        }else {
            return searchEarning.storyData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEarningsTableViewCellJM") as! MyEarningsTableViewCellJM
        if isSearching{
            let arrdata = earningData.storyData[indexPath.row]
            cell.storyCategoryLabel.text = arrdata.storyCategory
            cell.headlineLabel.text = arrdata.headLine
            cell.soldOutLabel.text = "\(arrdata.soldOut) Times"
            cell.earnlabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            //        cell.earnlabel.text = "\(arrdata.currency) \(arrdata.price)"
            
            if arrdata.storyCategory == "Exclusive"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            } else if arrdata.storyCategory == "Shared"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            } else if arrdata.storyCategory == "Free"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            } else if arrdata.storyCategory == "Auction" {
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            } else {
                cell.storyCategoryLabel.isHidden = true
            }
        }else {
            let arrdata = searchEarning.storyData[indexPath.row]
            cell.storyCategoryLabel.text = arrdata.storyCategory
            cell.headlineLabel.text = arrdata.headLine
            cell.soldOutLabel.text = "\(arrdata.soldOut) Times"
            cell.earnlabel.text = "\(arrdata.currency) \(String(arrdata.price))"
            //        cell.earnlabel.text = "\(arrdata.currency) \(arrdata.price)"
            
            if arrdata.storyCategory == "Exclusive"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            } else if arrdata.storyCategory == "Shared"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            } else if arrdata.storyCategory == "Free"{
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            } else if arrdata.storyCategory == "Auction" {
                cell.storyCategoryLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            } else {
                cell.storyCategoryLabel.isHidden = true
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sharedEarningVC = AppStoryboard.Journalist.viewController(SharedEarningViewControllerJM.self)
        if isSearching{
            sharedEarningVC.storyID = earningData.storyData[indexPath.row].id
            
            let arrdata = earningData.storyData[indexPath.row]
            if arrdata.storyCategory == "Exclusive"{
                sharedEarningVC.headingLabel = "Exclusive Earnings"
            } else if arrdata.storyCategory == "Shared"{
                sharedEarningVC.headingLabel = "Shared Earnings"
            } else if arrdata.storyCategory == "Free"{
                sharedEarningVC.headingLabel = "Free Earnings"
            } else if arrdata.storyCategory == "Auction" {
                sharedEarningVC.headingLabel = "Auction Earnings"
            } else {
                sharedEarningVC.headingLabel = "Blog Earnings"
            }
        }else {
            sharedEarningVC.storyID = searchEarning.storyData[indexPath.row].id
            
            let arrdata = searchEarning.storyData[indexPath.row]
            if arrdata.storyCategory == "Exclusive"{
                sharedEarningVC.headingLabel = "Exclusive Earnings"
            } else if arrdata.storyCategory == "Shared"{
                sharedEarningVC.headingLabel = "Shared Earnings"
            } else if arrdata.storyCategory == "Free"{
                sharedEarningVC.headingLabel = "Free Earnings"
            } else if arrdata.storyCategory == "Auction" {
                sharedEarningVC.headingLabel = "Auction Earnings"
            } else {
                sharedEarningVC.headingLabel = "Blog Earnings"
            }
        }
        
        self.navigationController?.pushViewController(sharedEarningVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    
}


extension MyEarningsViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            
            getEarnndSearchData(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getEarnndData(searchKey: "", header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            getEarnndSearchData(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getEarnndData(searchKey: "", header: currentUserLogin.token)
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

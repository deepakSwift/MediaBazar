//
//  InviteCollaborationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class InviteCollaborationViewControllerJM: UIViewController {
    
    @IBOutlet weak var inviteCollaborationTableView : UITableView!
    @IBOutlet weak var createCollButton : UIButton!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    var inviteJournalistData = [invitejournalistListModdal]()
    var inviteSearchJournalistData = [invitejournalistListModdal]()
    var curretUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var isSearching : Bool = true
    var searchText = ""
    
    var selectedJournalistId = [invitejournalistListModdal]()
    //    var selectedJournalistId = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpButton()
        searchingBar.delegate = self
        self.curretUserLogin = User.loadSavedUser()
        getInviteUserData(searchKey: "", header: curretUserLogin.token)
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.inviteCollaborationTableView.dataSource = self
        self.inviteCollaborationTableView.delegate = self
    }
    
    func setUpButton(){
        createCollButton.addTarget(self, action: #selector(preesedcreateCollButton), for: .touchUpInside)
    }
    
    @objc func preesedcreateCollButton(){
        let cretVC = AppStoryboard.Journalist.viewController(CreateCollaborationViewControllerJM.self)
        cretVC.selectedUser = selectedJournalistId
        self.navigationController?.pushViewController(cretVC, animated: true)
    }
    
    func getInviteUserData(searchKey : String, header : String){
        Webservices.sharedInstance.getInviteJournalistList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    // self.countryData.removeAll()
                    self.inviteJournalistData.append(contentsOf: somecategory)
                    self.inviteCollaborationTableView.reloadData()
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func getSearchInviteUserData(searchKey : String, header : String){
        Webservices.sharedInstance.getInviteJournalistList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    // self.countryData.removeAll()
                    self.inviteSearchJournalistData.append(contentsOf: somecategory)
                    self.inviteCollaborationTableView.reloadData()
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension InviteCollaborationViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return inviteJournalistData.count
        } else {
            return inviteSearchJournalistData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InviteCollaborationTableViewCellJM") as! InviteCollaborationTableViewCellJM
        if isSearching{
            let aradata = inviteJournalistData[indexPath.row]
            cell.nameLabel.text = ("\(aradata.firstName) \(aradata.lastName)")
            cell.stateLabel.text = ("\(aradata.langCode) | \(aradata.state.stateName)")
            let getProfileUrl = "\(self.baseUrl)\(aradata.profilePic)"
            let url = NSURL(string: getProfileUrl)
            cell.profileImage.sd_setImage(with: url! as URL)
        } else {
            let aradata = inviteSearchJournalistData[indexPath.row]
            cell.nameLabel.text = ("\(aradata.firstName) \(aradata.lastName)")
            cell.stateLabel.text = ("\(aradata.langCode) | \(aradata.state.stateName)")
            let getProfileUrl = "\(self.baseUrl)\(aradata.profilePic)"
            let url = NSURL(string: getProfileUrl)
            cell.profileImage.sd_setImage(with: url! as URL)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            let aradata = inviteJournalistData[indexPath.row]
            self.selectedJournalistId.append(aradata)
            print("journalistId=====\(selectedJournalistId)")
        } else {
            let aradata = inviteSearchJournalistData[indexPath.row]
            self.selectedJournalistId.append(aradata)
            print("journalistId=====\(selectedJournalistId)")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isSearching{
            for item in selectedJournalistId{
                if item.id == inviteJournalistData[indexPath.row].id{
                    if let tempIndex = selectedJournalistId.firstIndex(of: item){
                        selectedJournalistId.remove(at: tempIndex)
                    }
                }
            }
                //            let userID = self.inviteJournalistData[indexPath.row].id
                //            selectedJournalistId.removeAll(where: { $0 == userID })
                //
                //            print("=selectedJournalistId=======\(selectedJournalistId)")
                
        } else {
            for item in selectedJournalistId{
                if item.id == inviteSearchJournalistData[indexPath.row].id{
                    if let tempIndex = selectedJournalistId.firstIndex(of: item){
                        selectedJournalistId.remove(at: tempIndex)
                    }
                }
            }
            //            let userID = self.inviteSearchJournalistData[indexPath.row].id
            //            selectedJournalistId.removeAll(where: { $0 == userID })
            
        }
        
    }
    
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //
    //            func shouldSelect() -> Bool {
    //                if isSearching{
    //                    for item in selectedJournalistId {
    //                        if item.id == inviteJournalistData[indexPath.row].id {
    //                            return true
    //                        }
    //                    }
    //
    //                } else {
    //                    for item in selectedJournalistId {
    //                        if item.id == inviteSearchJournalistData[indexPath.row].id {
    //                            return true
    //                        }
    //                    }
    //
    //                }
    //
    //                                //                locationArray[indexPath.row].location
    //                return false
    //            }
    //
    //            if shouldSelect() {
    //                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    //            }
    //
    //    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

extension InviteCollaborationViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
            self.searchText = searchBar.text!
            getSearchInviteUserData(searchKey: searchBar.text!, header: curretUserLogin.token)
        } else {
            isSearching = true
            getInviteUserData(searchKey: "", header: curretUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
            self.searchText = searchBar.text!
            getSearchInviteUserData(searchKey: searchBar.text!, header: curretUserLogin.token)
        } else {
            isSearching = true
            getInviteUserData(searchKey: "", header: curretUserLogin.token)
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


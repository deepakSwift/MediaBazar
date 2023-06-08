//
//  EditorsAssignmentsViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditorsAssignmentsViewControllerJM: UIViewController {
    
    @IBOutlet weak var editorsAssignmentTableView : UITableView!
    @IBOutlet weak var searchingBar : UISearchBar!
    
    var editorAssignmentList = listStory()
    var searchEditorData = listStory()
    var isSearching : Bool = true
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        searchingBar.delegate = self
        self.currentUserLogin = User.loadSavedUser()
        setupTableView()
        getEditorList(header: currentUserLogin.token)
        
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.editorsAssignmentTableView.dataSource = self
        self.editorsAssignmentTableView.delegate = self
    }
    
    func getEditorList(header: String){
        Webservices.sharedInstance.getMyEditorAssignmentList(header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.editorAssignmentList = somecategory
                    self.editorsAssignmentTableView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getSearchEditorsAssignment(searchKey : String, header: String){
        Webservices.sharedInstance.getSearchEditorsAssignmentList(searchKey: searchKey, header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.searchEditorData = somecategory
                    self.editorsAssignmentTableView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension EditorsAssignmentsViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return editorAssignmentList.docs.count
        }else {
            return searchEditorData.docs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditorsAssignmentTableViewCellJM") as! EditorsAssignmentTableViewCellJM
        if isSearching{
            let arrdata = editorAssignmentList.docs[indexPath.row]
            cell.journalistName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.middleName) \(arrdata.mediaHouseID.lastName)")
            cell.assignmentTitleLabel.text = arrdata.assignmentTitle
            cell.assignmentDescription.text = arrdata.assignmentDescription
            cell.languageLabel.text = ("\(arrdata.langCode) | \(arrdata.country.name)")
            cell.priceLabel.text = ("$ \(arrdata.price)")
            let url = NSURL(string: arrdata.mediaHouseID.profilePic)
            cell.journaistImage.sd_setImage(with: url! as URL)
            return cell
        }else {
            let arrdata = searchEditorData.docs[indexPath.row]
            cell.journalistName.text = ("\(arrdata.mediaHouseID.firstName) \(arrdata.mediaHouseID.middleName) \(arrdata.mediaHouseID.lastName)")
            cell.assignmentTitleLabel.text = arrdata.assignmentTitle
            cell.assignmentDescription.text = arrdata.assignmentDescription
            cell.languageLabel.text = ("\(arrdata.langCode) | \(arrdata.country.name)")
            cell.priceLabel.text = ("$ \(arrdata.price)")
            let url = NSURL(string: arrdata.mediaHouseID.profilePic)
            cell.journaistImage.sd_setImage(with: url! as URL)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mediaVC = AppStoryboard.Journalist.viewController(MediaHouseAssignmentViewControllerJM.self)
        if isSearching{
            mediaVC.assignmentDetailData = editorAssignmentList.docs[indexPath.row]
        }else {
            mediaVC.assignmentDetailData = searchEditorData.docs[indexPath.row]
        }
        self.navigationController?.pushViewController(mediaVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        //        return UITableView.automaticDimension
    }
    
    
}



extension EditorsAssignmentsViewControllerJM: UISearchBarDelegate {
    //----------- SearchBar Delegate --------------
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != "" && searchBar.text != nil {
            isSearching = false
             getSearchEditorsAssignment(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getEditorList(header: currentUserLogin.token)
        }
        self.searchingBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            isSearching = false
             getSearchEditorsAssignment(searchKey: searchBar.text!, header: currentUserLogin.token)
        } else {
            isSearching = true
            getEditorList(header: currentUserLogin.token)

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

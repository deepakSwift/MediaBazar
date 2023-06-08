//
//  resultViewController.swift
//  MediaBazar
//
//  Created by Sagar Gupta on 15/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class resultViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
//   var enquiryDetail = EnquiryModel()
    var currentUserLogin : User!
    var fromVC = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var enquiryDetail = [EnquiryDocsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if fromVC == "MediaHouseSetting" {
            getMediaEnquiry(page: "0", header: currentUserLogin.mediahouseToken)
        } else {
            getEnquiry(page: "0", header: currentUserLogin.token)
        }
    }
    
    func setUpButton(){
    
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
    }
    
    func apiCall() {
        if fromVC == "MediaHouseSetting" {
            getMediaEnquiry(page: "0", header: currentUserLogin.mediahouseToken)
        } else {
            getEnquiry(page: "0", header: currentUserLogin.token)

        }
    }
    
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func viewFeedbackPressed(){
        let ViewFeedbackVC = AppStoryboard.Stories.viewController(viewFeedbackAlertVC.self)
        ViewFeedbackVC.enquiryDetail = enquiryDetail
        self.present(ViewFeedbackVC, animated: true, completion: nil)
    }
    
    func getEnquiry(page : String,header: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.EnquiryData(page: page, header: header){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.enquiryDetail = somecategory
//                    self.resultTableView.reloadData()
//                    print(somecategory)
                    
                    self.scrollPage = true
                    self.enquiryDetail.append(contentsOf: somecategory.docs)
                    self.resultTableView.reloadData()
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
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getMediaEnquiry(page : String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.EnquiryMediaData(page: page, header: header){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
//                    self.enquiryDetail = somecategory
//                    self.resultTableView.reloadData()
//                    print(somecategory)
                    
                    self.scrollPage = true
                    self.enquiryDetail.append(contentsOf: somecategory.docs)
                    self.resultTableView.reloadData()
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
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


extension resultViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enquiryDetail.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "enquiryResultTableViewCell") as! enquiryResultTableViewCell
        
        let image = enquiryDetail[indexPath.row].mediahouseId.logo
        let getProfileUrl = "\(self.baseUrl)\(image)"//arrdata.journalistId.Image
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            cell.resultImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        cell.resultName.text = enquiryDetail[indexPath.row].enquiryTitle
        cell.resultDetail.text = enquiryDetail[indexPath.row].enquiryDescription
        cell.resultViewFeedback.addTarget(self, action: #selector(viewFeedbackPressed), for: .touchUpInside)
        cell.resultViewFeedback.buttonRoundCorners(borderWidth: 1, borderColor: .black, radius: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
        if !scrollPage { return }
        if (enquiryDetail.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            
            if fromVC == "MediaHouseSetting" {
                getMediaEnquiry(page: "\(page)", header: currentUserLogin.mediahouseToken)
            } else {
                getEnquiry(page: "\(page)", header: currentUserLogin.token)
            }

            
//            getContentData(page: "\(page)", header: currentUserLogin.token)
        }
    }

    
}

//
//  EnquiryVCViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryVCViewControllerJM: UIViewController {

        @IBOutlet weak var enquiryTableView: UITableView!
        @IBOutlet weak var enquiryTopView: UIView!
        @IBOutlet weak var backBtn: UIButton!

        var fromVC = ""
        var baseUrl = "https://apimediaprod.5wh.com/"
        var currenUserLogin : User!
        var getEthicMemberData = MediaStroyModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.currenUserLogin = User.loadSavedUser()
            setUpButton()
            apiCall()
        }
        func setUpButton(){
          backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        }
        
        @objc func backBtnPressed(){
            self.navigationController?.popViewController(animated: true)
        }
        @objc func enquiryBtnTapped(){
            let enquiryPopupVC = AppStoryboard.Journalist.viewController(EnquiryPopUpViewControllerJM.self)
//            if fromVC == "MediaHouseSetting" {
//              enquiryPopupVC.fromVC = "MediaHouseSetting"
//            }
            self.present(enquiryPopupVC, animated: true, completion: nil)
        }
        
        @objc func onClickViewResuletButton(){
            let resultVC = AppStoryboard.Journalist.viewController(ResultViewControllerJM.self)
//            if fromVC == "MediaHouseSetting" {
//              resultVC.fromVC = "MediaHouseSetting"
//            }
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        
        func apiCall() {
            getEthicMember(header: currenUserLogin.token)
        }
        
        
        func getEthicMember(header: String) {
            CommonClass.showLoader()
            Webservices.sharedInstance.ethicMemberEnquiry(header: header) { (result,message,response) in
                print(result)
                CommonClass.hideLoader()
                if result == 200{
                    if let somecategory = response{
                        self.getEthicMemberData = somecategory
                        //self.calculateTime()
                        self.enquiryTableView.reloadData()
                    } else{
                        
                    }
                }else{
                    self.enquiryTableView.reloadData()
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
        
        
        
        
    }

    extension EnquiryVCViewControllerJM: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiryTableViewCellJM1") as! EnquiryTableViewCellJM1
                cell.headMemberImg.image = #imageLiteral(resourceName: "photo-1505503693641-1926193e8d57")
                cell.enquiryBtn.addTarget(self, action: #selector(enquiryBtnTapped), for: .touchUpInside)
                cell.enquiryBtn.buttonRoundCorners(borderWidth: 1, borderColor: .black, radius: 18)
                cell.headMemberName.text = "\(getEthicMemberData.Head.firstName) \(getEthicMemberData.Head.middleName) \(getEthicMemberData.Head.lastName)"
                cell.headMemberTitle.text = getEthicMemberData.Head.accessWrites
                cell.memberDetailLbl.text = getEthicMemberData.Head.descDetails
                let getProfileUrl = "\(self.baseUrl)\(getEthicMemberData.Head.profilePic)"
                if let profileUrls = NSURL(string: (getProfileUrl)) {
                   cell.headMemberImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiryTableViewCellJM2") as! EnquiryTableViewCellJM2
                cell.getData = getEthicMemberData
                cell.memberCollectionView.reloadData()
                cell.viewResultBtn.addTarget(self, action: #selector(onClickViewResuletButton), for: .touchUpInside)
                cell.viewResultBtn.addBottomThinBorderWithColor(.black)
                
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 1 {
                return 300
            }else{
                return 250
            }
            
        }
        
    }


        

            
          
       

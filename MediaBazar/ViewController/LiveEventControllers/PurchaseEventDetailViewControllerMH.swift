//
//  PurchaseEventDetailViewControllerMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseEventDetailViewControllerMH: UIViewController {
    
    @IBOutlet weak var ButtonBack: UIButton!
    @IBOutlet weak var labelProfilename: UILabel!
    @IBOutlet weak var profileSetImg: RoundImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTimeAddress: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelboldTitle: UILabel!
    @IBOutlet weak var buttonShareds: UIButton!
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var dateAndTimeLabel : UILabel!
    
    var newEvent = PurchaseDetailsModel()
    var baseUrl = "https://apimediaprod.5wh.com/"
    var headline = ""
    var time = ""
    var date = ""
    var country = ""
    var currency = ""
    var price = ""
    var descri = ""
    var name = ""
    var profileImage = ""
    var assignmentID = ""
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setUpData()
        self.currentUserLogin = User.loadSavedUser()
        
        // Do any additional setup after loading the view.
        
        print("assignmentID======\(assignmentID)")
    }
    
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        CommonClass.makeViewCircularWithCornerRadius(buttonPay, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        
    }
    
    func setupButton() {
        ButtonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonPay.addTarget(self, action: #selector(onCliclLiveButton), for: .touchUpInside)
    }
    
    func setUpData(){
        
        let getProfileUrl = "\(self.baseUrl)\(profileImage)"
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            profileSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        self.labelTitle.text = self.headline
        self.labelProfilename.text = self.name
        self.labelTimeAddress.text = "\(self.time) | \(self.date) | \(self.country)"
        self.labelPrice.text = "\(currency) \(price)"
        self.labelDescription.text = descri
        self.labelboldTitle.text = "You can watch the Live Conference Cover by \(name)"
        self.dateAndTimeLabel.text = "\(self.date), \(self.time)"
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onCliclLiveButton(){
        getEventStatus(assignmentIds: assignmentID, header: currentUserLogin.mediahouseToken)
//        let detailVC = AppStoryboard.MediaHouse.viewController(LiveVideoShowViewController.self)
//        detailVC.assignmentVideoID = assignmentID
//        detailVC.assignmentHeadline = descri
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getEventStatus(assignmentIds : String, header : String){
        WebService3.sharedInstance.getVideoStatus(assignmentIDs: assignmentIds, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.newEvent = somecategory
                    
                    if self.newEvent.startStatus == 1{
                        let detailVC = AppStoryboard.MediaHouse.viewController(LiveVideoShowViewController.self)
                        detailVC.assignmentVideoID = self.assignmentID
                        detailVC.assignmentHeadline = self.descri
                          self.navigationController?.pushViewController(detailVC, animated: true)
                    } else {
                        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Video not available")
                    }
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

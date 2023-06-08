//
//  CustomerAgreementViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 12/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CustomerAgreementViewController: UIViewController {
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var privacyTextLabel : UILabel!
    
    var privacyData = storyModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        getPrivacyData(type: "customerAgreement")
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
    }
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setUpData(){
        self.privacyTextLabel.text = privacyData.body
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getPrivacyData(type: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.getAppContentData(type: type){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.privacyData = somecategory
                    self.setUpData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

//
//  MediaHouseContractorViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/06/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import WebKit


class MediaHouseContractorViewController: UIViewController {
    
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var webView:WKWebView?
    @IBOutlet weak var contractLabel : UILabel!
    
    var privacyData = storyModal()
    
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        currentUserLogin = User.loadSavedUser()
        if currentUserLogin.userType == "journalist"{
            
             self.contractLabel.text = "Journalist's Master Contract"
            let url = URL(string: "https://5wh.com/static/journalist/contract")!
            webView!.load(URLRequest(url: url))

        }else {
            
            self.contractLabel.text = "Media House Contract"
            let url = URL(string: "https://5wh.com/static/mediahouse/media-house-contract")!
            webView!.load(URLRequest(url: url))
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

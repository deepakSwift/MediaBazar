//
//  JournalisMasterontractorViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 16/06/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import WebKit

class JournalisMasterontractorViewController: UIViewController {

    
        @IBOutlet weak var buttonBack: UIButton!
        @IBOutlet weak var webView:WKWebView?
        
        var privacyData = storyModal()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupButton()
            let url = URL(string: "https://5wh.com/static/journalist/contract")!
            webView!.load(URLRequest(url: url))
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

//
//  TermAndConditionVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import WebKit

class TermAndConditionVC: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var webView:WKWebView?
    
    var termsAndConditionData = storyModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        let url = URL(string: "https://5wh.com/static/journalist/terms")!
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

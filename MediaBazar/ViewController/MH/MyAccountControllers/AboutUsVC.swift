//
// AboutUsVC.swift
// MediaBazar
//
// Created by deepak Kumar on 06/01/20.
// Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import WebKit

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var buttonBack : UIButton!
    @IBOutlet weak var containerView : UIView!
    //@IBOutlet var webView: WKWebView!
    @IBOutlet weak var webView:WKWebView?
    
    //var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        //setupWebView()
        //getAboutUsData(type: "aboutUs")
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://5wh.com/static/journalist/Aboutus")!
        webView!.load(URLRequest(url: url))
        //webView.allowsBackForwardNavigationGestures = true
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

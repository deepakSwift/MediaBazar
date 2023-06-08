//
//  JournalistSocialLinkViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 13/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//
import UIKit
import WebKit

class JournalistSocialLinkViewController: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var webView:WKWebView?

        
    var currentUserLogin : User!
    
    var facebookLink = ""
    var twitterLink = ""
    var linkedInLink = ""
    var snapChatLink = ""
    var youTubeLink = ""
    var instagramlink = ""
    
    var socialLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        currentUserLogin = User.loadSavedUser()
        
        if socialLink == "facebook"{
            let url = URL(string: facebookLink)!
            webView!.load(URLRequest(url: url))
        }else if socialLink == "twitter"{
            let url = URL(string: twitterLink)!
            webView!.load(URLRequest(url: url))
        }else if socialLink == "linkedIn"{
            let url = URL(string: linkedInLink)!
            webView!.load(URLRequest(url: url))
        }else if socialLink == "snapchat"{
            let url = URL(string: snapChatLink)!
            webView!.load(URLRequest(url: url))
        }else if socialLink == "youtube"{
            let url = URL(string: youTubeLink)!
            webView!.load(URLRequest(url: url))
        }else {
            let url = URL(string: instagramlink)!
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

//
//  SupportChatViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SupportChatViewControllerJM: UIViewController {

        @IBOutlet weak var buttonBack: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupButton()
            // Do any additional setup after loading the view.
        }
        
        func setupUI(){
            tabBarController?.tabBar.isHidden = true
        }
        
        func setupButton(){
            buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        }
        
        @objc func backButtonPressed() {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

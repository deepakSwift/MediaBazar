//
//  LiveViewController.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupButton() {
        tabBarController?.tabBar.isHidden = true
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

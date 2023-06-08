//
//  PaymantMethodViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PaymantMethodViewController: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var stripeButton : UIButton!
    
    var fromTranslate = "Translate"
    var storyId = ""
    var price = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()

    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        stripeButton.addTarget(self, action: #selector(pressedStripeButton), for: .touchUpInside)
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func pressedStripeButton(){
        let payNowVC = AppStoryboard.PreLogin.viewController(PayNowVC.self)
        payNowVC.storyId = self.storyId
        payNowVC.price = self.price
        self.navigationController?.pushViewController(payNowVC, animated: true)
    }
    
    
}

//
//  PaymentMethodsEventViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PaymentMethodsEventViewController: UIViewController {
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var stripButton : UIButton!
    @IBOutlet weak var priceLabel : UILabel!
    
    var assignmentIds = ""
    var price = ""
    var currency = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpButton()
        setUpUI()
        print("assignmentIds======\(assignmentIds)")
        // Do any additional setup after loading the view.
        self.priceLabel.text = "\(currency) \(price)"
    }
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
        stripButton.addTarget(self, action: #selector(clickOnStripeButton), for: .touchUpInside)
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnStripeButton(){
        let paymentVC = AppStoryboard.PreLogin.viewController(PayNowVC.self)
        paymentVC.eventPrice = price
        paymentVC.eventAssignmentId = assignmentIds
        paymentVC.event = "eventsPay"
        self.navigationController?.pushViewController(paymentVC, animated: true)

    }
}

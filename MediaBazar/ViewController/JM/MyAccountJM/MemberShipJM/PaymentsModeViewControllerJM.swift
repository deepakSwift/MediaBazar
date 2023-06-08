//
//  PaymentsModeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PaymentsModeViewControllerJM: UIViewController {
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var addCouponButton : UIButton!
    @IBOutlet weak var stripButton : UIButton!
    
    var memberShipID = ""
    var price = ""
    var signupToken = ""
    
    var paymentMediaMembership = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpButton()
        setUpUI()
        print("memberShipID======\(memberShipID)")
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
        addCouponButton.addTarget(self, action: #selector(clickOnAddCouponButton), for: .touchUpInside)
        stripButton.addTarget(self, action: #selector(clickOnStripeButton), for: .touchUpInside)
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnAddCouponButton(){
        let addCouponVC = AppStoryboard.Journalist.viewController(AddCouponViewControllerJM.self)
        self.navigationController?.pushViewController(addCouponVC, animated: true)
    }
    
    @objc func clickOnStripeButton(){
        if paymentMediaMembership == "mediaMembershipPayment"{
            let paymentVC = AppStoryboard.PreLogin.viewController(PayNowVC.self)
            paymentVC.storyId = memberShipID
            paymentVC.price = price
            paymentVC.purchaseMembership = "purchasePlan"
//            paymentVC.signUpToken = signupToken
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }else {
            let paymentVC = AppStoryboard.Journalist.viewController(PayNowViewControllerJM.self)
            paymentVC.memberShipID = memberShipID
            paymentVC.amount = price
            paymentVC.signUpToken = signupToken
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }
        

        
    }
}

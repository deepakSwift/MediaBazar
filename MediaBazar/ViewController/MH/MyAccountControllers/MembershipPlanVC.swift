//
//  MembershipPlanVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MembershipPlanVC: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        buttonBuy.makeRoundCorner(20)
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        buttonBuy.addTarget(self, action: #selector(clickOnBuyButton), for: .touchUpInside)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnBuyButton(){
        let paymentsVC = AppStoryboard.Journalist.viewController(PaymentsViewControllerJM.self)
        self.navigationController?.pushViewController(paymentsVC, animated: true)
    }

}

//
//  BuyExclusiveEventsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class BuyExclusiveEventsVC: UIViewController {
    
    @IBOutlet weak var containerView: CardView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelSubHeading: UILabel!
    @IBOutlet weak var buttonProceedPay: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var butttonback: UIButton!
    @IBOutlet weak var uiViewHeightConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        buttonCancel.makeRoundCorner(20)
        buttonCancel.makeBorder(2, color: .lightGray)
        buttonProceedPay.makeRoundCorner(20)
        uiViewHeightConstraints.constant = containerView.frame.size.height
        
    }
    
    func setupButton() {
        buttonCancel.addTarget(self, action: #selector(buttonCancelPressed), for: .touchUpInside)
        buttonProceedPay.addTarget(self, action: #selector(buttonProceedPayPressed), for: .touchUpInside)
        butttonback.addTarget(self, action: #selector(butttonbackPressed), for: .touchUpInside)
    }
    
    @objc func buttonCancelPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonProceedPayPressed() {
        let paymentVC = AppStoryboard.PreLogin.viewController(PaymantMethodViewController.self)
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    @objc func butttonbackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

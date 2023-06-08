//
//  BuySharedEventVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class BuySharedEventVC: UIViewController {

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
    
    
    var name = ""
    var categoryType = ""
    var languageLabel = ""
    var price = ""
    var file = ""
    var imageurl = ""
    var imageThumbnail = ""
    var desc = ""
    var storyCategory = ""
    var time = ""
    var storyId = ""
    var headline = ""
    var biddingPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        setupData()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        buttonCancel.makeRoundCorner(20)
        buttonCancel.makeBorder(2, color: .lightGray)
        buttonProceedPay.makeRoundCorner(20)
        //uiViewHeightConstraints.constant = labelTitle.frame.size.height + labelDescription.frame.size.height + labelTime.frame.size.height + labelSubHeading.frame.size.height  + labelPrice.frame.size.height + 200
        
    }

    func setupButton() {
        buttonCancel.addTarget(self, action: #selector(buttonCancelPressed), for: .touchUpInside)
        buttonProceedPay.addTarget(self, action: #selector(buttonProceedPayPressed), for: .touchUpInside)
        butttonback.addTarget(self, action: #selector(butttonbackPressed), for: .touchUpInside)
    }
    
    func setupData() {
        labelTime.text = self.time
        labelTitle.text = self.categoryType
        labelDescription.text = self.desc
        labelSubHeading.text = self.headline
        labelPrice.text = self.price
        buttonProceedPay.setTitle("Proceed to pay \(self.price)", for: .normal)
        if self.storyCategory == "Exclusive" {
            buttonShared.setTitle("Exclusive", for: .normal)
            buttonShared.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
        } else if self.storyCategory == "Auction" {
            buttonShared.setTitle("Auction", for: .normal)
            buttonShared.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
        }
    }
  
    @objc func buttonCancelPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonProceedPayPressed() {
        let paymentVC = AppStoryboard.PreLogin.viewController(PaymantMethodViewController.self)
        paymentVC.storyId = self.storyId
        paymentVC.price = self.price
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    @objc func butttonbackPressed() {
        self.navigationController?.popViewController(animated: true)
    }

}

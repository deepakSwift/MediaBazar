//
//  BuyAuctionEventVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class BuyAuctionEventVC: UIViewController {
    
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
    
    var storyId = ""
    var time = ""

    var categoryType = ""
    var price = ""
    var desc = ""
    var storyCategory = ""
    var headline = ""
    var biddingPrice = ""
    var currency = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupData()
        
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
    
    func setupData() {
         labelTime.text = self.time
         labelTitle.text = self.categoryType
         labelDescription.text = self.desc
         labelSubHeading.text = self.headline
         labelPrice.text = self.biddingPrice
         buttonProceedPay.setTitle("Proceed to pay \(self.biddingPrice)", for: .normal)
        buttonShared.setTitle(storyCategory, for: .normal)
        
//         if self.storyCategory == "Exclusive" {
//             buttonShared.setTitle("Exclusive", for: .normal)
//             buttonShared.backgroundColor = #colorLiteral(red: 0.4603235722, green: 0.4996057749, blue: 0.8871493936, alpha: 1)
//         } else if self.storyCategory == "Auction" {
//             buttonShared.setTitle("Auction", for: .normal)
//             buttonShared.backgroundColor = #colorLiteral(red: 0.005891506094, green: 0.1474785805, blue: 0.700207293, alpha: 1)
//         }
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


//extension BuyAuctionEventVC: DismissPopUpDelagate{
//    func NavigateBuyAuction(price: String, StoryId: String, currency: String, categoryType: String, desc: String, storyCategory: String, time: String, haedline: String, biddingPrice: String) {
//        self.price = price
//        self.storyId = StoryId
//        self.currency = currency
//        self.categoryType = categoryType
//        self.desc = desc
//        self.storyCategory = storyCategory
//        self.time = time
//        self.headline = haedline
//        self.biddingPrice = headline
//        
//        print("price==========\(price)")
//        print("storyId==========\(storyId)")
//
//    }
//    
//    
//}

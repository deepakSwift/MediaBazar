//
//  BiddingPricePopUp.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol DismissPopUpDelagate {
    //    func NavigateBuyAuction(price : String, StoryId : String, currency : String, categoryType : String, desc : String, storyCategory : String, time : String, haedline : String, biddingPrice : String)
    func NavigateBuyAuction(price : String)
    
}

class BiddingPricePopUp: UIViewController {
    
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonDismissPopUp: UIButton!
    @IBOutlet weak var priceLabel : UILabel!
    
    var delegate: DismissPopUpDelagate!
    
//    var price = ""
    var currentUserLogin : User!
    var storyId = ""
    
    var currency = ""
    var lastBiddeingPrice = ""
    var auctionBiddingPrice = ""
    var realbiddingPrice = ""
    var biddingPrice = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setUpdata()
        self.currentUserLogin = User.loadSavedUser()
//        self.priceLabel.text = "Enter more than \(currency) \(biddingPrice) for bidding."
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        buttonSubmit.makeRoundCorner(10)
    }
    
    func setupButton() {
        buttonSubmit.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        buttonDismissPopUp.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
    }
    
    func setUpdata(){
        
        if lastBiddeingPrice == ""{
            priceLabel.text = "Enter more than  \(auctionBiddingPrice) for bidding."
        } else {
            priceLabel.text = "Enter more than \(realbiddingPrice) for bidding."
        }
    }
    
    @objc func submitButtonPressed() {
        guard let price = self.textFieldPrice.text, price != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the price greater than than lase bidding price")
            return
        }
        self.dismiss(animated: true) {
//            self.delegate.NavigateBuyAuction(price: self.textFieldPrice.text!)
            self.bidStory(storyID: self.storyId, price: self.textFieldPrice.text!, header: self.currentUserLogin.token)
        }
        
    }
    
    @objc func dismissButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bidStory(storyID : String, price : String, header : String){
        WebService3.sharedInstance.biddingPlaceStory(storyID: storyID, Price: price, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

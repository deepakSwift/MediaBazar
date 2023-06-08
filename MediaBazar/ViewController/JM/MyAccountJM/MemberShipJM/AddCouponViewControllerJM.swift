//
//  AddCouponViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AddCouponViewControllerJM: UIViewController {
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var addTextField : UITextField!

    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpUI()
        setUpButton()
        self.currentUserLogin = User.loadSavedUser()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        topView.applyShadow()
        addButton.makeRoundCorner(20)
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(clickOnAddButton), for: .touchUpInside)

    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnAddButton(){
        
        guard let coupon = addTextField.text, coupon != "" else {
                 NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter coupon.")
                 return
             }
       // covid19
        addCopupon(couponName: addTextField.text!, couponType: "membership", header: currentUserLogin.token)
    }
    
    func addCopupon(couponName: String, couponType: String, header: String){
        Webservices.sharedInstance.checkCoupon(couponName: couponName, couponType: couponType, header: header){(result,message,response) in
            print(result)
            if result == 200{
                self.navigationController?.popViewController(animated: true)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    

 
}

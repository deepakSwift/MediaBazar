//
//  ContactUsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {
    
    @IBOutlet weak var textFiledEmail: UITextField!
    @IBOutlet weak var textFiledName: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    
    var currentUserLogin : User!
    var fromVC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        buttonSend.makeRoundCorner(20)
        buttonSend.addTarget(self, action: #selector(clickOnSendButton), for: .touchUpInside)
    }
    
    func setupTableView() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnSendButton(){
        if fromVC == "SettingVC" {
            if isValidate() {
                postMediaContactUsData(name: textFiledName.text!, emailId: textFiledEmail.text!, message: textView.text!, header: currentUserLogin.mediahouseToken)
            }
        } else {
            if isValidate() {
                postContactUsData(name: textFiledName.text!, emailId: textFiledEmail.text!, message: textView.text!, header: currentUserLogin.token)
            }
        }
    }
    
    func isValidate()-> Bool {
        
        if textFiledName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the name.")
            return false
        } else if textFiledEmail.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email address.")
            return false
        } else if !(textFiledEmail.text?.isValidEmail)! {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email valid address.")
            return false
        } else if textView.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the message.")
            return false
        }
        return true
    }
    
    
    func postContactUsData(name : String, emailId : String, message : String, header: String){
        Webservices.sharedInstance.contactUs(name: name, emailID: emailId, message: message, header: header){
            (result,message,response) in
            
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func postMediaContactUsData(name : String, emailId : String, message : String, header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.mediaContactUs(name: name, emailID: emailId, message: message, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

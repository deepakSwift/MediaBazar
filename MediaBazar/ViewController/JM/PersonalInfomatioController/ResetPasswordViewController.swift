//
//  ResetPasswordViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 06/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var newPassTextField : UITextField!
    @IBOutlet weak var confPassTextField : UITextField!
    

    
    var emailID = ""
    var currentUserLogin : User!
    var iconClick = true
    
    var phoneCode = ""
    var mobileNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setUpUI()
        setUpButton()
        print("========================\(mobileNumber)")

        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        topView.applyShadow()
        continueButton.makeRoundCorner(20)
    }
    
    func setUpButton(){
        continueButton.addTarget(self, action: #selector(clickOnContinueButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
    }
    
    @IBAction func newPassIconAction(sender: AnyObject) {
        if(iconClick == true) {
            newPassTextField.isSecureTextEntry = false
        } else {
            newPassTextField.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func confPassIconAction(sender: AnyObject) {
        if(iconClick == true) {
            confPassTextField.isSecureTextEntry = false
        } else {
            confPassTextField.isSecureTextEntry = true
        }
        
        iconClick = !iconClick
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnContinueButton(){
        

        guard let newpass = newPassTextField.text, newpass != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter new password.")
            return
        }
        
        if newpass.count < 8{
        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Password count should be 8 digits")
            return

        }

        
        guard let confPass = confPassTextField.text,confPass != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter confirm password.")
            return
        }
        
        if confPass.count < 8{
        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Password count should be 8 digits")
            return

        }

        
        if newpass != confPass{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "New password and confirm password should be same!")
            return

        }
        if mobileNumber == ""{
             resetPassword(emailID: emailID, newPassword: newPassTextField.text!, confirmPassword: confPassTextField.text!, header: currentUserLogin.token)
        }else{
            print("=======================\(phoneCode)")
            print("========================\(mobileNumber)")
            resetPasswordWithMobileNumber(phone: phoneCode, mobileNumber: mobileNumber, newPass: newpass, confirmPassword: confPass, header: currentUserLogin.token)
        }
        
    }
    
    func resetPassword(emailID : String, newPassword : String, confirmPassword : String,header : String){
        Webservices.sharedInstance.resetPassword(email: emailID, newPass: newPassword, confirPass: confirmPassword, header: header){
            (result,message,response) in
            if result == 200{
                let changePssPopUp = AppStoryboard.MediaHouse.viewController(ChangePasswordPopUpVC.self)
                changePssPopUp.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                changePssPopUp.modalPresentationStyle = .overFullScreen
                self.present(changePssPopUp,animated:true,completion:{
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats:false, block: {_ in
                        self.dismiss(animated: true, completion: {
                            let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
                            self.navigationController?.pushViewController(loginVC, animated: true)
                        })
                    })})

            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func resetPasswordWithMobileNumber(phone : String,mobileNumber : String,newPass : String,confirmPassword : String, header : String){
        Webservices.sharedInstance.resetPasswordWithMobileNumber(phoneCode: phone, mobileNumber: mobileNumber, newPass: newPass, confirPass: confirmPassword, header: header){
            (result,message,response) in
            if result == 200{
                let changePssPopUp = AppStoryboard.MediaHouse.viewController(ChangePasswordPopUpVC.self)
                changePssPopUp.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                changePssPopUp.modalPresentationStyle = .overFullScreen
                self.present(changePssPopUp,animated:true,completion:{
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats:false, block: {_ in
                        self.dismiss(animated: true, completion: {
                            let loginVC = AppStoryboard.PreLogin.viewController(LoginViewController.self)
                            self.navigationController?.pushViewController(loginVC, animated: true)
                        })
                    })})

            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    

}

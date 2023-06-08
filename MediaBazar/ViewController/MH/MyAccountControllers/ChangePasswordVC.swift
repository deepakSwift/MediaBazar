//
//  ChangePasswordVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var textFiledchangePassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonHideNewPasswd: UIButton!
    @IBOutlet weak var buttonHideConfirmPasswd: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    
    var currentUserLogin : User!
    var fromVC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
    }
    

    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        buttonSave.makeRoundCorner(20)
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonHideNewPasswd.addTarget(self, action: #selector(newPasskButtonPressed), for: .touchUpInside)
        buttonHideConfirmPasswd.addTarget(self, action: #selector(confirmPassButtonPressed), for: .touchUpInside)
        buttonSave.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }

    @objc func backButtonPressed() {
       self.navigationController?.popViewController(animated: true)
    }
    @objc func newPasskButtonPressed() {
        textFieldNewPassword.isSecureTextEntry = !textFieldNewPassword.isSecureTextEntry
        
    }
    @objc func confirmPassButtonPressed() {
        textFieldConfirmPassword.isSecureTextEntry = !textFieldConfirmPassword.isSecureTextEntry
    }
    
    
    @objc func saveButtonPressed() {
        
        if fromVC == "SettingVC" {
            if isValidate() {
                changePasswordMediaHouse(oldPass: textFiledchangePassword.text!, newPass: textFieldNewPassword.text!, header: currentUserLogin.mediahouseToken)
            }
        } else {
            if isValidate() {
               changePassword(oldPass: textFiledchangePassword.text!, newPass: textFieldNewPassword.text!, header: currentUserLogin.token)
            }
        }
        
    }
    
    
    func isValidate()-> Bool {
        
        if textFiledchangePassword.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter current password.")
            return false
        } else if !(textFiledchangePassword.text?.isValidPassword)!{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter valid password.")
            return false
        } else if textFieldNewPassword.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter new password.")
            return false
        } else if textFieldConfirmPassword.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter confirm password.")
            return false
        } else if (textFiledchangePassword.text) == (textFieldNewPassword.text) {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "The old and the new password must not be same.")
            return false
        } else if (textFieldNewPassword.text) != (textFieldConfirmPassword.text)  {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "New password and confirm password do not match.")
            return false
        }
        return true
    }
    
    
    
    func changePassword(oldPass : String, newPass : String,header: String){
        Webservices.sharedInstance.changePassword(oldPassword: oldPass, newPassword: newPass, header: header){
            (result,message,response) in
            
            if result == 200{
                //                print(response)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func changePasswordMediaHouse(oldPass : String, newPass : String,header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.changeMediaPassword(oldPassword: oldPass, newPassword: newPass, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

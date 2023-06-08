//
//  OTPverioficationViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 05/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth


class OTPverioficationViewController: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var buttonView : UIView!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var mobilesubmitButton : UIButton!
    
    @IBOutlet weak var crossButton : UIButton!
    @IBOutlet weak var reSendButtton : UIButton!
    
    @IBOutlet weak var firstElementOTP : UITextField!
    @IBOutlet weak var secondElementOTP : UITextField!
    @IBOutlet weak var thirdElementOTP : UITextField!
    @IBOutlet weak var fourthElementOTP : UITextField!
    @IBOutlet weak var fifthElementOTP : UITextField!
    @IBOutlet weak var sixthElementOTP : UITextField!
    
    var verificationID = ""
    var verificationCode = ""
    var mobileNumber = ""
    var phoneCode = ""
    
    @IBOutlet weak var headingLabel : UILabel!
    
    var emailID = ""
    var otp = ""
    var currentUserLogin : User!
    
    var reSendEmailOTP = ""
    var reSendMobileOTP = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setUpUI()
        setUpButton()
        
        firstElementOTP.delegate = self
        secondElementOTP.delegate = self
        thirdElementOTP.delegate = self
        fourthElementOTP.delegate = self
        fifthElementOTP.delegate = self
        sixthElementOTP.delegate = self
        firstElementOTP.becomeFirstResponder()
        print("Printjghdkfghdjhasdhf======\(mobileNumber)")
        if mobileNumber == ""{
            self.submitButton.isHidden = false
            self.mobilesubmitButton.isHidden = true
        }else{
            self.submitButton.isHidden = true
            self.mobilesubmitButton.isHidden = false
            
        }
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(buttonView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        topView.applyShadow()
        submitButton.makeRoundCorner(20)
        mobilesubmitButton.makeRoundCorner(20)
        headingLabel.text = "We have sent you on \(emailID) with 6 digit verification code."
        //        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    func setUpButton(){
        submitButton.addTarget(self, action: #selector(clickOnSubmitButton), for: .touchUpInside)
        crossButton.addTarget(self, action: #selector(clickOnCrossButton), for: .touchUpInside)
        reSendButtton.addTarget(self, action: #selector(onClickReSendButton), for: .touchUpInside)
    }
    
    @objc func onClickReSendButton(){
        if reSendEmailOTP == "reSendEmail"{
            reSendEmailOTP(email: emailID, header: "")
        } else if reSendMobileOTP == "reSendMobile"{
            reSendMobileNoOTP(phoneCode: phoneCode, MobileNumber: mobileNumber, header: "")
        }
    }
    
    @objc func clickOnCrossButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnSubmitButton(){
        
        guard let otp1 = firstElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp1.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp2 = secondElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp2.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp3 = thirdElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp3.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp4 = fourthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp4.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp5 = fifthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp5.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp6 = sixthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp6.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        otpVerification(email: emailID, otp: "\(otp1)\(otp2)\(otp3)\(otp4)\(otp5)\(otp6)", header: currentUserLogin.token)
        
    }
    
    
    func otpVerification(email: String, otp: String,header: String){
        Webservices.sharedInstance.otpVerification(email: email, otp: otp, header: header){
            (result,message,response) in
            if result == 200{
                let resetPssVC = AppStoryboard.PreLogin.viewController(ResetPasswordViewController.self)
                resetPssVC.emailID = self.emailID
                self.navigationController?.pushViewController(resetPssVC, animated: true)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func otpVerificaationWithMobileNumber(phoneCode : String, mobileNumber : String, otp : String,header : String){
        Webservices.sharedInstance.otpVerificationWithMobileNumber(phoneCode: phoneCode, mobileNumber: mobileNumber, otp: otp, header: header){
            (result,message,response) in
            if result == 200{
                let resetPssVC = AppStoryboard.PreLogin.viewController(ResetPasswordViewController.self)
                resetPssVC.mobileNumber = self.mobileNumber
                print("=====================\(mobileNumber)")
                resetPssVC.phoneCode = self.phoneCode
                self.navigationController?.pushViewController(resetPssVC, animated: true)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    
    func reSendEmailOTP(email: String,header: String){
        Webservices.sharedInstance.forgetPassword(email: email, header: header){
            (result,message,response) in
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func reSendMobileNoOTP(phoneCode : String,MobileNumber : String,header : String){
        Webservices.sharedInstance.forgetPasswordWithMObileNumber(phoneCode: phoneCode, mobileNumber: MobileNumber, header: header){
            (result,message,response) in
            if result == 200{
            NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

    
    
}


extension OTPverioficationViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0){
            if textField == firstElementOTP{
                secondElementOTP.becomeFirstResponder()
            }
            if textField == secondElementOTP{
                thirdElementOTP.becomeFirstResponder()
            }
            if textField == thirdElementOTP{
                fourthElementOTP.becomeFirstResponder()
            }
            if textField == fourthElementOTP{
                fifthElementOTP.becomeFirstResponder()
            }
            if textField == fifthElementOTP{
                sixthElementOTP.becomeFirstResponder()
            }
            if textField == sixthElementOTP{
                sixthElementOTP.resignFirstResponder()
            }
            textField.text = string
        } else if ((textField.text?.count)! >= 1) && (string.count == 0){
            if textField == secondElementOTP{
                firstElementOTP.becomeFirstResponder()
            }
            if textField == thirdElementOTP{
                secondElementOTP.becomeFirstResponder()
            }
            if textField == fourthElementOTP{
                thirdElementOTP.becomeFirstResponder()
            }
            if textField == fifthElementOTP{
                fourthElementOTP.becomeFirstResponder()
            }
            if textField == sixthElementOTP{
                fifthElementOTP.becomeFirstResponder()
            }
            if textField == firstElementOTP{
                sixthElementOTP.resignFirstResponder()
            }
            
            textField.text = ""
            return false
        }else if (textField.text?.count)! >= 1{
            textField.text = string
            return false
        }
        return true
    }
    
    
    @IBAction func onClickSubmitbutton(_ sender : UIButton){
        print("=====verification========\(verificationID)")
        
        guard let otp1 = self.firstElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp1.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp2 = self.secondElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp2.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp3 = self.thirdElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp3.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp4 = self.fourthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp4.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp5 = self.fifthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp5.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        guard let otp6 = self.sixthElementOTP.text else{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        if otp6.count < 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter your otp")
            return
        }
        
        let verificationCodes = "\(otp1)\(otp2)\(otp3)\(otp4)\(otp5)\(otp6)"
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCodes)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil{
                print(error?.localizedDescription ?? "error")
                return
            }
            guard let user = authResult else{return}
            print(user.user.phoneNumber!)
            let resetPssVC = AppStoryboard.PreLogin.viewController(ResetPasswordViewController.self)
            resetPssVC.mobileNumber = self.mobileNumber
            print("========================\(self.mobileNumber)")
            resetPssVC.phoneCode = self.phoneCode
            print("========================\(self.phoneCode)")

            self.navigationController?.pushViewController(resetPssVC, animated: true)
        }
    }
    
}

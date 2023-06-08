//
//  ForgetPasswordViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 17/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony
import FirebaseCore
import FirebaseAuth


class ForgetPasswordViewController: UIViewController{
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var buttonView : UIView!
    @IBOutlet weak var submitButtonView : UIButton!
    @IBOutlet weak var mobileButtonView : UIButton!
    
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var mobileTextField : UITextField!
    @IBOutlet weak var choiceTextField : UITextField!
    
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var contryFlagImage : UIImageView!
    @IBOutlet weak var countryNamelabel : UILabel!
    
    @IBOutlet weak var verifiedButton : UIButton!
    @IBOutlet weak var verifiedMobileButton : UIButton!
    
    
    var currenuserLogin : User!
    let choicePickerView = UIPickerView()
    var cpv : CountryPickerView!
    var selectedCountry : Country!
    
    var phoneCode = ""
    
    var choiceArray = ["Email", "Number"]
    var verificationID : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenuserLogin = User.loadSavedUser()
        choiceTextField.text = choiceArray[0]
        verifiedButton.isHidden = true
        verifiedMobileButton.isHidden = true
        setupUI()
        setupButton()
        handleTap()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(clickOnSubmitButton), for: .touchUpInside)
        countryCodeButton.addTarget(self, action: #selector(onClickCountryCodeButton), for: .touchUpInside)
        
    }
    
    func setupUI(){
        topView.applyShadow()
        buttonView.applyShadow()
        countryPickerSetUp()
        CommonClass.makeViewCircularWithRespectToHeight(submitButton, borderColor: .clear, borderWidth: 20)
        CommonClass.makeViewCircularWithRespectToHeight(mobileButtonView, borderColor: .clear, borderWidth: 20)
        CommonClass.makeViewCircularWithCornerRadius(countryPickerView, borderColor: .gray, borderWidth: 0.5, cornerRadius: 5)
        
        
        
        choiceTextField.inputView = choicePickerView
        choiceTextField.delegate = self
        choicePickerView.dataSource = self
        choicePickerView.delegate = self
        
        emailTextField.delegate = self
        mobileTextField.delegate = self
        
    }
    
    @objc func handleTap(){
        if choiceTextField.text == "Email"{
            countryPickerView.isHidden = true
            emailTextField.isHidden = false
            mobileButtonView.isHidden = true
        } else {
            emailTextField.isHidden = true
            countryPickerView.isHidden = false
            mobileButtonView.isHidden = false
            
        }
    }
    
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func clickOnSubmitButton(){
        
        guard let email = emailTextField.text, email != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter valid email")
            return
        }
        forgetpassword(email: emailTextField.text!, header: currenuserLogin.token)

    }
    
    func forgetpassword(email: String,header: String){
        Webservices.sharedInstance.forgetPassword(email: email, header: header){
            (result,message,response) in
            if result == 200{
                let otpVC = AppStoryboard.PreLogin.viewController(OTPverioficationViewController.self)
                otpVC.emailID = self.emailTextField.text ?? ""
                otpVC.reSendEmailOTP = "reSendEmail"
                self.navigationController?.pushViewController(otpVC, animated: true)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func forgotPasswordWithMobile(phoneCode : String,MobileNumber : String,header : String){
        Webservices.sharedInstance.forgetPasswordWithMObileNumber(phoneCode: phoneCode, mobileNumber: MobileNumber, header: header){
            (result,message,response) in
            if result == 200{
                let otpVC = AppStoryboard.PreLogin.viewController(OTPverioficationViewController.self)
                otpVC.mobileNumber = self.mobileTextField.text!
                print("========================\(self.mobileTextField.text!)")
                
                otpVC.phoneCode = self.phoneCode
                otpVC.verificationID = self.verificationID ?? ""
                otpVC.reSendMobileOTP = "reSendMobile"
                self.navigationController?.pushViewController(otpVC, animated: true)
                
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    @objc func onClickCountryCodeButton(){
        cpv.showCountriesList(from: self)
    }
    
    func countryPickerSetUp() {
        if cpv != nil{
            cpv.removeFromSuperview()
        }
        cpv = CountryPickerView(frame: self.countryPickerView.frame)
        cpv.alpha = 1.0
        self.countryPickerView.addSubview(cpv)
        cpv.showPhoneCodeInView = false
        cpv.showCountryCodeInView = false
        cpv.flagImageView.isHidden = true
        cpv.setCountryByCode(self.currentCountryCode)
        self.selectedCountry = cpv.selectedCountry
        cpv.dataSource = self
        cpv.delegate = self
        cpv.translatesAutoresizingMaskIntoConstraints = false
//        self.countryNamelabel.text = selectedCountry.phoneCode
        self.countryNamelabel.text = "(\(selectedCountry.code)) \(selectedCountry.phoneCode)"
        self.contryFlagImage.image = selectedCountry.flag
        self.phoneCode = selectedCountry.phoneCode
        //self.countryCodeButton.setTitle(self.selectedCountry.phoneCode, for: .normal)
    }
    
}


extension ForgetPasswordViewController: UIPickerViewDataSource, UIPickerViewDelegate ,UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choiceArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choiceArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceTextField.text = choiceArray[row]
        handleTap()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if (emailTextField.text?.isValidEmail)!{
//            verifiedButton.isHidden = false
//        } else if (mobileTextField.text?.isValidMobileNo)! {
//            verifiedButton.isHidden = false
//        } else {
//            verifiedButton.isHidden = true
//        }
//
        
        if (emailTextField.text?.isValidEmail)!{
            verifiedButton.isHidden = false
        } else {
            verifiedButton.isHidden = true
        }

        
        if (mobileTextField.text?.isValidMobileNo)!{
            verifiedMobileButton.isHidden = false
        } else {
            verifiedMobileButton.isHidden = true
        }
        
        
        //        else if !(textFieldMobileNumber.text?.isValidMobileNo)!{
        //            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid mobile number.")
        //            return false
        //        }
        
        
        
    }
    
}



extension ForgetPasswordViewController:CountryPickerViewDataSource, CountryPickerViewDelegate {
    
    
    var currentCountryCode:String{
        let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.subscriberCellularProvider{
            let countryCode = carrier.isoCountryCode
            return (countryCode ?? "US").uppercased()
        }else{
            return (Locale.autoupdatingCurrent.regionCode ?? "US").uppercased()
        }
    }
    
    var countryCode : String {
        get {
            var result = ""
            if let r = kUserDefaults.value(forKey:kCountryCode) as? String{
                result = r
            }
            return result
        }
        set(newCountryCode){
            kUserDefaults.set(newCountryCode, forKey: kCountryCode)
        }
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return (currentCountryCode.count != 0) ? "Current" : nil
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func closeButtonNavigationItem(in countryPickerView: CountryPickerView) -> UIBarButtonItem? {
        return nil
    }
    
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .navigationBar
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.selectedCountry = country
        //self.countryCodeButton.setTitle("\(self.selectedCountry.phoneCode)", for: .normal)
        //        self.countryNamelabel.text = country.phoneCode
        self.phoneCode = country.phoneCode
        self.countryNamelabel.text = "(\(country.code) )"+country.phoneCode
        self.contryFlagImage.image = country.flag
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        if let currentCountry = countryPickerView.getCountryByPhoneCode(currentCountryCode){
            return [currentCountry]
        }else{
            return [countryPickerView.selectedCountry]
        }
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func isValidate()-> Bool {
        if mobileTextField.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mobile number.")
            return false
        }
        else if mobileTextField.text != currenuserLogin.mobileNumber{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Mobile number does not exist.")
            return false
        }
        
        return true
        
    }
    
    @IBAction func onClickMobileNumberVerification(_ sender : UIButton){
        guard let mobile = mobileTextField.text, mobile != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter valid number.")
            return
        }
        if mobile.count < 7{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Mobile number does not exist")
            return
            
        }

        
        let mobileWithcode = "\(phoneCode)\(mobileTextField.text!)"
        print("=================\(mobileWithcode)")
        PhoneAuthProvider.provider().verifyPhoneNumber(mobileWithcode, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: error.localizedDescription)
                
                return
            }
            guard let verificationID = verificationID else{return}
            self.verificationID = verificationID
            print("================\(String(describing: verificationID))")
            self.forgotPasswordWithMobile(phoneCode: self.phoneCode, MobileNumber: mobile, header: self.currenuserLogin.token)
            
        }
    }
}

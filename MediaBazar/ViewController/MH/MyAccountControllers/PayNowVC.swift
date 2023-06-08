//
//  PayNowVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import Stripe

class PayNowVC: UIViewController {
    
    @IBOutlet weak var textFieldCardNumer: BKCardNumberField!
    @IBOutlet weak var textFieldExpiryDate: BKCardExpiryField!
    @IBOutlet weak var textFieldHolderName: UITextField!
    @IBOutlet weak var textFieldCCV: UITextField!
    @IBOutlet weak var payButton : UIButton!
    @IBOutlet weak var buttonBack : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var storyId = ""
    var price = ""
    var currenUserLogin : User!
    
    var selectServiceType = ""
    var email = ""
    var language = ""
    var fileDataText = Data()
    var fileDataVideo = Data()
    var fileSize = ""
    var filePrice = ""
    var fileType = ""
    var translateAndTranscribePay = ""
    
    var eventPrice = ""
    var eventAssignmentId = ""
    var event = ""
    
    var purchaseMembership = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        //textFieldHolderName.text = "Rahul"
        // Do any additional setup after loading the view.
        
        print("selectServiceType=====\(selectServiceType)")
        print("email=====\(email)")
        print("language======\(language)")
        print("fileData====\(fileDataText)")
        print("fileData====\(fileDataVideo)")
        print("fileSize=====\(fileSize)")
        print("filePrice====\(filePrice)")
        print("fileType=====\(fileType)")
        
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        payButton.addTarget(self, action: #selector(onClickPay), for: .touchUpInside)
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(payButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func payNowMembershipPlans(amount: String, paymentMode: String, transactionId: String, membershipID: String, header: String){
        Webservices.sharedInstance.mediaMemberShipPayments(amount: amount, paymentMode: paymentMode, transactionID: transactionId, memberShipID: membershipID, header: header){(result,message,response) in
            print(result)
            if result == 200{
                
//                self.navigationController?.popToRoot(true)
                
//                let splashScreen = AppStoryboard.PreLogin.viewController(SplashScreenViewController.self)
//                splashScreen.newUserSignUp = "membershipPlan"
//                self.navigationController?.pushViewController(splashScreen, animated: true)
                
                let homeVC = AppStoryboard.MediaHouse.viewController(TabBarController.self)
                self.navigationController?.pushViewController(homeVC, animated: true)
                
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

    
    func payNow(amount: String, paymentMode: String, transactionId: String, storyId: String, header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.paymentNow(amount: amount, paymentMode: paymentMode, storyId: storyId, transactionId: transactionId, header: header ) { (result,message,response) in
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
    
    func translateAndTranscribePay(audio: String?, video: Data?, Document: Data?, emailId : String, serviceType: String, toLanguage: String, fileType: String, fileSize: String, amount: String, transactionID: String, header: String ){
        WebService3.sharedInstance.translate(audio: audio, video: video, text: Document, emailId: emailId, serviceType: serviceType, toLanguage: toLanguage, fileType: fileType, fileSize: fileSize, amount: amount, transactionID: transactionID, header: header){ (result, response, message) in
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                self.navigationController?.popViewController(animated: true)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func eventPayment(assignmentID : String, amount: String, paymentMode : String, transationId : String, header: String){
        WebService3.sharedInstance.paymentNewEvent(assignmentID: assignmentID, amount: amount, paymentMode: paymentMode, transactionID: transationId, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

    
    
    func createTokenAndProceedPayWith(_ cardNumber:String,expMonth: UInt,expYear:UInt,CVV:String){
        
        //CommonClass.showLoader(withStatus: "Connecting..")
        let cardParams = STPCardParams()
        cardParams.number = cardNumber
        //        if cardHolderName.count != 0{
        //            cardParams.name = cardHolderName
        //        }
        cardParams.expMonth = expMonth
        cardParams.expYear = expYear
        cardParams.cvc = CVV
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (stpToken, error) in
            if error != nil{
                CommonClass.hideLoader()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "\(String(describing: error!.localizedDescription))")
                self.payButton.isEnabled = true
                return
            }else{
                guard let token = stpToken else{
                    CommonClass.hideLoader()
                    self.payButton.isEnabled = true
                    return
                }
                
                CommonClass.updateLoader(withStatus: "Paying..")
                print("=======================\(token)")
                //------ApiCall--------
                
                if self.translateAndTranscribePay == "payAmount"{
                    self.translateAndTranscribePay(audio: "", video: self.fileDataVideo, Document: self.fileDataText, emailId: self.email, serviceType: self.selectServiceType, toLanguage: self.language, fileType: self.fileType, fileSize: self.fileSize, amount: self.filePrice, transactionID: "\(token)", header: self.currenUserLogin.mediahouseToken)
                }else if self.event == "eventsPay"{
                    self.eventPayment(assignmentID: self.eventAssignmentId, amount: self.eventPrice, paymentMode: "stripe", transationId: "\(token)", header: self.currenUserLogin.mediahouseToken)
                }else if self.purchaseMembership == "purchasePlan" {
                    self.payNowMembershipPlans(amount: self.price, paymentMode: "stripe", transactionId:"\(token)", membershipID: self.storyId, header: self.currenUserLogin.mediahouseToken)
                }else {
                        self.payNow(amount: self.price, paymentMode: "stripe", transactionId: "\(token)", storyId: self.storyId, header: self.currenUserLogin.mediahouseToken)
                }
                //                self.payNow(amount: self.price, paymentMode: "stripe", transactionId: "\(token)", storyId: self.storyId, header: self.currenUserLogin.mediahouseToken)
                
            }
        }
    }
    
    func validteCardInputs(_ cardNumber:String,brand:String,expMonth: Int?,expYear:Int?,CVV:String) -> (success:Bool,message:String) {
        if cardNumber.count == 0{
            return(false,warningMessage.validCardNumber.rawValue)
        }
        
        //        if cardHolderName.count == 0{
        //            return(false,warningMessage.cardHolderName.rawValue)
        //        }
        
        if let expMon = expMonth{
            if (expMon < 1) || (expMon > 12){return(false,warningMessage.validExpMonth.rawValue)}
        }else{
            return(false,warningMessage.expMonth.rawValue)
        }
        
        if !brand.lowercased().contains("maestro"){
            if (CVV.count < 3) || (CVV.count > 4){return(false,warningMessage.enterCVV.rawValue)}
        }
        return(true,"")
        
    }
    
    func validateCardParams(_ cardNumber:String,expMonth: UInt,expYear:UInt,CVV:String) -> Bool {
        let cardParams = STPCardParams()
        cardParams.number = cardNumber
        //        if cardHolderName.count != 0{
        //            cardParams.name = cardHolderName
        //        }
        cardParams.expMonth = expMonth
        cardParams.expYear = expYear
        cardParams.cvc = CVV
        let validationState = STPCardValidator.validationState(forCard: cardParams)
        return (validationState != .invalid)
    }
    
    
    
    @objc func onClickPay(){
        //validate card params
        self.view.endEditing(true)
        guard let cardNumber = self.textFieldCardNumer.cardNumber  else {
            self.payButton.isEnabled = true
            return
        }
        if cardNumber.count < 14{
            self.payButton.isEnabled = true
            
            return
        }
        //       if textFieldHolderName.text == nil || textFieldHolderName.text?.count == 0{
        //           self.payButton.isEnabled = true
        //
        //           return
        //       }
        //       guard let cardHolderName = self.textFieldHolderName.text?.trimmingCharacters(in: .whitespaces) else{
        //           //NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.cardHolderName.messageString())
        //
        //           self.payButton.isEnabled = true
        //
        //           return
        //       }
        //
        guard let cardNumberFormatter = self.textFieldCardNumer.cardNumberFormatter else{
            self.payButton.isEnabled = true
            //NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.cardDeclined.messageString())
            return
        }
        
        guard let cardPattern = cardNumberFormatter.cardPatternInfo else {
            self.payButton.isEnabled = true
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Please enter a valid card number".localizedString)
            return
        }
        guard let brand = cardPattern.companyName else {
            self.payButton.isEnabled = true
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.cardDeclined.messageString())
            return
        }
        
        if textFieldCCV.text == nil || textFieldCCV.text!.count < 3 || textFieldCCV.text!.count > 4 {
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.enterCVV.messageString())
            self.payButton.isEnabled = true
            
            return
        }
        guard let cvv = self.textFieldCCV.text?.trimmingCharacters(in: .whitespaces) else{
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.enterCVV.messageString())
            self.payButton.isEnabled = true
            
            return
        }
        guard let expMonth = self.textFieldExpiryDate.dateComponents.month else{
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.expMonth.messageString())
            self.payButton.isEnabled = true
            
            return
        }
        guard let expYear = self.textFieldExpiryDate.dateComponents.year else{
            // NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.expYear.messageString())
            self.payButton.isEnabled = true
            
            return
        }
        //        if !self.isTermsAccepted{
        //            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please accept terms and conditions")
        //            return
        //        }
        
        let inputValidation = self.validteCardInputs(cardNumber, brand: brand, expMonth: expMonth, expYear: expYear, CVV: cvv)
        if !inputValidation.success{
            NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: inputValidation.message)
            self.payButton.isEnabled = true
            return
        }
        
        let success = self.validateCardParams(cardNumber,expMonth: UInt(expMonth ), expYear: UInt(expYear ), CVV: cvv)
        if !success{
            //NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: warningMessage.cardDeclined.messageString())
            self.payButton.isEnabled = true
            
            return
        }
        
        self.createTokenAndProceedPayWith(cardNumber, expMonth: UInt(expMonth), expYear: UInt(expYear), CVV: cvv)
    }
    
}





//
//  EnquiryPopUpViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryPopUpViewControllerJM: UIViewController {
    
    
    @IBOutlet weak var enquiryPopupView: UIView!
    @IBOutlet weak var enquiryPopUpDismisBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var briefDescriptionlbl: UILabel!
    @IBOutlet weak var briefDescriptionTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var currentUserLogin : User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupButton()
        
    }
    
    func setupButton(){
        enquiryPopUpDismisBtn.addTarget(self, action: #selector(enquiryPopUpDismisBtnTapped), for: .touchUpInside)
        submitBtn.buttonRoundCorners(borderWidth: 1, borderColor: .black, radius: 15)
        briefDescriptionTextField.makeBorder(1, color: .gray)
        submitBtn.addTarget(self, action: #selector(submitEnquiry), for: .touchUpInside)
        
    }
    
    @objc func enquiryPopUpDismisBtnTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func submitEnquiry(){
        if self.isValidate() {
            getEnquiryPost(enquiryTitle: titleTxt.text!, header: currentUserLogin.token, enquiryDescription: briefDescriptionTextField.text!)
        }
        
    }
    
    //------TextFields Validations-------
    
    func isValidate()-> Bool {
        
        if titleTxt.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the title.")
            return false
        }
        else if briefDescriptionTextField.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the brief description.")
            return false
        }
        return true
    }
    
    func getEnquiryPost(enquiryTitle: String,header: String, enquiryDescription: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.postEnquiryData(enquiryTitle: enquiryTitle, enquiryDescription: enquiryTitle, header: header){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    print(somecategory)
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

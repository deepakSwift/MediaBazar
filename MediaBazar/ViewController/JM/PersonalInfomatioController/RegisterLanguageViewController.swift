//
//  RegisterLanguageViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


class RegisterLanguageViewController: UIViewController {
    
    @IBOutlet weak var textFieldLanguage: UITextField!
    @IBOutlet weak var designationTextField : UITextField!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
//    @IBOutlet weak var designationButton : UIButton!
    
    
    let designationPickerView = UIPickerView()
    var designationArray = [DesignationModel]()
    var langData = ""
    var designationId = ""
    var designationName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        getDesignation()
    }
    
    
    func setupButton(){
//        designationButton.addTarget(self, action: #selector(selectLanguageTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(pressedContinueButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        
        designationTextField.inputView = designationPickerView
        designationTextField.delegate = self
        designationPickerView.dataSource = self
        designationPickerView.delegate = self
        textFieldLanguage.delegate = self
    }

    
    
//    @objc func selectLanguageTapped(){
//        let preLangugeVC = AppStoryboard.PreLogin.viewController(PreferedLanguageViewController.self)
//        preLangugeVC.delegate = self
//        self.navigationController?.pushViewController(preLangugeVC, animated: true)
//    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func pressedContinueButton(){
        
        
        if isValidate() {

            
            if designationTextField.text == "Journalist" {
                let infoVC = AppStoryboard.PreLogin.viewController(PersonalInformationViewController.self)
                self.navigationController?.pushViewController(infoVC, animated: true)
            } else if designationTextField.text == "Media House" {
                let mediaHouseVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanyPersonalInfoVC") as! CompanyPersonalInfoVC
                mediaHouseVC.designationId = self.designationId
                self.navigationController?.pushViewController(mediaHouseVC, animated: true)
            }
        }
        
//        let infoVC = AppStoryboard.PreLogin.viewController(PersonalInformationViewController.self)
//        self.navigationController?.pushViewController(infoVC, animated: true)
        
    }
    
    func getDesignation(){
        CommonClass.showLoader()
        Webservice.sharedInstance.designationData(){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.designationArray.removeAll()
                    self.designationArray.append(contentsOf: somecategory)
                    //self.designationPickerView.reloadData()
                } 
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        if textFieldLanguage.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the language.")
            return false
        }
        else if designationTextField.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the designation")
            return false
        }
        return true
    }
    
}

extension RegisterLanguageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return designationArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return designationArray[row].text
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        designationTextField.text = designationArray[row].text
        self.designationName = designationArray[row].text
        self.designationId = designationArray[row].id
        print("designationName======\(designationName)")
    }
    
}

extension RegisterLanguageViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldLanguage {
            let preLangugeVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
            preLangugeVC.delegate = self
            self.present(preLangugeVC, animated: true, completion: nil)
        }
    }
    
}


extension RegisterLanguageViewController: SendNameOfLanguage {
    func languageName(name: String, id: String, langKey: String) {
        textFieldLanguage.resignFirstResponder()
        if name == "" && id == "" && langKey == ""{
            return
        }
        
        textFieldLanguage.text = name
        
        var langObject: [String:String] = [:]
        langObject.updateValue(id, forKey: "lang_id")
        langObject.updateValue(name, forKey: "lang_name")
        langObject.updateValue(langKey, forKey: "lang_key")
        let jsonData = try! JSONSerialization.data(withJSONObject: langObject, options: .prettyPrinted)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            langData = jsonString
        }
    }
}









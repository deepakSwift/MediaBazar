//
//  CompanySetPasswordInfoVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CompanySetPasswordInfoVC: UIViewController {

    @IBOutlet weak var buttonConitnue: UIButton!
    @IBOutlet weak var buttonHideConfirmPass: UIButton!
    @IBOutlet weak var buttonHideCreatePass: UIButton!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var textFieldCreatePassword: UITextField!
    @IBOutlet weak var textFieldZipCode: UITextField!
    @IBOutlet weak var textFieldCurrency: UITextField!
    @IBOutlet weak var textFieldCountryName: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    
    let currencyPickerView = UIPickerView()
    var currencyArray = ["Entertainment","Music","Dance"]
    
    let countryPickerView = UIPickerView()
    var countryArray = ["Entertainment","Music","Dance"]
    
    let statePickerView = UIPickerView()
    var stateArray = ["Entertainment","Music","Dance"]
    
    let cityPickerView = UIPickerView()
    var cityArray = ["Entertainment","Music","Dance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupPickerView()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        buttonConitnue.makeRoundCorner(20)
    }
    
    func setupPickerView(){
        textFieldCurrency.inputView = currencyPickerView
        textFieldCurrency.delegate = self
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        
        textFieldCountryName.inputView = countryPickerView
        textFieldCountryName.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        
        textFieldState.inputView = statePickerView
        textFieldState.delegate = self
        statePickerView.dataSource = self
        statePickerView.delegate = self
        
        textFieldCity.inputView = cityPickerView
        textFieldCity.delegate = self
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
    }
    
    func setupButton(){
        buttonHideCreatePass.addTarget(self, action: #selector(newPasskButtonPressed), for: .touchUpInside)
        buttonHideConfirmPass.addTarget(self, action: #selector(confirmPassButtonPressed), for: .touchUpInside)
        buttonConitnue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
    }
    
    @objc func newPasskButtonPressed() {
        textFieldCreatePassword.isSecureTextEntry = !textFieldCreatePassword.isSecureTextEntry
    }
    @objc func confirmPassButtonPressed() {
        textFieldConfirmPassword.isSecureTextEntry = !textFieldConfirmPassword.isSecureTextEntry
    }
    
    @objc func continueButtonpressed() {
        let setAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanyAddressInfoVC") as! CompanyAddressInfoVC
        self.navigationController?.pushViewController(setAddressVC, animated: true)
    }
    
}

//---PickerView----
extension CompanySetPasswordInfoVC: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == currencyPickerView {
            return currencyArray.count
        } else if pickerView == countryPickerView {
            return countryArray.count
        } else if pickerView == statePickerView {
            return stateArray.count
        } else {
             return cityArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == currencyPickerView {
            return currencyArray[row]
        } else if pickerView == countryPickerView {
            return countryArray[row]
        } else if pickerView == statePickerView {
            return stateArray[row]
        } else {
            return cityArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == currencyPickerView {
            textFieldCurrency.text = currencyArray[row]
        } else if pickerView == countryPickerView {
             textFieldCountryName.text = countryArray[row]
        } else if pickerView == statePickerView {
             textFieldState.text = stateArray[row]
        } else {
             textFieldCity.text = cityArray[row]
        }
        
    }
}



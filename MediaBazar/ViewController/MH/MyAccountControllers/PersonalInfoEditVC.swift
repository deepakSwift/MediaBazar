//
//  PersonalInfoEditVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 11/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony

class PersonalInfoEditVC: UIViewController {

    @IBOutlet weak var textFiledOrganisationName: UITextField!
    @IBOutlet weak var textFiledType: UITextField!
    @IBOutlet weak var TextFiledFirstName: UITextField!
    @IBOutlet weak var TextFiledLastName: UITextField!
    @IBOutlet weak var TextFiledMiddleName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var contryFlagImage : UIImageView!
    @IBOutlet weak var countryNamelabel : UILabel!
    @IBOutlet weak var textViewShortBio: UITextView!
    @IBOutlet weak var textViewmailingAddress: UITextView!
    @IBOutlet weak var textFieldZipCode: UITextField!
    @IBOutlet weak var textFieldCurrency: UITextField!
    @IBOutlet weak var textFieldCountryName: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var buttonBack: UIButton!
    
    var getCompanyData = CompanyProfileModel()
    var cpv : CountryPickerView!
    var selectedCountry : Country!
    var imagePicker = UIImagePickerController()
    var countryData = ""
    var stateData = ""
    var cityData = ""
    var countryId = ""
    var stateId = ""
    var mediaTypeId = ""
    var currencyCode = ""
    var getaData = SocialMedialinkModel()
    var editInfo = false
    var currenUserLogin : User!
    
    var currentCountryCodeName = "US"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupPickerView()
        setupData()
        self.currenUserLogin = User.loadSavedUser()
        
    }
    
    func setupUI() {
        countryPickerSetUp()
        buttonContinue.makeRoundCorner(20)
        CommonClass.makeViewCircularWithCornerRadius(textViewmailingAddress, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(textViewShortBio, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(countryPickerView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 1)
    }
    
    func setupPickerView(){
        textFiledType.delegate = self
        textFieldState.delegate = self
        textFieldCity.delegate = self
        textFieldCountryName.delegate = self
        textFieldCurrency.delegate = self
//        typePickerView.dataSource = self
//        typePickerView.delegate = self
    }
    
    func setupButton(){
        buttonContinue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
        countryCodeButton.addTarget(self, action: #selector(onClickCountryCodeButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(onClickBackBtn), for: .touchUpInside)
    }

    @objc func continueButtonpressed() {
        if isValidate() {
            editPersonalInfoApi(emailId: textFieldEmail.text!, mobileNumber: textFieldMobileNumber.text!, firstName: TextFiledFirstName.text!, middleName: TextFiledMiddleName.text!, lastName: TextFiledLastName.text!, designationId: getCompanyData.designationId, langCode: getCompanyData.langCode, currency: currencyCode, pinCode: textFieldZipCode.text!, shortBio: textViewShortBio.text!, country: countryData, state: stateData, city: cityData, stepCount: "1", organizationName: textFiledOrganisationName.text!, mediahouseTypeId: mediaTypeId, mailingAddress: textViewmailingAddress.text!, header: currenUserLogin.mediahouseToken)
        }
    }
    
    @objc func onClickBackBtn(){
        self.navigationController?.popViewController(animated: true)
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
        self.countryNamelabel.text = "(\(selectedCountry.code)) \(selectedCountry.phoneCode)"
//        self.countryNamelabel.text = selectedCountry.phoneCode
        self.contryFlagImage.image = selectedCountry.flag
        //self.countryCodeButton.setTitle(self.selectedCountry.phoneCode, for: .normal)
        
        print("selectedCountryCode =======\(selectedCountry.code)")
        print("selectedCountryPhoneCode======\(selectedCountry.phoneCode)")
    }
    
    func setupData() {
        mediaTypeId = getCompanyData.mediahouseTypeId.Id
        textFiledType.text = getCompanyData.mediahouseTypeId.mediahouseTypeName
        textFiledOrganisationName.text = getCompanyData.organizationName
        TextFiledFirstName.text = getCompanyData.firstName
        TextFiledMiddleName.text = getCompanyData.middleName
        TextFiledLastName.text = getCompanyData.lastName
        textFieldEmail.text = getCompanyData.emailId
        textFieldMobileNumber.text = getCompanyData.mobileNumber
        textFieldCountryName.text = getCompanyData.country.name
        self.currencyCode = getCompanyData.country.currencyCode
        textFieldCurrency.text = getCompanyData.country.currencyName
        textFieldState.text = getCompanyData.state.stateName
        textFieldCity.text = getCompanyData.city.name
        textFieldZipCode.text = getCompanyData.pinCode
        textViewShortBio.text = getCompanyData.shortBio
        textViewmailingAddress.text = getCompanyData.mailingAddress
        countryNamelabel.text = "(\(getCompanyData.nameCode) ) \(String(getCompanyData.phoneCode))"
        currentCountryCodeName = getCompanyData.nameCode

        
        //countryData
        var tempCountryData: [String:String] = [:]
         tempCountryData.updateValue(getCompanyData.country.placeId, forKey: "id")
         tempCountryData.updateValue(getCompanyData.country.sortName, forKey: "sortname")
         tempCountryData.updateValue(getCompanyData.country.name, forKey: "name")
         tempCountryData.updateValue(getCompanyData.country.phoneCode, forKey: "phonecode")
         tempCountryData.updateValue(getCompanyData.country.symbol, forKey: "symbol")
         tempCountryData.updateValue(getCompanyData.country.currencyName, forKey: "currencyName")
        
         let jsonData = try! JSONSerialization.data(withJSONObject: tempCountryData, options: .prettyPrinted)
         if let jsonString = String(data: jsonData, encoding: .utf8) {
             print(jsonString)
             countryData = jsonString
         }
        
        //cityData
        var cityObject: [String:String] = [:]
        cityObject.updateValue(getCompanyData.city.placeId, forKey: "id")
         cityObject.updateValue(getCompanyData.city.sortName, forKey: "sortname")
         cityObject.updateValue(getCompanyData.city.name, forKey: "name")
         cityObject.updateValue(getCompanyData.city.phoneCode, forKey: "phonecode")
         cityObject.updateValue(getCompanyData.city.symbol, forKey: "symbol")
         cityObject.updateValue(getCompanyData.city.currencyName, forKey: "currencyName")
        
         let cityJsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
         if let jsonString = String(data: cityJsonData, encoding: .utf8) {
             print(jsonString)
             cityData = jsonString
         }
        
        
        var stateObject: [String:String] = [:]
        stateObject.updateValue(getCompanyData.state.stateId, forKey: "id")
        stateObject.updateValue(getCompanyData.state.stateName, forKey: "name")
        stateObject.updateValue(getCompanyData.state.countryId, forKey: "state_id")
        
        let stateJsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        
        if let jsonString = String(data: stateJsonData, encoding: .utf8) {
            print(jsonString)
            stateData = jsonString
        }
    }
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
         if textFiledType.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the type.")
            return false
        }
        else if textFiledOrganisationName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the organisation name.")
            return false
        }
        else if TextFiledFirstName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name.")
            return false
        }
        else if TextFiledMiddleName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
            return false
        }
        else if TextFiledLastName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
            return false
        }
        else if textFieldEmail.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email address.")
            return false
        }
        else if !(textFieldEmail.text?.isValidEmail)!{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid email address.")
            return false
        }
        else if textFieldMobileNumber.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mobile number.")
            return false
        }
        else if !(textFieldMobileNumber.text?.isValidMobileNo)!{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid mobile number.")
            return false
        }
        else if textFieldCountryName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the choose the country.")
            return false
        }
        else if textFieldCurrency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the preferred currency.")
            return false
        }
        else if textFieldState.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the state.")
            return false
        }
        else if textFieldCity.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the city.")
            return false
        }
        else if textFieldZipCode.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the pincode.")
            return false
        }
        else if textViewShortBio.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the brief description.")
            return false
        }
        else if textViewmailingAddress.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mailing address.")
            return false
        }
        return true
    }
    
    //----------ApiCall------------
    func editPersonalInfoApi(emailId: String, mobileNumber: String, firstName: String, middleName: String, lastName: String, designationId: String, langCode: String, currency: String, pinCode: String, shortBio: String, country: String, state: String, city: String, stepCount: String, organizationName: String, mediahouseTypeId: String, mailingAddress: String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.editPersonalInfo(emailId: emailId, mobileNumber: mobileNumber, firstName: firstName, middleName: middleName, lastName: lastName, designationId: designationId, langCode: langCode,currency: currency, pinCode: pinCode, shortBio: shortBio, country: country, state: state, city: city, stepCount: stepCount, organizationName: organizationName, mediahouseTypeId: mediahouseTypeId, mailingAddress: mailingAddress,header: header) { (result,response,message) in
            CommonClass.hideLoader()
            if result == 200 {
                
                if let somecategory = response {
                    self.getaData = somecategory
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
          }
        }
    }
    
    

// -- CountryPickerView ---
extension PersonalInfoEditVC:CountryPickerViewDataSource, CountryPickerViewDelegate {
    
    var currentCountryCode:String{
        let networkInfo = CTTelephonyNetworkInfo()
        if let carrier = networkInfo.subscriberCellularProvider{
            let countryCode = carrier.isoCountryCode
            return (countryCode ?? currentCountryCodeName).uppercased()
        }else{
            return (Locale.autoupdatingCurrent.regionCode ?? currentCountryCodeName).uppercased()
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
        
        self.countryNamelabel.text = "(\(country.code) )"+country.phoneCode
//        self.countryNamelabel.text = country.phoneCode
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
}

//------- TextField delegate ------
extension PersonalInfoEditVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textFiledType {
            let mediaTypeVC = AppStoryboard.PreLogin.viewController(MediaHouseTypeSearchVC.self)
            mediaTypeVC.delegate = self
            self.present(mediaTypeVC, animated: true, completion: nil)
            
        } else if textField == textFieldCountryName {
            let countryListSearchVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
            countryListSearchVC.delegate = self
            self.present(countryListSearchVC, animated: true, completion: nil)
            
        } else if textField == textFieldState {
            if textFieldCountryName.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryId
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == textFieldCity {
            if textFieldCountryName.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if textFieldState.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else {
                let citySearchVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
                citySearchVC.delegate = self
                citySearchVC.stateId = stateId
                self.present(citySearchVC, animated: true, completion: nil)
            }
        }
    }
}


//------ getMediaType -------
extension PersonalInfoEditVC: SendNameOfMediaType {
    func countryName(name: String, id: String) {
        textFiledType.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFiledType.text = name
        mediaTypeId = id
    }
}

extension PersonalInfoEditVC: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        textFieldCountryName.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }

        self.textFieldCountryName.text = name
        self.countryId = id
        // convert Response into json Object
        var cityObject: [String:String] = [:]
        cityObject.updateValue(id, forKey: "id")
        cityObject.updateValue(sortName, forKey: "sortname")
        cityObject.updateValue(name, forKey: "name")
        cityObject.updateValue(phoneCode, forKey: "phonecode")
        cityObject.updateValue(symbol, forKey: "symbol")
        cityObject.updateValue(currencyName, forKey: "currencyName")
       
        let jsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            countryData = jsonString
        }
    }
}

extension PersonalInfoEditVC: SendNameOfState {
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
        textFieldState.resignFirstResponder()
        if name == "" && id == "" && countyId == "" && symobol == "" && currencyName == ""{
            return
        }
        self.textFieldState.text = name
         self.stateId = id
        // convert Response into json Object
        var stateObject: [String:String] = [:]
        stateObject.updateValue(id, forKey: "id")
        stateObject.updateValue(name, forKey: "name")
        stateObject.updateValue(countyId, forKey: "country_id")
        stateObject.updateValue(symobol, forKey: "symbol")
        stateObject.updateValue(currencyName, forKey: "currencyName")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: stateObject, options: .prettyPrinted)
        
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            stateData = jsonString
        }
    }
}


extension PersonalInfoEditVC: SendNameOfCity {
    func cityName(name: String, id: String, stateId: String) {
        textFieldCity.resignFirstResponder()
        if name == "" && id == "" && stateId == ""{
            return
        }
        self.textFieldCity.text = name
        // convert Response into json Object
        var cityObject: [String:String] = [:]
        cityObject.updateValue(id, forKey: "id")
        cityObject.updateValue(name, forKey: "name")
        cityObject.updateValue(stateId, forKey: "state_id")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            cityData = jsonString
            
        }
    }
}

//------Getting currenctData data------
extension PersonalInfoEditVC: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        textFieldCurrency.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.textFieldCurrency.text = name
        self.currencyCode = id
    }
}


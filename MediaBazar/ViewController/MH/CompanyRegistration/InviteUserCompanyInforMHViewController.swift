//
//  InviteUserCompanyInforMHViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/06/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony

class InviteUserCompanyInforMHViewController: UIViewController {

    @IBOutlet weak var buttonProfileImage: UIButton!
    @IBOutlet weak var profileImageView: RoundImageView!
    @IBOutlet weak var textFiledOrganisationName: UITextField!
    @IBOutlet weak var textFiledType: UITextField!
    @IBOutlet weak var TextFiledFirstName: UITextField!
    @IBOutlet weak var TextFiledLastName: UITextField!
    @IBOutlet weak var TextFiledMiddleName: UITextField!
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
    
    @IBOutlet weak var createPassIconButton : UIButton!
    @IBOutlet weak var confirmPassIconButton : UIButton!
    
    @IBOutlet weak var backButton : UIButton!
    
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
    var designationId = ""
    var getaData = User()//SocialMedialinkModel
    
    var phoneCode = ""
    var iconClick = true
    
    var inviteMediaToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupPickerView()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        countryPickerSetUp()
        buttonContinue.makeRoundCorner(20)
        buttonProfileImage.makeRounded()
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
        buttonProfileImage.addTarget(self, action: #selector(onClickProfileButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func continueButtonpressed() {
//        let personalInfo2VC = AppStoryboard.PreLogin.viewController(CompanyAddressInfoVC.self)
//        self.navigationController?.pushViewController(personalInfo2VC, animated: true)
        if isValidate() {
            CommonClass.showLoader()
            
            personalInfo(profileImageUrl: profileImageView.image!,organisationName: textFiledOrganisationName.text!, mediahouseTypeId: mediaTypeId, mobileNumber: textFieldMobileNumber.text!, firstName: TextFiledFirstName.text!, middleName: TextFiledMiddleName.text!, lastName: TextFiledLastName.text!, designationId: self.designationId, langCode: "en", currency: currencyCode, pinCode: textFieldZipCode.text!, shortBio: textViewShortBio.text!, mailingAdress: textViewmailingAddress.text!, Country: countryData, state: stateData, city: cityData, stepCount: "1", phoneCode: phoneCode, header: inviteMediaToken)

        }

        
    }
    
    @objc func onClickContinueButton(){
        let personalInfo2VC = AppStoryboard.PreLogin.viewController(PersonalInformation2Controller.self)
        self.navigationController?.pushViewController(personalInfo2VC, animated: true)
    }
    
    @objc func onClickProfileButton() {
        
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
    


    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        if profileImageView.image == nil {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please upload the picture.")
            return false
        }
        else if textFiledType.text == "" {
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
//        else if TextFiledMiddleName.text == "" {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
//            return false
//        }
        else if TextFiledLastName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
            return false
        }

        else if textFieldMobileNumber.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mobile number.")
            return false
        }
       
        else if textFieldCountryName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country.")
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
//        else if textFieldCity.text == "" {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the city.")
//            return false
//        }
        else if textFieldZipCode.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the pincode.")
            return false
        }
        else if textViewShortBio.text.count > 200{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the brief description.")
            return false
        }
        else if textViewmailingAddress.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mailing address.")
            return false
        }
        
        return true
    }
    
    //------ Call Api ----
    func personalInfo(profileImageUrl: UIImage, organisationName: String, mediahouseTypeId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String,  currency: String, pinCode: String, shortBio: String,mailingAdress : String, Country: String, state: String, city: String, stepCount: String, phoneCode: String, header : String ) {
        
        WebService3.sharedInstance.getInviteUserMediaPersonalInfo(profileImageUrl: profileImageUrl, organisationName: organisationName,mediahouseTypeId: mediahouseTypeId,mobileNumber: mobileNumber, firstName: firstName, middleName: middleName, lastName: lastName, designationId: designationId, langCode: langCode,currency: currency, pinCode: pinCode, shortBio: shortBio, mailingAddress: mailingAdress, Country: Country, state: state, city: city, stepCount: stepCount,phoneCode: phoneCode, header: header){(result,response,message)  in
            
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory = response {
                    self.getaData = somecategory
                    print("=============\(self.getaData.mediahouseId)")
                    print(somecategory)
                    let personalInfo2VC = AppStoryboard.PreLogin.viewController(CompanyAddressInfoVC.self)
                    personalInfo2VC.getMediaHouseId = self.getaData.mediaSignupId
                    self.navigationController?.pushViewController(personalInfo2VC, animated: true)
                }
               
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}


// -- CountryPickerView ---

extension InviteUserCompanyInforMHViewController:CountryPickerViewDataSource, CountryPickerViewDelegate {
  
    
    
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
}

//------- TextField delegate ------
extension InviteUserCompanyInforMHViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textFiledType {
            let mediaTypeVC = self.storyboard?.instantiateViewController(withIdentifier: "MediaHouseTypeSearchVC") as! MediaHouseTypeSearchVC
            mediaTypeVC.delegate = self
            self.present(mediaTypeVC, animated: true, completion: nil)
            
        } else if textField == textFieldCountryName {
            let countryListSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "CountrySearchVC") as! CountrySearchVC
            textFieldState.text = ""
            textFieldCity.text = ""
            countryListSearchVC.delegate = self
            countryListSearchVC.getSelectedCountry = textFieldCountryName.text ?? ""
            self.present(countryListSearchVC, animated: true, completion: nil)
            
        } else if textField == textFieldState {
            if textFieldCountryName.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "StateSearchVC") as! StateSearchVC
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryId
                stateSearchVC.getSelectedCountry = textFieldState.text ?? ""
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == textFieldCity {
            if textFieldCountryName.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if textFieldState.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else {
                let citySearchVC = self.storyboard?.instantiateViewController(withIdentifier: "CitySearchVC") as! CitySearchVC
                citySearchVC.delegate = self
                citySearchVC.stateId = stateId
                citySearchVC.getSelectedCountry = textFieldCity.text ?? ""
                self.present(citySearchVC, animated: true, completion: nil)
            }
        } else if textField == textFieldCurrency {
            let currencySearchVC = AppStoryboard.Journalist.viewController(CurrencySearchVC.self)
            currencySearchVC.delegate = self
            currencySearchVC.getSelectedCurrency = textFieldCurrency.text ?? ""
            self.present(currencySearchVC, animated: true, completion: nil)
        }
    }
}


//------- Image Picker Extension ------
extension InviteUserCompanyInforMHViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        //imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.mediaTypes = ["public.image"]

        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let chosenImage = info[.editedImage] as? UIImage{
                profileImageView.image = chosenImage
            }else if let chosenImage = info[.originalImage] as? UIImage{
                profileImageView.image = chosenImage
            }
    
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//------ getMediaType -------
extension InviteUserCompanyInforMHViewController: SendNameOfMediaType {
    func countryName(name: String, id: String) {
        textFiledType.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFiledType.text = name
        mediaTypeId = id
    }
}

extension InviteUserCompanyInforMHViewController: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        textFieldCountryName.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }

        self.textFieldCountryName.text = name
        self.textFieldCurrency.text = currencyName
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

extension InviteUserCompanyInforMHViewController: SendNameOfState {
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

extension InviteUserCompanyInforMHViewController: SendNameOfCity {
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

//------getting currenctData data
extension InviteUserCompanyInforMHViewController: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        textFieldCurrency.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.textFieldCurrency.text = name
        self.currencyCode = id
    }
}




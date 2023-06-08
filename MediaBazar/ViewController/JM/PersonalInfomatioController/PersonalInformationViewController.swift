//
//  PersonalInformationViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony
import AVFoundation
import AMPopTip


enum ButtonType: String {
    case ButtonProfilePhoto = "ButtonProfilePhoto"
    case ButtonProfileVideo = "ButtonProfileVideo"
}

class PersonalInformationViewController: UIViewController,CountryPickerViewDataSource, CountryPickerViewDelegate,UITextViewDelegate  {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var profileVideo: RoundImageView!
    @IBOutlet weak var profileImageView: RoundImageView!
    @IBOutlet weak var textFieldMobileNumber: UITextField!
    @IBOutlet weak var textFieldEmailAddress: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldMiddleName: UITextField!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldZipcode: UITextField!
    @IBOutlet weak var stripIdTextField : UITextField!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mailingAddTextView : UITextView!
    @IBOutlet weak var textFieldConfirmPass: UITextField!
    @IBOutlet weak var textFieldCreatePass: UITextField!
    @IBOutlet weak var textFieldPreferredCurrency: UITextField!
    @IBOutlet weak var textFiledState: UITextField!
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var contryFlagImage : UIImageView!
    @IBOutlet weak var countryNamelabel : UILabel!
    
    @IBOutlet weak var popTipButton : UIButton!
    
    @IBOutlet weak var summaryCountLbl: UILabel!
    
    var getaData = SocialMedialinkModel()
    
    var cpv : CountryPickerView!
    var selectedCountry : Country!
    var imagePicker = UIImagePickerController()
    var buttonType: ButtonType = .ButtonProfilePhoto
    var mediaURL: URL?
    var countryData = ""
    var stateData = ""
    var cityData = ""
    var countryId = ""
    var stateId = ""
    
    var phoneCode = ""
    var nameCode = ""
    
    let popTip = PopTip()
    
    var setProfilImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setUpPopTip()
        imagePicker.delegate = self
        textFieldCountry.delegate = self
        textFieldCity.delegate = self
        textFiledState.delegate = self
        textView.delegate = self
    
        updateCharacterCount()
        // Do any additional setup after loading the view.
    }
    
    func setupButton(){
        countryCodeButton.addTarget(self, action: #selector(onClickCountryCodeButton), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    func setUpPopTip(){
        //        self.popTip = AMPopTip()
        self.popTip.shouldDismissOnTap = true
        self.popTip.edgeMargin = 5
        self.popTip.offset = 2
        self.popTip.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //         self.poptip
        self.popTip.backgroundColor = UIColor.gray
        
    }
    
    func setupUI(){
        countryPickerSetUp()
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(countryPickerView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 1)
        textView.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        mailingAddTextView.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    }
    
    func updateCharacterCount() {
        let summaryCount = self.textView.text.count
        self.summaryCountLbl.text = "(\((0) + summaryCount)/200)"
     }

     func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
     }
     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == textView){
           return textView.text.count +  (text.count - range.length) <= 200
        }
//        else if(textView == ticketDescriptionTV){
//            return textView.text.characters.count +  (text.characters.count - range.length) <= 500
//        }
        return false
     }
    
    
    @IBAction func onClickPopTipButton (sender : UIButton){
//                popTip.show(text: "I have an offset to move the bubble down or left side.", direction: .right, maxWidth: 200, in: view, from: popTipButton.frame)
        
    }
    
    
    @objc func onClickContinueButton(){
        
        if setProfilImage == false{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the Profile Image.")
        }
        //callApi
        var videoData = Data()
        guard let data = mediaURL else {
            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the Video.")
        }
        
        do {
            videoData = try Data(contentsOf: data)
        } catch {}
        
        if isValidate() {
            CommonClass.showLoader()
            personalInfo(profileImageUrl: profileImageView.image!, profileVideo: videoData, emailId: textFieldEmailAddress.text!, mobileNumber: textFieldMobileNumber.text!, firstName: textFieldFirstName.text!, middleName: textFieldMiddleName.text!, lastName: textFieldLastName.text!, designationId: "5e27e9f35e5ca62ce98a5a05", langCode: "en", passcode: textFieldConfirmPass.text!, currency: textFieldPreferredCurrency.text!, pinCode: textFieldZipcode.text!, shortBio: textView.text!, mailingAdress: mailingAddTextView.text!, Country: countryData, state: stateData, city: cityData, stepCount: "1", nameCode: nameCode, phoneCode: phoneCode, stripID: stripIdTextField.text!)
        }
        
        //        let personalInfo2VC = AppStoryboard.PreLogin.viewController(PersonalInformation3Controller.self)
        //        self.navigationController?.pushViewController(personalInfo2VC, animated: true)
    }
    
    @objc func onClickCountryCodeButton(){
        cpv.showCountriesList(from: self)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonActionCreatePassVisiblity(_ sender: UIButton) {
        if sender.isSelected == true {
            textFieldCreatePass.isSecureTextEntry = true
            sender.isSelected = false
        } else {
            textFieldCreatePass.isSecureTextEntry = false
            sender.isSelected = true
        }
    }
    
    @IBAction func buttonActionComfirmPassVisiblity(_ sender: UIButton) {
        if sender.isSelected == true {
            textFieldConfirmPass.isSecureTextEntry = true
            sender.isSelected = false
        } else {
            textFieldConfirmPass.isSecureTextEntry = false
            sender.isSelected = true
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    
    @IBAction func buttonActionProfilePicture(_ sender: Any) {
        
        buttonType = .ButtonProfilePhoto
        
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
    
    
    @IBAction func buttonActionProfileVideo(_ sender: Any) {
        
        buttonType = .ButtonProfileVideo
        
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
        self.nameCode = selectedCountry.code
        self.phoneCode = selectedCountry.phoneCode
        //self.countryCodeButton.setTitle(self.selectedCountry.phoneCode, for: .normal)
        
        print("countryNamelabel=========\(countryNamelabel)")
        print("nameCode=================\(nameCode)")
        
    }
    
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
    
    
    
    //------ Call Api ----
    func personalInfo(profileImageUrl: UIImage, profileVideo: Data, emailId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, passcode: String, currency: String, pinCode: String, shortBio: String,mailingAdress : String, Country: String, state: String, city: String, stepCount: String, nameCode: String, phoneCode: String,stripID : String ) {
        
        Webservice.sharedInstance.getPersonalInfo(profileImageUrl: profileImageUrl, profileVideo: profileVideo, emailId: emailId, mobileNumber: mobileNumber, firstName: firstName, middleName: middleName, lastName: lastName, designationId: designationId, langCode: langCode, passcode: passcode, currency: currency, pinCode: pinCode, shortBio: shortBio, mailingAddress: mailingAdress, Country: Country, state: state, city: city, stepCount: stepCount, nameCode: nameCode, phoneCode: phoneCode, stripId: stripID){(result,response,message)  in
            
            CommonClass.hideLoader()
            if result == 200 {
                
                if let somecategory = response {
                    self.getaData = somecategory
                    print("=============\(self.getaData.id)")
                    print(somecategory)
                    let personalInfo2VC = AppStoryboard.PreLogin.viewController(PersonalInformation3Controller.self)
                    personalInfo2VC.journalistId = self.getaData.id
                    self.navigationController?.pushViewController(personalInfo2VC, animated: true)
                }
                
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        
//        if profileImageView.image == nil {
//        if setProfilImage == false{
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the Profile Image.")
//            return false
//        }
         if textFieldFirstName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name.")
            return false
        }
            //        else if textFieldMiddleName.text == "" {
            //            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
            //            return false
            //        }
        else if textFieldLastName.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
            return false
        }
        else if textFieldEmailAddress.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email address.")
            return false
        }
        else if !(textFieldEmailAddress.text?.isValidEmail)!{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid email address.")
            return false
        }
        else if textFieldMobileNumber.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mobile number.")
            return false
        }
            
            
            
            //                    else if !(textFieldMobileNumber.text?.isValidMobileNo)!{
            //                        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid mobile number.")
            //                        return false
            //                    }
            
        else if textFieldCountry.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the country.")
            return false
        }
        else if textFieldPreferredCurrency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the preferred currency.")
            return false
        }
        else if textFiledState.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the state.")
            return false
        }
            //        else if textFieldCity.text == "" {
            //            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the city.")
            //            return false
            //        }
        else if textFieldZipcode.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the pincode.")
            return false
        }
        else if textFieldCreatePass.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the password.")
            return false
        }
        else if !(textFieldCreatePass.text?.isValidPassword)! {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Password should have minimum 8 characters, at least 1 uppercase letter, 1 special character and 1 number.")
            return false
        }
        else if textFieldConfirmPass.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the confirm password.")
            return false
        }
        else if textFieldConfirmPass.text != textFieldCreatePass.text {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Create password and confirm password should be same.")
            return false
        }
         else if textView.text == ""{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the short bio.")
            return false
         }
        else if textView.text.count > 200 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the Maximum text limit is 200 words.")
            return false
        }
        else if mailingAddTextView.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the mailing address.")
            return false
        }
        
        return true
    }
    
}


//------- Image Picker Extension ------
extension PersonalInformationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        
        if buttonType == .ButtonProfilePhoto{
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else if buttonType == .ButtonProfileVideo {
            imagePicker.mediaTypes = [ "public.movie"]
            
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            //            imagePicker.videoMaximumDuration = 30
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            print("duration\(imagePicker.videoMaximumDuration)")
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if buttonType == .ButtonProfilePhoto {
            
            if let chosenImage = info[.editedImage] as? UIImage{
                setProfilImage = true
                profileImageView.image = chosenImage
            }else if let chosenImage = info[.originalImage] as? UIImage{
                setProfilImage = true
                profileImageView.image = chosenImage
            }
        } else if buttonType == .ButtonProfileVideo {
            
            if let chosenImage = info[.editedImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let chosenImage = info[.originalImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.movie" {
                
                let mediaURL = info[.mediaURL] as! URL
                print("mediaURL-----------\(mediaURL)")

                let asset = AVURLAsset.init(url: mediaURL ) // AVURLAsset.init(url: outputFileURL as URL)
                // get the time in seconds
                let durationInSeconds = asset.duration.seconds
                print("==== Duration is ",durationInSeconds)
                if durationInSeconds <= 30 {
                    self.mediaURL = mediaURL
                    if let thumbnailImage = getThumbnailImage(forUrl: mediaURL) {
                        profileVideo.image = thumbnailImage
                    }
                }else if durationInSeconds >= 30{
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose 20 sec video.")
                }
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//------- TextField delegate ------

extension PersonalInformationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textFieldCountry {
            let countryListSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "CountrySearchVC") as! CountrySearchVC
            countryListSearchVC.getSelectedCountry = textFieldCountry.text ?? ""
            countryListSearchVC.delegate = self
            textFiledState.text = ""
            textFieldCity.text = ""
            countryListSearchVC.getSelectedCountry = textFieldCountry.text ?? ""
            self.present(countryListSearchVC, animated: true, completion: nil)
            
        } else if textField == textFiledState {
            if textFieldCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "StateSearchVC") as! StateSearchVC
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryId
                stateSearchVC.getSelectedCountry = textFiledState.text ?? ""
                textFieldCity.text = ""
                self.present(stateSearchVC, animated: true, completion: nil)
            }
            
        } else if textField == textFieldCity {
            if textFieldCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if textFiledState.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else {
                let citySearchVC = self.storyboard?.instantiateViewController(withIdentifier: "CitySearchVC") as! CitySearchVC
                citySearchVC.delegate = self
                citySearchVC.stateId = stateId
                citySearchVC.getSelectedCountry = textFieldCity.text ?? ""
                self.present(citySearchVC, animated: true, completion: nil)
            }
        }
    }
}


extension PersonalInformationViewController: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
        self.textFieldCountry.text = name
        self.textFieldPreferredCurrency.text = currencyName
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

extension PersonalInformationViewController: SendNameOfState {
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
        textFiledState.resignFirstResponder()
        if name == "" && id == "" && countyId == "" && symobol == "" && currencyName == ""{
            return
        }
        self.textFiledState.text = name
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

extension PersonalInformationViewController: SendNameOfCity {
    
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



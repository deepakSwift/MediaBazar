//
//  ReferenceViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony

let kPhoneNumber = "phoneNumber"
let kCountryCode = "countryCode"


class ReferenceViewController: UIViewController {
    
    @IBOutlet weak var textFieldfirstName1: UITextField!
    @IBOutlet weak var textFieldMiddleName1: UITextField!
    @IBOutlet weak var textFieldLastName1: UITextField!
    @IBOutlet weak var textFieldEmail1: UITextField!
    @IBOutlet weak var textFielDesignation1: UITextField!
    @IBOutlet weak var textFiledPhoneNumber1: UITextField!
    
    @IBOutlet weak var buttonAddMorethird: UIButton!
    @IBOutlet weak var buttonAddMoreSecond: UIButton!
    @IBOutlet weak var buttonAddMoreFirst: UIButton!
    
    @IBOutlet weak var buttonThirdDelete: UIButton!
    @IBOutlet weak var buttonSecondDelete: UIButton!
    @IBOutlet weak var buttonFirstDelete: UIButton!
    
    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var thirdContainerView: UIView!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var contryFlagImage : UIImageView!
    @IBOutlet weak var countryNamelabel : UILabel!
    
    var cpv : CountryPickerView!
    var selectedCountry : Country!
    var refrencesArray = ProffesionalDetailModel()
    var journalistId = ""
    var countrycode = ""
    var referenceData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupButton(){
        countryCodeButton.addTarget(self, action: #selector(onClickCountryCodeButton), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        buttonFirstDelete.tag = 1
        buttonSecondDelete.tag = 2
        buttonThirdDelete.tag = 3
        buttonFirstDelete.isHidden = true
        //buttonAddMorethird.isHidden = true
    }
    
    func setupUI(){
        countryPickerSetUp()
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(countryPickerView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 1)
        secondContainerView.isHidden = true
        thirdContainerView.isHidden = true
    }
    
    func setUpData(){
        
        var dict = Dictionary<String,String>()
        dict.updateValue(textFieldLastName1.text!, forKey: "firstName")
        dict.updateValue(textFieldMiddleName1.text!, forKey: "middleName")
        dict.updateValue(textFieldLastName1.text!, forKey: "lastName")
        dict.updateValue(textFieldEmail1.text!, forKey: "emailId")
        dict.updateValue(textFielDesignation1.text!, forKey: "designation")
        dict.updateValue(textFiledPhoneNumber1.text!, forKey: "mobileNumber")
        dict.updateValue(countryNamelabel.text!, forKey: "phonecode")
        dict.updateValue(countryCode, forKey: "countrycode")
        let doubleQ = "\""
        var text = "{"
        let dictCount = dict.keys.count
        for (index, element) in dict.enumerated(){
            let key = doubleQ+element.key+doubleQ
            let value = doubleQ+element.value+doubleQ
            text = text+key+":"+value
            text = text+((index == dictCount-1) ? "":",")
        }
        text = text+"}"
        referenceData.append(text)
        print(text)


    }
    
    
    @objc func onClickContinueButton(){
        
        setUpData()
        
        if isValidate() {

            var newtext = "["
            for index in 0..<referenceData.count {
                let item = referenceData[index]
                //                       text += item.textDict(true)
                newtext += item
                newtext += (index == referenceData.count-1) ? "" : ","
            }
            newtext = newtext+"]"
            print(newtext)

            getrefrences(refrences: newtext, journalistId: journalistId, stepCount: "3")
        }
        
        
        //let perviousWorkVC  = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
        //self.navigationController?.pushViewController(perviousWorkVC, animated: true)
    }
    
    @objc func onClickCountryCodeButton(){
        cpv.showCountriesList(from: self)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonActionaddMoreFirst(_ sender: Any) {
        //secondContainerView.isHidden = false
    }
    
    @IBAction func buttonActionAddMoreSecond(_ sender: Any) {
        //secondContainerView.isHidden = false
        //thirdContainerView.isHidden = false
    }
    
    @IBAction func buttonActionAddMoreThird(_ sender: Any) {
           NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Reached out maximum limits")
       }
    
    @IBAction func buttonActionDeleteFirst(_ sender: Any) {
        
    }
    
    @IBAction func buttonActionDeleteSecond(_ sender: Any) {
        
    }
    
    
    
    @IBAction func buttonActionDeleteThird(_ sender: Any) {
    }
    
   
    
    //-----common Delete Button
    @IBAction func buttonActionDelete(_ sender: UIButton) {
        if sender.tag == 1 {
            //------
        } else if sender.tag == 2 {
            secondContainerView.isHidden = true
        } else if sender.tag == 3 {
            thirdContainerView.isHidden = true
        }
    }
    
    //-----Api Call--------
    func getrefrences(refrences: String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.refrencesData(refrences: refrences, journalistId: journalistId, stepCount: stepCount){(result, response, message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.refrencesArray = somecategory
                    let perviousWorkVC  = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
                    perviousWorkVC.journalistId = journalistId
                    self.navigationController?.pushViewController(perviousWorkVC, animated: true)
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        if textFieldfirstName1.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name.")
            return false
        }
//        else if textFieldMiddleName1.text == "" {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
//            return false
//        }
        else if textFieldLastName1.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
            return false
        }
        else if textFieldEmail1.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter email address")
            return false
        }
        else if !(textFieldEmail1.text?.isValidEmail)! {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter valid email address")
            return false
        }
        else if textFielDesignation1.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the designation.")
            return false
        }
        else if textFiledPhoneNumber1.text == ""{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the phone number")
            return false
        }
        else if textFiledPhoneNumber1.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid phone number.")
            return false
        }
        return true
    }
}


//---------CountryPicker--------
extension ReferenceViewController: CountryPickerViewDataSource, CountryPickerViewDelegate  {
    
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
        self.countryNamelabel.text = selectedCountry.phoneCode
        self.contryFlagImage.image = selectedCountry.flag
        self.countrycode = selectedCountry.code
        //self.countryCodeButton.setTitle(self.selectedCountry.phoneCode, for: .normal)
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
        self.countryNamelabel.text = country.phoneCode
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

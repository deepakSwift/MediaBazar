//
//  PersonalInformationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PersonalInformationViewControllerJM: UIViewController {
    
    @IBOutlet weak var PersonalInfoTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var firstnameTextField : UITextField!
    @IBOutlet weak var middleNameTextField : UITextField!
    @IBOutlet weak var lastNameTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var picCodeTextField : UITextField!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var maillingAddress : UITextView!

    
    var currentUserLogin : User!
    var countryId = ""
    var countryData = ""
    var stateId = ""
    var stateData = ""
    var cityData = ""
    var personalInfoData = profileModal()
    var desgunationID = DesignationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        setupTableView()
        setupUI()
        setupButton()
        setupTextFields()
        setUpPreviousData()
//        self.PersonalInfoTableView.reloadData()
    }
    
    func setupTableView(){
        PersonalInfoTableView.rowHeight = UITableView.automaticDimension
        PersonalInfoTableView.estimatedRowHeight = 1000
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        textView.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        maillingAddress.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
          
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(clickOnSaveButton), for: .touchUpInside)
    }
    
    
    func setupTextFields() {
        countryTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
    }

    
    func setUpPreviousData(){
        
        firstnameTextField.text = personalInfoData.firstName
        middleNameTextField.text = personalInfoData.middleName
        lastNameTextField.text = personalInfoData.lastName
        picCodeTextField.text = personalInfoData.pinCode
        textView.text = personalInfoData.shortBio
        maillingAddress.text = personalInfoData.mailingAddress
        //-----CountryData-----
        countryTextField.text = personalInfoData.country.name
        var countryObject: [String:String] = [:]
        countryObject.updateValue(personalInfoData.country.name, forKey: "name")
        countryObject.updateValue(personalInfoData.country.placeId, forKey: "id")
        countryObject.updateValue(personalInfoData.country.sortName, forKey: "sortname")
        countryObject.updateValue(personalInfoData.country.phoneCode, forKey: "phonecode")
        countryObject.updateValue(personalInfoData.country.symbol, forKey: "symbol")
        countryObject.updateValue(personalInfoData.country.currencyName, forKey: "currencyName")
        let jsonData = try! JSONSerialization.data(withJSONObject: countryObject, options: .prettyPrinted)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            countryData = jsonString
        }
        
        //-----StateData-----
        stateTextField.text = personalInfoData.state.stateName
        var stateObject: [String:String] = [:]
        stateObject.updateValue(personalInfoData.state.stateId, forKey: "id")
        stateObject.updateValue(personalInfoData.state.stateName, forKey: "name")
        stateObject.updateValue(personalInfoData.state.countryId, forKey: "country_id")
        stateObject.updateValue(personalInfoData.state.symbol, forKey: "symbol")
        stateObject.updateValue(personalInfoData.state.currencyName, forKey: "currencyName")
        let stateJsonData = try! JSONSerialization.data(withJSONObject: stateObject, options: .prettyPrinted)
        if let jsonString = String(data: stateJsonData, encoding: .utf8) {
            print(jsonString)
            stateData = jsonString
        }
        
        //-----CityData-----
        cityTextField.text = personalInfoData.city.name
        var cityObject: [String:String] = [:]
        cityObject.updateValue(personalInfoData.city.placeId, forKey: "id")
        cityObject.updateValue(personalInfoData.city.name, forKey: "name")
        cityObject.updateValue(personalInfoData.city.stateId, forKey: "state_id")
        let cityjsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        if let jsonString = String(data: cityjsonData, encoding: .utf8) {
            print(jsonString)
            cityData = jsonString
        }
    }
    
    
//
//    func getCountry() {
//        let countryListVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
//        countryListVC.delegate = self
//        self.present(countryListVC, animated: true, completion: nil)
//    }
//
//    func getState() {
//        let stateListVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
//        stateListVC.delegate = self
//        stateListVC.countryId = countryID
//        self.present(stateListVC, animated: true, completion: nil)
//    }
//
//    func getCity() {
//        let cityListVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
//        cityListVC.delegate = self
//        cityListVC.stateId = stateID
//        self.present(cityListVC, animated: true, completion: nil)
//    }
    
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnSaveButton(){
        
        editpersonalInfo(emailId: personalInfoData.emailId, mobileNumber: personalInfoData.mobileNumber, firstName: firstnameTextField.text!, middleName: middleNameTextField.text!, lastName: lastNameTextField.text!, designationID: desgunationID.adminBenifitID, langcode: personalInfoData.langCode, passcode: personalInfoData.password, currency: personalInfoData.currency, pincode: picCodeTextField.text!, shortBio: textView.text!, mailingAddress: personalInfoData.mailingAddress, country: countryData, state: stateData, city: cityData, stepCount: "1", header: currentUserLogin.token)

    }
    
    
    func editpersonalInfo(emailId: String, mobileNumber: String, firstName: String, middleName : String, lastName:String, designationID: String, langcode: String, passcode: String, currency: String, pincode: String, shortBio: String, mailingAddress: String, country: String, state: String, city: String, stepCount: String,header: String ){
        CommonClass.showLoader()
        Webservices.sharedInstance.editPersonalInfo(emailId: emailId, mobileNumber: mobileNumber, firstName: firstName, middleName: middleName, lastName: lastName, designationId: designationID, langCode: langcode, passcode: passcode, currency: currency, pinCode: pincode, shortBio: shortBio, mailingAddress: mailingAddress, Country: country, state: state, city: city, stepCount: stepCount, header: header){(result,response,message)  in
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory = response {
                    self.navigationController?.popViewController(animated: true)
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }

    }
    
    
}

//extension PersonalInformationViewControllerJM : UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInformationTableViewCellJM") as! PersonalInformationTableViewCellJM
//        cell.delegate = self
//        cell.firstnameTextField.text = personalInfoData.firstName
//        cell.middleNameTextField.text = personalInfoData.middleName
//        cell.lastNameTextField.text = personalInfoData.lastName
//        cell.countryTextField.text = personalInfoData.country.name
//        cell.stateTextField.text = personalInfoData.state.stateName
//        cell.cityTextField.text = personalInfoData.city.name
//        cell.textView.text = personalInfoData.shortBio
//        cell.picCodeTextField.text = personalInfoData.pinCode
//        return cell
//    }
//}
//
//
//extension PersonalInformationViewControllerJM: SendNameOfCountry {
//    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
//
//        if let cell = PersonalInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PersonalInformationTableViewCellJM {
//            cell.countryTextField.text = name
//            self.countryID = id
//            //        self.countryData = id
//            // convert Response into json Object
//            var cityObject: [String:String] = [:]
//            cityObject.updateValue(id, forKey: "id")
//            cityObject.updateValue(sortName, forKey: "sortname")
//            cityObject.updateValue(name, forKey: "name")
//            cityObject.updateValue(phoneCode, forKey: "phonecode")
//            cityObject.updateValue(symbol, forKey: "symbol")
//            cityObject.updateValue(currencyName, forKey: "currencyName")
//
//            let jsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
//
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//                countryData = jsonString
//            }
//        }
//    }
//}
//
//extension PersonalInformationViewControllerJM: SendNameOfState {
//    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
//
//        if let cell = PersonalInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PersonalInformationTableViewCellJM {
//            cell.stateTextField.text = name
//            self.stateID = id
//            //                    self.stateData = id
//            // convert Response into json Object
//            var stateObject: [String:String] = [:]
//            stateObject.updateValue(id, forKey: "id")
//            stateObject.updateValue(name, forKey: "name")
//            stateObject.updateValue(countyId, forKey: "country_id")
//            stateObject.updateValue(symobol, forKey: "symbol")
//            stateObject.updateValue(currencyName, forKey: "currencyName")
//
//            let jsonData = try! JSONSerialization.data(withJSONObject: stateObject, options: .prettyPrinted)
//
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//                stateData = jsonString
//            }
//
//        }
//    }
//
//}
//
//extension PersonalInformationViewControllerJM: SendNameOfCity {
//
//    func cityName(name: String, id: String, stateId: String) {
//
//        if let cell = PersonalInfoTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PersonalInformationTableViewCellJM {
//            cell.cityTextField.text = name
//            // convert Response into json Object
//            var cityObject: [String:String] = [:]
//            cityObject.updateValue(id, forKey: "id")
//            cityObject.updateValue(name, forKey: "name")
//            cityObject.updateValue(stateId, forKey: "state_id")
//
//            let jsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
//
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//                cityData = jsonString
//            }
//
//        }
//    }
//
//}


extension PersonalInformationViewControllerJM: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == countryTextField{
            let countryListVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
            countryListVC.delegate = self
            self.present(countryListVC, animated: true, completion: nil)
        }  else if textField == stateTextField{
            if countryTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryId
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == cityTextField{
            if countryTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if stateTextField.text == "" {
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



extension PersonalInformationViewControllerJM: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        countryTextField.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
        self.countryTextField.text = name
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

extension PersonalInformationViewControllerJM: SendNameOfState {
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
        stateTextField.resignFirstResponder()
        if name == "" && id == "" && countyId == "" && symobol == "" && currencyName == ""{
            return
        }
        self.stateTextField.text = name
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

extension PersonalInformationViewControllerJM: SendNameOfCity {
    func cityName(name: String, id: String, stateId: String) {
        cityTextField.resignFirstResponder()
        if name == "" && id == "" && stateId == ""{
            return
        }
        self.cityTextField.text = name
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

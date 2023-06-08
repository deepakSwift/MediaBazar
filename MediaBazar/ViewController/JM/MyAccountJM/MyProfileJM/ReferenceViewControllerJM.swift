//
//  ReferenceViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony
import AMPopTip


class ReferenceViewControllerJM: UIViewController,CountryPickerViewDataSource,CountryPickerViewDelegate {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var referenceTableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var addMoreButton : UIButton!
//    @IBOutlet weak var popTipButton : UIButton!
    
    
    var count = 1
    var countArray = [Int]()
    var journalistId = ""
//    var refrencesArray = ProffesionalDetailModel()
    var referenceData = profileModal()

    var textFieldValidationFlag = false
    
    var nameArray = [String]()
    var middleNameArray = [String]()
    var lastNameArray = [String]()
    var emailArray = [String]()
    var deginationArray = [String]()
    var phoneNoArray = [String]()
    
    var cpv : CountryPickerView!
    var selectedCountry : Country!
    
    var countryCods = [String]()
    var phoneCodes = [String]()
    
    let popTip = PopTip()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        countryPickerSetUp()
//        setUpPopTip()
        
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        addMoreButton.addTarget(self, action: #selector(addMoreWork(sender:)), for: .touchUpInside)
        
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
    
//    @IBAction func onClickPopTipButton (sender : UIButton){
//        popTip.show(text: "We might reach out of 2 reference for further details", direction: .right, maxWidth: 200, in: view, from: popTipButton.frame)
//
//
//    }
    
    func setupUI(){
        self.referenceTableView.dataSource = self
        self.referenceTableView.delegate = self
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func countryPickerSetUp() {
        if cpv != nil{
            cpv.removeFromSuperview()
        }
        cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        cpv.alpha = 1.0
        self.view.addSubview(cpv)
        cpv.isHidden = true
        cpv.showPhoneCodeInView = false
        cpv.showCountryCodeInView = false
        cpv.flagImageView.isHidden = true
        cpv.dataSource = self
        cpv.delegate = self
        cpv.setCountryByCode(self.currentCountryCode)
        self.selectedCountry = cpv.selectedCountry
        
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
    
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select Country"
    }
    
    func closeButtonNavigationItem(in countryPickerView: CountryPickerView) -> UIBarButtonItem? {
        return nil
    }
    
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .navigationBar
    }
    
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.selectedCountry = country
        
        
                guard let cell = self.referenceTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewReferenceTableViewCell else {
                    return
                }
                self.countryCods.append(selectedCountry.code)
                self.phoneCodes.append(selectedCountry.phoneCode)
//                self.countryCods = selectedCountry.code
//                self.phoneCodes = selectedCountry.phoneCode
                cell.contryFlagImage.image = selectedCountry.flag
                cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
        
//
//        var getNoOfCell = referenceTableView.numberOfRows(inSection: 0)
////        var finalString = ""
////        var referenceWork = [String]()
//        print("getNoOfCell====\(getNoOfCell)")
//        for item in 0..<getNoOfCell{
//            print("cell\(item)")
//            guard let cell = referenceTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? NewReferenceTableViewCell else { print("cell not found"); return }
//
//
//            cell.contryFlagImage.image = selectedCountry.flag
//            cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
//
//        }
        
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
    
    @IBAction func onClickSelectCountry(_ sender: UIButton) {
        cpv.showCountriesList(from: self)
    }
    
    
    
    @objc func onClickContinueButton(){
        
        var getNoOfCell = referenceTableView.numberOfRows(inSection: 0)
        var finalString = ""
        var referenceWork = [String]()
        print("getNoOfCell====\(getNoOfCell)")
        for item in 0..<getNoOfCell{
            print("cell\(item)")
            guard let cell = referenceTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? NewReferenceTableViewCell else { print("cell not found"); return }
            
            func isValidate()-> Bool {
                if cell.textFieldfirstName.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name.")
                    return false
                }
                    //        else if textFieldMiddleName1.text == "" {
                    //            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
                    //            return false
                    //        }
                else if cell.textFieldLastName.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
                    return false
                }
                else if cell.textFieldEmail.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter email address")
                    return false
                }
                else if !(cell.textFieldEmail.text?.isValidEmail)! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter valid email address")
                    return false
                }
                else if cell.textFielDesignation.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the designation.")
                    return false
                }
                else if cell.textFiledPhoneNumber.text == ""{
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the phone number")
                    return false
                }
                else if cell.textFiledPhoneNumber.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid phone number.")
                    return false
                }
                return true
            }
            
            self.nameArray.append(cell.textFieldfirstName.text!)
            self.middleNameArray.append(cell.textFieldMiddleName.text!)
            self.lastNameArray.append(cell.textFieldLastName.text!)
            self.emailArray.append(cell.textFieldEmail.text!)
            self.deginationArray.append(cell.textFielDesignation.text!)
            self.phoneNoArray.append(cell.textFiledPhoneNumber.text!)
            self.phoneCodes.append(selectedCountry.phoneCode)
            self.countryCods.append(selectedCountry.code)
            
            
            
            var count = item
            //            for data in titleArray.enumerated() {             //---For multiple selection
            
            var dict = Dictionary<String,String>()
            dict.updateValue(nameArray[count], forKey: "firstName")
            dict.updateValue(middleNameArray[count], forKey: "middleName")
            dict.updateValue(lastNameArray[count], forKey: "lastName")
            dict.updateValue(emailArray[count], forKey: "emailId")
            dict.updateValue(deginationArray[count], forKey: "designation")
            dict.updateValue(phoneNoArray[count], forKey: "mobileNumber")
            dict.updateValue(phoneCodes[count], forKey: "phonecode")
            dict.updateValue(countryCods[count], forKey: "countrycode")
            
            count += 1
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
            
            //        return text
            print("======================\(text)")
            referenceWork.append(text)
            
            //            }
            
            var textNew = "["
            for index in 0..<referenceWork.count {
                let item = referenceWork[index]
                textNew += item
                textNew += (index == referenceWork.count-1) ? "" : ","
            }
            textNew = textNew+"]"
            finalString = textNew
            print("-------------------textNew\(textNew)")
            
            
        }
        
        
//                if isValidate() {
        print("finalString============\(finalString)")
        getrefrences(refrences: finalString, journalistId: referenceData.id, stepCount: "4")
//                }
        
        
        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //-----Api Call--------
    func getrefrences(refrences: String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.updateRefrencesData(refrences: refrences, journalistId: journalistId, stepCount: stepCount){(result, response, message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.referenceData = somecategory
                    self.navigationController?.popViewController(animated: true)
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension ReferenceViewControllerJM: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("====cell count====\(count)")
//        return countArray.count
        return referenceData.refrences.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewReferenceTableViewCell") as! NewReferenceTableViewCell
        
//        if indexPath.row == 0 {
//            cell.deleteButton.isHidden = true
//        }
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(onclickDeleteButton(sender:)), for: .touchUpInside)
        
        
        cell.contryFlagImage.image = selectedCountry.flag
        cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
        cell.countryCodeButton.addTarget(self, action: #selector(onClickSelectCountry(_:)), for: .touchUpInside)
        
                let aardata = referenceData.refrences[indexPath.row]
                cell.textFieldfirstName.text = aardata.firstName
                cell.textFieldMiddleName.text = aardata.middleName
                cell.textFieldLastName.text = aardata.lastName
                cell.textFieldEmail.text = aardata.emailId
                cell.textFielDesignation.text = aardata.designation
                cell.textFiledPhoneNumber.text = aardata.mobileNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 540
    }
    
    @objc func addMoreWork(sender: UIButton) {
        let index = sender.tag
        print("===========addMoreIndex===========\(index)")
        //        countArray.append(1)
        let tempModal = categoryTypeModal()
        referenceData.refrences.append(tempModal)
        
        referenceTableView.reloadData()
    }
    
    @objc func onclickDeleteButton(sender: UIButton) {
        let index = sender.tag
        print("==========DeleteButtonIndex=========\(index)")
        referenceData.refrences.remove(at: index)
//        countArray.remove(at: index)
        //        let indexPaths = IndexPath(item: index, section: 0)
        //        perviousWorkTableView.deleteRows(at: [indexPaths], with: .fade)
        referenceTableView.reloadData()
    }
}



//class ReferenceViewControllerJM: UIViewController  {
//
//    @IBOutlet weak var topview : UIView!
//    @IBOutlet weak var referenceTableview : UITableView!
//    @IBOutlet weak var saveBtn : UIButton!
//    @IBOutlet weak var backBtn : UIButton!
//
//    var referenceData = profileModal()
//
////    var referenceData = [categoryTypeModal]()
//    var reference = [String]()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
//        setUptableView()
//        setupUI()
//        setupButton()
//    }
//
//    func setUptableView(){
//        self.referenceTableview.dataSource = self
//        self.referenceTableview.delegate = self
//        referenceTableview.rowHeight = UITableView.automaticDimension
//        referenceTableview.estimatedRowHeight = 1000
//
//    }
//
//    func setupUI(){
//        topview.applyShadow()
//        CommonClass.makeViewCircularWithCornerRadius(saveBtn, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
//    }
//
//    func setupButton(){
//        backBtn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
//        saveBtn.addTarget(self, action: #selector(onClickSaveButton), for: .touchUpInside)
//    }
//
//    func setUpData(){
//        guard let cell = referenceTableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? ReferenceTableViewCellJM else { print("cell not found"); return }
//
//
//        var dict = Dictionary<String,String>()
//        dict.updateValue(cell.firstNameTextfield.text!, forKey: "firstName")
//        dict.updateValue(cell.middleNameTextField.text!, forKey: "middleName")
//        dict.updateValue(cell.lastNameTextField.text!, forKey: "lastName")
//        dict.updateValue(cell.emailAddressTextField.text!, forKey: "emailId")
//        dict.updateValue(cell.designamtionTextField.text!, forKey: "designation")
//        dict.updateValue(cell.mobileTextField.text!, forKey: "mobileNumber")
////        dict.updateValue(countryNamelabel.text!, forKey: "phonecode")
////        dict.updateValue(countryCode, forKey: "countrycode")
//        let doubleQ = "\""
//        var text = "{"
//        let dictCount = dict.keys.count
//        for (index, element) in dict.enumerated(){
//            let key = doubleQ+element.key+doubleQ
//            let value = doubleQ+element.value+doubleQ
//            text = text+key+":"+value
//            text = text+((index == dictCount-1) ? "":",")
//        }
//        text = text+"}"
//        reference.append(text)
//        print(text)
//
//
//    }
//
//
//    @objc func backButtonPressed(){
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @objc func onClickSaveButton(){
//
//         guard let cell = referenceTableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? ReferenceTableViewCellJM else { print("cell not found"); return }
//
//        func isValidate()-> Bool {
//        if cell.firstNameTextfield.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name.")
//                return false
//            }
//        else if cell.middleNameTextField.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the middle name.")
//                return false
//            }
//        else if cell.lastNameTextField.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name.")
//                return false
//            }
//        else if cell.emailAddressTextField.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "please enter the email address.")
//                return false
//            }
//        else if !(cell.emailAddressTextField.text?.isValidEmail)! {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "please enter the valid email address.")
//                return false
//            }
//        else if cell.designamtionTextField.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the designation.")
//                return false
//            }
//        else if cell.mobileTextField.text == ""{
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the phone number")
//                return false
//            }
////        else if !(cell.mobileTextField.text?.isValidMobileNo)!{
////                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid phone number.")
////                return false
////            }
//            return true
//    }
//
//        setUpData()
//
//        if isValidate() {
//
//            var newtext = "["
//            for index in 0..<reference.count {
//                let item = reference[index]
//                //                       text += item.textDict(true)
//                newtext += item
//                newtext += (index == reference.count-1) ? "" : ","
//            }
//            newtext = newtext+"]"
//            print(newtext)
//
//            getrefrences(refrences: newtext, journalistId: referenceData.id, stepCount: "3")
//        }
//
//
//        //let perviousWorkVC  = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
//        //self.navigationController?.pushViewController(perviousWorkVC, animated: true)
//    }
//
//
//
//    //------TextFields Validations-------
//
//
//
//
//    func getrefrences(refrences: String, journalistId: String, stepCount: String){
//    CommonClass.showLoader()
//    Webservice.sharedInstance.refrencesData(refrences: refrences, journalistId: journalistId, stepCount: stepCount){(result, response, message) in
//        CommonClass.hideLoader()
//        print(result)
//        if result == 200{
//            self.navigationController?.popViewController(animated: true)
//        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
//        }else{
//            NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
//        }
//    }
//}
//
//}
//
//
//extension ReferenceViewControllerJM: UITableViewDataSource, UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return referenceData.refrences.count
////        return 1
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReferenceTableViewCellJM") as! ReferenceTableViewCellJM
//        let aardata = referenceData.refrences[indexPath.row]
//        cell.firstNameTextfield.text = aardata.firstName
//        cell.middleNameTextField.text = aardata.middleName
//        cell.lastNameTextField.text = aardata.lastName
//        cell.emailAddressTextField.text = aardata.emailId
//        cell.designamtionTextField.text = aardata.designation
//        cell.mobileTextField.text = aardata.mobileNumber
//        return cell
//    }
//
//
//}
//
//





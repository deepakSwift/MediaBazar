


//
// NewReferenceViewController.swift
// MediaBazar
//
// Created by Abhinav Saini on 12/05/20.
// Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import CountryPickerView
import CoreTelephony
import AMPopTip

class NewReferenceViewController: UIViewController,CountryPickerViewDataSource,CountryPickerViewDelegate {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var referenceTableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var addMoreButton : UIButton!
    @IBOutlet weak var popTipButton : UIButton!
    
    
    var count = 1
    var countArray = [1]
    var journalistId = ""
    var refrencesArray = ProffesionalDetailModel()
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
        setUpPopTip()
        
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        addMoreButton.addTarget(self, action: #selector(addMoreWork(sender:)), for: .touchUpInside)
        
    }
    
    func setUpPopTip(){
        // self.popTip = AMPopTip()
        self.popTip.shouldDismissOnTap = true
        self.popTip.edgeMargin = 5
        self.popTip.offset = 2
        self.popTip.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // self.poptip
        self.popTip.backgroundColor = UIColor.gray
        
    }
    
    @IBAction func onClickPopTipButton (sender : UIButton){
        popTip.show(text: "We might reach out to 3 reference for further details", direction: .right, maxWidth: 150, in: view, from: popTipButton.frame)
    }
    
    func setupUI(){
        self.referenceTableView.dataSource = self
        self.referenceTableView.delegate = self
        self.referenceTableView.reloadData()
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
        // self.countryCods = selectedCountry.code
        // self.phoneCodes = selectedCountry.phoneCode
        cell.contryFlagImage.image = selectedCountry.flag
        cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
        
        //
        // var getNoOfCell = referenceTableView.numberOfRows(inSection: 0)
        //// var finalString = ""
        //// var referenceWork = [String]()
        // print("getNoOfCell====\(getNoOfCell)")
        // for item in 0..<getNoOfCell{
        // print("cell\(item)")
        // guard let cell = referenceTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? NewReferenceTableViewCell else { print("cell not found"); return }
        //
        //
        // cell.contryFlagImage.image = selectedCountry.flag
        // cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
        //
        // }
        
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
        self.scrollToBottom()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
            var getNoOfCell = self.referenceTableView.numberOfRows(inSection: 0)
            var lastIndex = getNoOfCell - 1
            var finalString = ""
            var allField = false
            var referenceWork = [String]()
            print("getNoOfCell====\(getNoOfCell)")
            for item in 0..<getNoOfCell{
                print("cell\(item)")
                guard let cell = self.referenceTableView.cellForRow(at: IndexPath(row: lastIndex, section: 0)) as? NewReferenceTableViewCell else { print("cell not found"); return }
                
                func isValidate()-> Bool {
                    if cell.textFieldfirstName.text == "" {
                        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the first name")
                        return false
                    }
                    else if cell.textFieldLastName.text == "" {
                        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the last name")
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
                        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter designation")
                        return false
                    }
                        // else if cell.textFiledPhoneNumber.text == ""{
                        // NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the phone number")
                        // return false
                        // }
                    else if cell.textFiledPhoneNumber.text == "" {
                        NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid phone number")
                        return false
                    }
                    return true
                }
                // print(isValidate())
                if isValidate() {
                    allField = true
                    if item == lastIndex {
                        self.nameArray.append(cell.textFieldfirstName.text!)
                        self.middleNameArray.append(cell.textFieldMiddleName.text!)
                        self.lastNameArray.append(cell.textFieldLastName.text!)
                        self.emailArray.append(cell.textFieldEmail.text!)
                        self.deginationArray.append(cell.textFielDesignation.text!)
                        self.phoneNoArray.append(cell.textFiledPhoneNumber.text!)
                        self.phoneCodes.append(self.selectedCountry.phoneCode)
                        self.countryCods.append(self.selectedCountry.code)
                    }
                    
                    
                    var count = item
                    // for data in titleArray.enumerated() { //---For multiple selection
                    
                    var dict = Dictionary<String,String>()
                    dict.updateValue(self.nameArray[count], forKey: "firstName")
                    dict.updateValue(self.middleNameArray[count], forKey: "middleName")
                    dict.updateValue(self.lastNameArray[count], forKey: "lastName")
                    dict.updateValue(self.emailArray[count], forKey: "emailId")
                    dict.updateValue(self.deginationArray[count], forKey: "designation")
                    dict.updateValue(self.phoneNoArray[count], forKey: "mobileNumber")
                    dict.updateValue(self.phoneCodes[count], forKey: "phonecode")
                    dict.updateValue(self.countryCods[count], forKey: "countrycode")
                    
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
                    
                    // return text
                    print("======================\(text)")
                    referenceWork.append(text)
                    
                    // }
                    
                    var textNew = "["
                    for index in 0..<referenceWork.count {
                        let item = referenceWork[index]
                        textNew += item
                        textNew += (index == referenceWork.count-1) ? "" : ","
                    }
                    textNew = textNew+"]"
                    finalString = textNew
                    print("-------------------textNew\(textNew)")
                    
                }else {
                    allField = false
                    // validateAddButton = false
                }
            }
            
            if allField {
                //                       print("finalString============\(finalString)")
                //                    self.getrefrences(refrences: finalString, journalistId: self.journalistId, stepCount: "3"
                print("finalString============\(finalString)")
                if getNoOfCell >= 3{
                    self.getrefrences(refrences: finalString, journalistId: self.journalistId, stepCount: "3")                }else {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Minimum three reference work is required")
                }
            }
            
        }
        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
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
                    let perviousWorkVC = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
                    perviousWorkVC.journalistId = journalistId
                    self.navigationController?.pushViewController(perviousWorkVC, animated: true)
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.referenceTableView.numberOfRows(inSection: self.referenceTableView.numberOfSections-1) - 1, section: self.referenceTableView.numberOfSections - 1)
            self.referenceTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
}

extension NewReferenceViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("====cell count====\(count)")
        return countArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewReferenceTableViewCell") as! NewReferenceTableViewCell
        
        if indexPath.row == 0 {
            cell.deleteButton.isHidden = true
        }else {
            cell.deleteButton.isHidden = false
        }
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(onclickDeleteButton(sender:)), for: .touchUpInside)
        
        
        cell.contryFlagImage.image = selectedCountry.flag
        cell.countryNamelabel.text = "(\(selectedCountry.code) )"+selectedCountry.phoneCode
        cell.countryCodeButton.addTarget(self, action: #selector(onClickSelectCountry(_:)), for: .touchUpInside)
        
        if indexPath.row < self.nameArray.count{
            cell.textFieldfirstName.text = self.nameArray[indexPath.row]
        }else{
            cell.textFieldfirstName.text = ""
        }
        
        if indexPath.row < self.lastNameArray.count{
            cell.textFieldLastName.text = self.lastNameArray[indexPath.row]
        }else {
            cell.textFieldLastName.text = ""
        }
        
        if indexPath.row < self.middleNameArray.count{
            cell.textFieldMiddleName.text = self.middleNameArray[indexPath.row]
        }else{
            cell.textFieldMiddleName.text = ""
        }
        
        if indexPath.row < self.emailArray.count{
            cell.textFieldEmail.text = self.emailArray[indexPath.row]
        }else {
            cell.textFieldEmail.text = ""
        }
        
        if indexPath.row < self.deginationArray.count{
            cell.textFielDesignation.text = self.deginationArray[indexPath.row]
        }else {
            cell.textFielDesignation.text = ""
        }
        
        if indexPath.row < self.phoneNoArray.count{
            cell.textFiledPhoneNumber.text = self.phoneNoArray[indexPath.row]
        }else {
            cell.textFiledPhoneNumber.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 540
    }
    
    @objc func addMoreWork(sender: UIButton) {
        
        self.scrollToBottom()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
            var numOfCell = self.referenceTableView.numberOfRows(inSection: 0)
            var lastIndex = numOfCell - 1
            var allField = false
            
            print("numOfCell ==== \(numOfCell)")
            
            guard let cell = self.referenceTableView.cellForRow(at: IndexPath(row: lastIndex, section: 0)) as? NewReferenceTableViewCell else { print("cell not found"); return }
            
            func isValidate()-> Bool {
                if cell.textFieldfirstName.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                else if cell.textFieldLastName.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                else if cell.textFieldEmail.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                else if !(cell.textFieldEmail.text?.isValidEmail)! {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                else if cell.textFielDesignation.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                else if cell.textFiledPhoneNumber.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above reference.")
                    return false
                }
                return true
            }
            
            // print(isValidate())
            
            if isValidate() {
                allField = true
                if let nameA = self.nameArray.last, let nameC = cell.textFieldfirstName.text, nameA == nameC,
                    let middleA = self.middleNameArray.last, let middleC = cell.textFieldMiddleName.text, middleA == middleC,
                    let lastA = self.lastNameArray.last, let lastC = cell.textFieldLastName.text, lastA == lastC,
                    let emailA = self.emailArray.last, let emailC = cell.textFieldEmail.text, emailA == emailC,
                    let deginationA = self.deginationArray.last, let deginationC = cell.textFielDesignation.text, deginationA == deginationC,
                    let phoneA = self.phoneNoArray.last, let phoneC = cell.textFiledPhoneNumber.text, phoneA == phoneC,
                    let phoneCodesA = self.phoneCodes.last, phoneCodesA == self.selectedCountry.phoneCode,
                    let countryCodsA = self.countryCods.last, countryCodsA == self.selectedCountry.code {
                    
                    self.countArray.append(1)
                    self.referenceTableView.reloadData()
                    
                    return
                }
                
                self.nameArray.append(cell.textFieldfirstName.text!)
                self.middleNameArray.append(cell.textFieldMiddleName.text!)
                self.lastNameArray.append(cell.textFieldLastName.text!)
                self.emailArray.append(cell.textFieldEmail.text!)
                self.deginationArray.append(cell.textFielDesignation.text!)
                self.phoneNoArray.append(cell.textFiledPhoneNumber.text!)
                self.phoneCodes.append(self.selectedCountry.phoneCode)
                self.countryCods.append(self.selectedCountry.code)
                
                self.countArray.append(1)
                self.referenceTableView.reloadData()
            } else {
                allField = false
            }
        }
        
        
    }
    
    @objc func onclickDeleteButton(sender: UIButton) {
        let index = sender.tag
        print("==========DeleteButtonIndex=========\(index)")
        // countArray.remove(at: index)
        // referenceTableView.reloadData()
        
        // create the alert
        
        //        self.scrollToBottom()
        //        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
        
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this reference", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "DELETE", style: UIAlertAction.Style.destructive, handler: { ACTION in
            let index = sender.tag
            self.countArray.remove(at: index)
            
            if index < self.nameArray.count{
                self.nameArray.remove(at: index)
            }
            
            if index < self.middleNameArray.count{
                self.middleNameArray.remove(at: index)
            }
            
            if index < self.lastNameArray.count{
                self.lastNameArray.remove(at: index)
            }
            
            if index < self.deginationArray.count{
                self.deginationArray.remove(at: index)
            }
            
            if index < self.phoneNoArray.count{
                self.phoneNoArray.remove(at: index)
            }
            
            if index < self.phoneCodes.count{
                self.phoneCodes.remove(at: index)
            }
            
            if index < self.countryCods.count{
                self.countryCods.remove(at: index)
            }
            
            
            
            self.referenceTableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //    }
}


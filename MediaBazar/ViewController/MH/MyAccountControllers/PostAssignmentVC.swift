//
//  PostAssignmentVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PostAssignmentVC: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonPost: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var textFiledCurrency: UITextField!
    @IBOutlet weak var textFieldLanguage: UITextField!
    @IBOutlet weak var textFiledTitle: UITextField!
    @IBOutlet weak var textFiledPrice: UITextField!
    @IBOutlet weak var textFiledCountry: UITextField!
    
    @IBOutlet weak var dateTextField : UITextField!
    @IBOutlet weak var timeTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    
    @IBOutlet weak var keywordView : UIView!
    
    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    @IBOutlet weak var keywordButton : UIButton!
    
    
    var langData = ""
    var countryData = ""
    var stateData = ""
    var cityData = ""
    var countryID = ""
    var stateID = ""
    var cityID = ""
    var langCode = ""
    var currencyCode = ""
    var keyWordNameArray = [String]()
    var currenUserLogin : User!
    var assignmentData = PostAssignmentModel()
    
    var datetextField = UITextField()
    var datePickerView : UIDatePicker = UIDatePicker()
    var dateD: Date?
    
    var timetextField = UITextField()
    var timePickerView : UIDatePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupCollectionView()
        setUpDatePickerView()
        setUpTimePickerView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keywordView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        
        buttonPost.makeRoundCorner(20)

        textFiledCurrency.delegate = self
        textFieldLanguage.delegate = self
        textFiledCountry.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        timeTextField.delegate = self
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        buttonPost.addTarget(self, action: #selector(postBtnPressed), for: .touchUpInside)
        keywordButton.addTarget(self, action: #selector(onClickKeywords), for: .touchUpInside)
        
    }
    
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
        keywordsCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
        self.keywordsCollectionView.dataSource = self
        self.keywordsCollectionView.delegate = self
        
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        if let aoiFlowLayout = keywordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
        }
        
    }
    
    
    
    
    fileprivate func setUpDatePickerView(){
        self.datetextField = dateTextField
        self.datetextField.delegate = self
        
        self.datetextField.inputView = self.datePickerView
        datePickerView = UIDatePicker()
        
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date()
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(PostStoryViewControllerJM.dateChanged(datePicker:)), for: .valueChanged)
        datePickerView.minimumDate = Date()
        
    }
    
    fileprivate func setUpTimePickerView(){
        self.timetextField = timeTextField
        self.timetextField.delegate = self
        self.timetextField.inputView = self.timePickerView
        timePickerView = UIDatePicker()
        let calendar = NSCalendar.current
        let components = NSDateComponents()
        components.hour = 0
        components.minute = 0
        timePickerView.setDate(calendar.date(from: components as DateComponents)!, animated: true)
        timePickerView.datePickerMode = .time
        timePickerView.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        timeTextField.inputView = timePickerView
        timePickerView.addTarget(self, action: #selector(toTimeChanged(datePicker:)), for: .valueChanged)
        
    }
    
    
    
    @objc func dateChanged(datePicker : UIDatePicker ){
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateD = datePicker.date
        datetextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func toTimeChanged(datePicker : UIDatePicker ){
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timetextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    @objc func backBtnPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func postBtnPressed() {
        if isValidate() {
            
            let keyWord = "\(keyWordNameArray)"
            var keyWordDataId = keyWord.replacingOccurrences(of: "[", with: "")
            keyWordDataId = keyWordDataId.replacingOccurrences(of: "]", with: "")
            keyWordDataId = keyWordDataId.replacingOccurrences(of: "\"", with: "")
            keyWordDataId = keyWordDataId.replacingOccurrences(of: " ", with: "")
            print("=========keyWord=========\(keyWordDataId)")
            
            postAssignmentData(assignmentTitle: textFiledTitle.text!, langCode: textFieldLanguage.text!, keyWords: keyWordDataId, date: datetextField.text!, time: timeTextField.text!, currency: currencyCode, price: textFiledPrice.text!, country: countryData, state: stateData, city: cityData, assignmentDescription: textView.text!, header: currenUserLogin.mediahouseToken)
        }
    }
    
    
    @objc func onClickKeywords(){
        let keywordVC = AppStoryboard.PreLogin.viewController(CustomKeywordSearchVC.self)
        keywordVC.delegate = self
        keywordVC.selectedKeywords = keyWordNameArray
        self.present(keywordVC, animated: true, completion: nil)
    }
    
    
    //------postAssignment----------
    func postAssignmentData(assignmentTitle: String, langCode: String,keyWords: String, date: String, time: String, currency: String, price:String, country: String, state: String, city: String,assignmentDescription: String, header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.postAssignment(assignmentTitle: assignmentTitle, langCode: langCode, keyWordId: keyWords, date: date, time: time, currency: currency, price: price, country: country, state: state, city: city, assignmentDescription: assignmentDescription, header: header){ (result, message, response) in
            CommonClass.hideLoader()
            if result == 200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func isValidate()-> Bool {
        
        if textFiledTitle.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the title.")
            return false
        } else if textFieldLanguage.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the language.")
            return false
        } else if keyWordNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the keyword")
            return false
        } else if datetextField.text == ""{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the date")
            return false
        }else if timeTextField.text == ""{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the time")
            return false
        }else if textFiledCountry.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the country.")
            return false
        }else if textFiledCurrency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the currency.")
            return false
        } else if textFiledPrice.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the price.")
            return false
        } else if textView.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the description.")
            return false
        }
        return true
    }
    
}

extension PostAssignmentVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyWordNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        //keywordsCollectionView
        //cell.delegate = self
        cell.aoiLabel.text = keyWordNameArray[indexPath.item]
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(deleteCellkeyword(sender:)), for: .touchUpInside)
        return cell
        
        
    }
    
    
    @objc func deleteCellkeyword(sender: UIButton){
        print(sender.tag)
        let name = keyWordNameArray[sender.tag]
        keyWordNameArray.removeAll(where: { $0 == name })
        keywordsCollectionView.reloadData()
        
    }
}

//------- TextField delegate ------
extension PostAssignmentVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == textFieldLanguage {
            let preLangugeVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
            preLangugeVC.delegate = self
            self.present(preLangugeVC, animated: true, completion: nil)
            
        } else if textField == textFiledCountry {
            let countrySearchVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
            countrySearchVC.delegate = self
            self.present(countrySearchVC, animated: true, completion: nil)
        } else if textField == stateTextField{
            if textFiledCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryID
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == cityTextField{
            if textFiledCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if stateTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else if textField == cityTextField{
                let citySearchVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
                citySearchVC.delegate = self
                citySearchVC.stateId = stateID
                self.present(citySearchVC, animated: true, completion: nil)
            }
        }else if textField == textFiledCurrency {
            let currencySearchVC = AppStoryboard.Journalist.viewController(CurrencySearchVC.self)
            currencySearchVC.delegate = self
            self.present(currencySearchVC, animated: true, completion: nil)
        }
    }
}


extension PostAssignmentVC: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        textFiledCountry.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
        
        self.textFiledCountry.text = name
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

extension PostAssignmentVC: SendNameOfState{
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
        stateTextField.resignFirstResponder()
        if name == "" && id == "" && countyId == "" && symobol == "" && currencyName == ""{
            return
        }
        self.stateTextField.text = name
        self.stateID = id
        self.stateData = id
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

extension PostAssignmentVC: SendNameOfCity{
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


extension PostAssignmentVC: SendNameOfLanguage {
    func languageName(name: String, id: String, langKey: String) {
        textFieldLanguage.resignFirstResponder()
        if name == "" && id == "" && langKey == ""{
            return
        }
        textFieldLanguage.text = name
        self.langCode = langKey
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

//------getting currenctData data
extension PostAssignmentVC: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        textFiledCurrency.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.textFiledCurrency.text = name
        self.currencyCode = id
    }
}

//-------getKeywordsName-----
extension PostAssignmentVC: SendKeywordName {
    func keywordName(name: [String]) {
        print("================\(name)")
        //self.keyWordNameArray = name
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordsCollectionView.reloadData()
        
    }
}

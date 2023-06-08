//
//  CreateAssignmentViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 11/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CreateAssignmentViewControllerJM: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var createButton : UIButton!
    
    @IBOutlet weak var headlineTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    @IBOutlet weak var timeTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var brifDescri : UITextView!
    @IBOutlet weak var currencyTextField : UITextField!
    @IBOutlet weak var priceTextFiled : UITextField!
    
    @IBOutlet weak var keywordView : UIView!
    
    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    @IBOutlet weak var keywordButton : UIButton!
    
    
    @IBOutlet weak var categoryTypeView : UIView!
    
    @IBOutlet weak var LiveButton : UIButton!
    
    
    var datetextField = UITextField()
    var datePickerView : UIDatePicker = UIDatePicker()
    var dateD: Date?
    
    var timetextField = UITextField()
    var timePickerView : UIDatePicker = UIDatePicker()
    
    var currentuserLogin : User!
    var countryData = ""
    var stateData = ""
    var cityData = ""
    var countryID = ""
    var stateID = ""
    var cityID = ""
    var currencyCode = ""
    var keyWordNameArray = [String]()
    
    
    var keyWordIDs = [String]()

    
    
    var liveButtonStatus = "0"
    
    var getAssignmentData = listStory()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentuserLogin = User.loadSavedUser()
        setUpUI()
        setUpButton()
        setupCollectionView()
        setUpDatePickerView()
        setUpTimePickerView()
        countryTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        currencyTextField.delegate = self
        timeTextField.delegate = self
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        topView.applyShadow()
        createButton.makeRoundCorner(20)
        CommonClass.makeViewCircularWithCornerRadius(brifDescri, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keywordView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        categoryTypeView.isHidden = true
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
        keywordButton.addTarget(self, action: #selector(onClickKeywords), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(onClickCreateButton), for: .touchUpInside)
        LiveButton.addTarget(self, action: #selector(liveButtonPressed), for: .touchUpInside)
        
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
    
//    fileprivate func setupCollectionView() {
//        let nib = UINib(nibName: "KeywordsCollectionViewCell", bundle: nil)
//        keywordCollectionView.register(nib, forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
//
//        self.keywordCollectionView.dataSource = self
//        self.keywordCollectionView.delegate = self
//
//        if let flowLayout = keywordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
//    }
    
    

    
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

    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func liveButtonPressed() {
        LiveButton.isSelected = !LiveButton.isSelected
        if LiveButton.isSelected{
            liveButtonStatus = "1"
            categoryTypeView.isHidden = false
        } else {
            liveButtonStatus = "0"
            categoryTypeView.isHidden = true
        }
    }
    
    @objc func onClickKeywords(){
        let keywordVC = AppStoryboard.PreLogin.viewController(CustomKeywordSearchVC.self)
        keywordVC.delegate = self
        keywordVC.selectedKeywords = keyWordNameArray
        self.present(keywordVC, animated: true, completion: nil)
    }

    
    @objc func onClickCreateButton(){
        
        guard let headline = headlineTextField.text, headline != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the headline")
            return
        }
        
        guard keyWordNameArray.count > 0 else {
                 NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the keyword")
                 return
             }
        
        guard let date = dateTextField.text, date != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the date")
            return
        }
        
        guard let time = timeTextField.text, time != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the time")
            return
        }
        
        guard let country = countryTextField.text, country != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the country")
            return
        }
        
//        guard let state = stateTextField.text, state != "" else {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the country first")
//            return
//        }
//
//        guard let city = cityTextField.text, city != "" else {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the state first")
//            return
//        }
        
        guard let disc = brifDescri.text, disc != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the description")
            return
        }
        
        
        if liveButtonStatus == "1"{
            guard let currency = currencyTextField.text, currency != "" else {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the currency")
                return
            }

            guard let price = priceTextFiled.text, price != "" else {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the price")
                return
            }
        }
        
        let keyWord = "\(keyWordNameArray)"
        var keyWordDataId = keyWord.replacingOccurrences(of: "[", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "]", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "\"", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: " ", with: "")
        print("=========keyWord=========\(keyWordDataId)")
        
        //        addAssignment(journalistHeadline: headlineTextField.text!, date: dateTextField.text!, time: timeTextField.text!, country: countryData, state: stateData, city: cityData, journalistDescri: brifDescri.text!, header: currentuserLogin.token)
        if liveButtonStatus == "0"{
            addAssignment(journalistHeadline: headlineTextField.text!, keyWords: keyWordDataId, date: dateTextField.text!, time: timeTextField.text!, country: countryData, state: stateData, city: cityData, journalistDescri: brifDescri.text!, header: currentuserLogin.token, live: liveButtonStatus, price: "", currency: "")
        } else {
            addAssignment(journalistHeadline: headlineTextField.text!, keyWords: keyWordDataId, date: dateTextField.text!, time: timeTextField.text!, country: countryData, state: stateData, city: cityData, journalistDescri: brifDescri.text!, header: currentuserLogin.token, live: liveButtonStatus, price: priceTextFiled.text!, currency: currencyCode)
        }
        
        
    }
    
    
    func addAssignment(journalistHeadline: String,keyWords: String, date: String, time: String, country: String, state: String, city: String, journalistDescri: String, header : String, live : String, price : String, currency : String){
        Webservices.sharedInstance.createAssignment(journalistHeadline: journalistHeadline, keyWordId: keyWords, date: date, time: time, journalistDescription: journalistDescri, country: country, state: state, city: city, brifDesc: journalistDescri, header: header, live: live, price: price, currency: currency){
            (result,message,response) in
            
            if result == 200{
                print(response)
                
                self.navigationController?.popViewController(animated: true)
                //
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }

}


extension CreateAssignmentViewControllerJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension CreateAssignmentViewControllerJM: UITextFieldDelegate {
    
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
                stateSearchVC.countryId = countryID
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == cityTextField{
            if countryTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if stateTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else if textField == cityTextField{
                let citySearchVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
                citySearchVC.delegate = self
                citySearchVC.stateId = stateID
                self.present(citySearchVC, animated: true, completion: nil)
            }
        }else if textField == currencyTextField{
            let currencySearchVC = AppStoryboard.Journalist.viewController(CurrencySearchVC.self)
            currencySearchVC.delegate = self
            self.present(currencySearchVC, animated: true, completion: nil)
            
        }
    }
}




extension CreateAssignmentViewControllerJM: SendNameOfCountry{
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        
        self.countryTextField.text = name
        self.countryID = id
        self.countryData = id
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

extension CreateAssignmentViewControllerJM: SendNameOfState{
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
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

extension CreateAssignmentViewControllerJM: SendNameOfCity{
    func cityName(name: String, id: String, stateId: String) {
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

extension CreateAssignmentViewControllerJM: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        currencyTextField.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.currencyTextField.text = name
        self.currencyCode = id
    }
}

//-------getKeywordsName-----
extension CreateAssignmentViewControllerJM: SendKeywordName {
    func keywordName(name: [String]) {
        print("================\(name)")
        //self.keyWordNameArray = name
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordsCollectionView.reloadData()

    }
}


extension String {
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(location: 0, length: self.utf16.count)) ?? 0
    }
}

//let text = "I live in iran and i love Here"
//print(text.wordCount) // 8

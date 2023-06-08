//
//  SharedSellStoryControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class SharedSellStoryControllerJM: UIViewController {

    @IBOutlet weak var headlineTextField : UITextField!
    @IBOutlet weak var categoryTextField : UITextField!
    @IBOutlet weak var purchesTextField : UITextField!
    @IBOutlet weak var languageTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var currencyTextField : UITextField!
    @IBOutlet weak var priceTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    
    @IBOutlet weak var keyWordView : UIView!
    @IBOutlet weak var textView : UITextField!
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    
    @IBOutlet weak var keywordButton : UIButton!
    @IBOutlet weak var continueButton : UIButton!
    
    @IBOutlet weak var checkTermsButton : UIButton!
    @IBOutlet weak var salesAndConditionButton : UIButton!
    
    var checkButtonFlag = false
    
    var datetextField = UITextField()
    var datePickerView : UIDatePicker = UIDatePicker()
    var dateD: Date?
    
    var countryData = ""
    var languageData = ""
    var stateData = ""
    var cityData = ""
    var countryID = ""
    var stateID = ""
    var cityID = ""
    var categoryId = ""
    var currencyCode = ""
    var currentUserLogin : User!
    var sharedStorydata = storyModal()

    var keywordList = [String]()
    var keywordIds = [String]()
    var currentDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setUpDatePickerView()
        setupCollectionView()
        setUpData()
        countryTextField.delegate = self
        languageTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        categoryTextField.delegate = self
        currencyTextField.delegate = self
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keyWordView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)

    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        keywordButton.addTarget(self, action: #selector(onClickeyword), for: .touchUpInside)
        checkTermsButton.addTarget(self, action: #selector(onclickSalestermsButton(_:)), for: .touchUpInside)
        salesAndConditionButton.addTarget(self, action: #selector(onClickSalesConditionButton), for: .touchUpInside)
    }
    
    func setUpData(){
        
        self.countryTextField.text = self.currentUserLogin.prevJouralistData.country.name
        self.stateTextField.text = self.currentUserLogin.prevJouralistData.state.stateName
        self.cityTextField.text = self.currentUserLogin.prevJouralistData.city.cityName
        self.currencyTextField.text = self.currentUserLogin.prevJouralistData.country.currencyName
        self.languageTextField.text = self.currentUserLogin.language
        self.dateTextField.text = self.currentDate
        
//        print("currentDate=======\(self.currentDate)")
        
    }
    
    
    @objc func onclickSalestermsButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            checkButtonFlag = true
        } else if sender.isSelected == false {
            checkButtonFlag = false
        }
    }
    
    @objc func onClickSalesConditionButton(){
        let privacyVC = AppStoryboard.Journalist.viewController(SalesTermsAndConditionViewControllerJM.self)
        self.navigationController?.pushViewController(privacyVC, animated: true)
    }
    
    @objc func onClickContinueButton(){
        
        guard let headline = headlineTextField.text, headline != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the headline")
            return
        }
        
        guard let category = categoryTextField.text, category != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the category")
            return
        }
        
        guard let purchaseLimit = purchesTextField.text, purchaseLimit != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the purchase limit")
            return
        }
        
        guard let language = languageTextField.text, language != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the language")
            return
        }
        
        guard let country = countryTextField.text, country != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the country")
            return
        }
        
        guard let state = stateTextField.text, state != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the state")
            return
        }
        
        guard let city = cityTextField.text, city != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the city")
            return
        }
        
        guard let currency = currencyTextField.text, currency != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the currency")
            return
        }
        
        guard let price = priceTextField.text, price != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the price")
            return
        }
        
        guard let date = dateTextField.text, date != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the date")
            return
        }
        
        guard keywordList.count > 0 else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the keyword")
            return
        }
        
        guard let desci = textView.text, desci != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the text")
            return
        }
        
        if checkButtonFlag == false {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please agree sales terma and conditions.")
            
        }
        
        let keyWord = "\(keywordList)"
        var keyWordDataId = keyWord.replacingOccurrences(of: "[", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "]", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "\"", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: " ", with: "")
        print("=========keyWord=========\(keyWordDataId)")

        
        sharedSellStory(headLine: headlineTextField.text!, categoryID: categoryId, languageCode: languageTextField.text!, purchasePrice: purchesTextField.text!, country: countryData, state: stateData, city: cityData, date: dateTextField.text!, stepCount: "1", keywordID: keyWordDataId, storyCategory: "Shared", currency: currencyCode, price: priceTextField.text!, description: textView.text!, header: currentUserLogin.token)


//        let postVC = AppStoryboard.Journalist.viewController(PostStoryTypeViewControllerJM.self)
//        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func onClickeyword(){
        let keyWordVC = AppStoryboard.PreLogin.viewController(CustomKeywordSearchVC.self)
        keyWordVC.delegate = self
        self.present(keyWordVC, animated: true, completion: nil)
    }

    
    @objc func dateChanged(datePicker : UIDatePicker ){
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateD = datePicker.date
        datetextField.text = dateFormatter.string(from: datePicker.date)
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
        
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.currentDate = dateFormatter.string(from: todaysDate)
        
        print("currentDate=========\(currentDate)")
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "KeywordsCollectionViewCell", bundle: nil)
        keywordCollectionView.register(nib, forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        self.keywordCollectionView.dataSource = self
        self.keywordCollectionView.delegate = self
        
        if let flowLayout = keywordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func sharedSellStory(headLine: String, categoryID: String, languageCode: String, purchasePrice: String, country: String, state: String, city: String, date: String, stepCount: String, keywordID : String, storyCategory: String, currency: String, price: String, description: String,header: String){
        Webservices.sharedInstance.sharedSellStrotyForm(headLine: headLine, categoryId: categoryID, languageCode: languageCode, purchasePrice: purchasePrice, country: country, state: state, city: city, date: date, stepCount: stepCount, keyWordId: keywordID, storyCategory: storyCategory, currency: currency, price: price, description: description, header: header){
            (result,message,response) in
            if result == 200{
                print(response)
                if let somecategory = response{
                    self.sharedStorydata = somecategory
                    print("======================\(somecategory)")
                }
                let PostStoryTypeVC = AppStoryboard.Journalist.viewController(PostStoryTypeViewControllerJM.self)
                PostStoryTypeVC.blogId = self.sharedStorydata.blogID
                PostStoryTypeVC.storyType = "sellStory"
                self.navigationController?.pushViewController(PostStoryTypeVC, animated: true)
                
            } else {
                
            }
        }
    }

}

extension SharedSellStoryControllerJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywordList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as? KeywordsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.keywordLabel.text = keywordList[indexPath.item]
        return cell
        
    }
}

extension SharedSellStoryControllerJM: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == countryTextField{
            let countryListVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
            countryListVC.delegate = self
            self.present(countryListVC, animated: true, completion: nil)
        } else if textField == languageTextField{
            let languageListVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
            languageListVC.delegate = self
            self.present(languageListVC, animated: true, completion: nil)
        } else if textField == stateTextField{
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
            } else {
                let citySearchVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
                citySearchVC.delegate = self
                citySearchVC.stateId = stateID
                self.present(citySearchVC, animated: true, completion: nil)
            }
        } else if textField == categoryTextField{
            let categoryVC = AppStoryboard.Journalist.viewController(CategorySearchVC.self)
            categoryVC.delegate = self
            self.present(categoryVC, animated: true, completion: nil)
        } else if textField == currencyTextField{
            let currencySearchVC = AppStoryboard.Journalist.viewController(CurrencySearchVC.self)
            currencySearchVC.delegate = self
            self.present(currencySearchVC, animated: true, completion: nil)

//            if countryTextField.text == "" {
//                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
//            } else {
//                let stateSearchVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
//                stateSearchVC.delegate = self
//                stateSearchVC.countryId = countryID
//                self.present(stateSearchVC, animated: true, completion: nil)
//            }
        }
    }
}

extension SharedSellStoryControllerJM : SendNameOfLanguage{
    func languageName(name: String, id: String, langKey: String) {
        languageTextField.resignFirstResponder()
        if name == "" && id == "" && langKey == ""{
            return
        }
        self.languageTextField.text = name
        self.languageData = name
    }
    
    
}

extension SharedSellStoryControllerJM: SendNameOfCountry {
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

extension SharedSellStoryControllerJM: SendNameOfState {
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String) {
        stateTextField.resignFirstResponder()
        if name == "" && id == "" && countyId == "" && symobol == "" && currencyName == ""{
            return
        }
        self.stateTextField.text = name
//        self.currencyTextField.text = currencyName
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

extension SharedSellStoryControllerJM: SendNameOfCity {
    
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

extension SharedSellStoryControllerJM : SendNameOfCategory{
    func CategoryName(text: String, id: String) {
        categoryTextField.resignFirstResponder()
        if text == "" && id == ""{
            return
        }
        self.categoryTextField.text = text
        self.categoryId = id
    }
    
}

extension SharedSellStoryControllerJM: SendKeywordName{
    func keywordName(name: [String]) {
        keywordList.append(contentsOf: name)
        keywordCollectionView.reloadData()
    }
}

//------getting currenctData data
extension SharedSellStoryControllerJM: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        currencyTextField.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.currencyTextField.text = name
        self.currencyCode = id
    }
}



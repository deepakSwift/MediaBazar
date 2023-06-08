//
//  EditExclusiveStoryViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 09/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditExclusiveStoryViewControllerJM: UIViewController, SendJobKeywordName {
    
    @IBOutlet weak var headlineTextField : UITextField!
    @IBOutlet weak var categoryTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    @IBOutlet weak var languageTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextFiled : UITextField!
    @IBOutlet weak var currencyTextField : UITextField!
    @IBOutlet weak var priceTextFiled : UITextField!
    
    @IBOutlet weak var keywordView : UIView!
    @IBOutlet weak var textView : UITextField!
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var keywordButton : UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var currenUserLogin : User!
    var countryId = ""
    var countryData = ""
    var stateId = ""
    var stateData = ""
    var cityData = ""
    var languageData = ""
    var categoryId = ""
    var categoryName = ""
    var currencyCode = ""
    var keyWordNameArray = [String]()
    var keywordsArrayConvertedFormat = ""
    
    
    var storyDetailData = storyListModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setUpButton()
        setupCollectionView()
        setUpUI()
        setupTextFields()
        setUpPerviousData()
        // Do any additional setup after loading the view.
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        keywordButton.addTarget(self, action: #selector(keywordButtonPressed), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keywordView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
        keywordCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
        
        self.keywordCollectionView.dataSource = self
        self.keywordCollectionView.delegate = self
    }
    
    func setupTextFields() {
        categoryTextField.delegate = self
        languageTextField.delegate = self
        countryTextField.delegate = self
        stateTextField.delegate = self
        cityTextFiled.delegate = self
        currencyTextField.delegate = self
    }
    
    
    
    func setUpPerviousData(){
        for data in storyDetailData.keywordName.enumerated(){
            keyWordNameArray.append(data.element)
            let keyName = "\(keyWordNameArray)"
            var keywords = keyName.replacingOccurrences(of: "[", with: "")
            keywords = keywords.replacingOccurrences(of: "]", with: "")
            keywords = keywords.replacingOccurrences(of: "\"", with: "")
            keywords = keywords.replacingOccurrences(of: " ", with: "")
            self.keywordsArrayConvertedFormat = keywords
        }
        
        headlineTextField.text = storyDetailData.headLine
        categoryTextField.text = storyDetailData.categoryId.categoryName
        self.categoryId = storyDetailData.categoryId.id
        languageTextField.text = storyDetailData.langCode
        dateTextField.text = String(storyDetailData.createdAt.prefix(10))
        currencyTextField.text = storyDetailData.realCurrencyName
        priceTextFiled.text = storyDetailData.realPrice
        textView.text = storyDetailData.briefDescription
        
        //-----CountryData-----
        countryTextField.text = storyDetailData.country.name
        var countryObject: [String:String] = [:]
        countryObject.updateValue(storyDetailData.country.name, forKey: "name")
        countryObject.updateValue(storyDetailData.country.placeId, forKey: "id")
        countryObject.updateValue(storyDetailData.country.sortName, forKey: "sortname")
        countryObject.updateValue(storyDetailData.country.phoneCode, forKey: "phonecode")
        countryObject.updateValue(storyDetailData.country.symbol, forKey: "symbol")
        countryObject.updateValue(storyDetailData.country.currencyName, forKey: "currencyName")
        let jsonData = try! JSONSerialization.data(withJSONObject: countryObject, options: .prettyPrinted)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            countryData = jsonString
        }
        
        //-----StateData-----
        stateTextField.text = storyDetailData.state.stateName
        var stateObject: [String:String] = [:]
        stateObject.updateValue(storyDetailData.state.stateId, forKey: "id")
        stateObject.updateValue(storyDetailData.state.stateName, forKey: "name")
        stateObject.updateValue(storyDetailData.state.countryId, forKey: "country_id")
        stateObject.updateValue(storyDetailData.state.symbol, forKey: "symbol")
        stateObject.updateValue(storyDetailData.state.currencyName, forKey: "currencyName")
        let stateJsonData = try! JSONSerialization.data(withJSONObject: stateObject, options: .prettyPrinted)
        if let jsonString = String(data: stateJsonData, encoding: .utf8) {
            print(jsonString)
            stateData = jsonString
        }
        
        //-----CityData-----
        cityTextFiled.text = storyDetailData.city.name
        var cityObject: [String:String] = [:]
        cityObject.updateValue(storyDetailData.city.placeId, forKey: "id")
        cityObject.updateValue(storyDetailData.city.name, forKey: "name")
        cityObject.updateValue(storyDetailData.city.stateId, forKey: "state_id")
        let cityjsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        if let jsonString = String(data: cityjsonData, encoding: .utf8) {
            print(jsonString)
            cityData = jsonString
        }
        
        
    }
    
    @objc func clickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keywordButtonPressed() {
        let keywordVC = AppStoryboard.PreLogin.viewController(CustomKeywordSearchVC.self)
        keywordVC.delegate = self
        self.present(keywordVC, animated: true, completion: nil)
    }
    
    
    @objc func onClickContinueButton(){
        //        if isValidate(){
        
        guard let headline = headlineTextField.text, headline != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the headline")
            return
        }
        
        guard let category = categoryTextField.text, category != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the category")
            return
        }
        
        guard let date = dateTextField.text, date != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the date")
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
        
        guard let city = cityTextFiled.text, city != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the city")
            return
        }
        
        guard let currency = currencyTextField.text, currency != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the currency")
            return
        }
        
        guard let price = priceTextFiled.text, price != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the price")
            return
        }
        
        guard keyWordNameArray.count > 0 else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the keyword")
            return
        }
        
        guard let descri = textView.text, descri != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the text")
            return
        }
        
        updateExclusiveStory(storyID: storyDetailData.id, headline: headlineTextField.text!, categoryID: categoryId, languageCode: languageTextField.text!, country: countryData, state: stateData, city: cityData, date: dateTextField.text!, stepCount: "1", keyWords: keywordsArrayConvertedFormat, storyCategory: "Exclusive", currency: currencyCode, price: priceTextFiled.text!, descri: textView.text!, header: currenUserLogin.token)
        //        }
    }
    
    
    func updateExclusiveStory(storyID: String,headline: String, categoryID : String, languageCode : String, country: String, state: String, city: String, date: String, stepCount: String,keyWords: String, storyCategory: String, currency: String, price: String, descri : String, header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.updateSellStrotyForm(storyID: storyID, headLine: headline, categoryId: categoryID, languageCode: languageCode, country: country, state: state, city: city, date: date, stepCount: "1", keyWordName: keyWords, storyCategory: storyCategory, currency: currency, price: price, description: descri, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                print(response)
                let PostStoryTypeVC = AppStoryboard.Journalist.viewController(EditPostTypeStoryViewController.self)
                PostStoryTypeVC.storyDetail = self.storyDetailData
                self.navigationController?.pushViewController(PostStoryTypeVC, animated: true)

                
            } else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                
            }
        }
    }
    
    
}

extension EditExclusiveStoryViewControllerJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        //self.setupPreviousData()
        let langData = "\(keyWordNameArray)"
        var keywords = langData.replacingOccurrences(of: "[", with: "")
        keywords = keywords.replacingOccurrences(of: "]", with: "")
        keywords = keywords.replacingOccurrences(of: "\"", with: "")
        keywords = keywords.replacingOccurrences(of: " ", with: "")
        self.keywordsArrayConvertedFormat = keywords
        keywordCollectionView.reloadData()
        
    }
}

extension EditExclusiveStoryViewControllerJM: UITextFieldDelegate {
    
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
                stateSearchVC.countryId = countryId
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == cityTextFiled{
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
//                stateSearchVC.countryId = countryId
//                self.present(stateSearchVC, animated: true, completion: nil)
//            }
        }
    }
}




extension EditExclusiveStoryViewControllerJM: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        countryTextField.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
        self.countryTextField.text = name
//        self.currencyTextField.text = currencyName
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

extension EditExclusiveStoryViewControllerJM: SendNameOfState {
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

extension EditExclusiveStoryViewControllerJM: SendNameOfCity {
    func cityName(name: String, id: String, stateId: String) {
        cityTextFiled.resignFirstResponder()
        if name == "" && id == "" && stateId == ""{
            return
        }
        self.cityTextFiled.text = name
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

//-----gettingJob Keywords-------
extension EditExclusiveStoryViewControllerJM: SendKeywordName{
    func keywordName(name: [String]) {
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordCollectionView.reloadData()
        
        let langData = "\(keyWordNameArray)"
        var keywords = langData.replacingOccurrences(of: "[", with: "")
        keywords = keywords.replacingOccurrences(of: "]", with: "")
        keywords = keywords.replacingOccurrences(of: "\"", with: "")
        keywords = keywords.replacingOccurrences(of: " ", with: "")
        self.keywordsArrayConvertedFormat = keywords
        
    }
    
}

extension EditExclusiveStoryViewControllerJM : SendNameOfCategory{
    func CategoryName(text: String, id: String) {
        categoryTextField.resignFirstResponder()
        if text == "" && id == ""{
            return
        }
        self.categoryTextField.text = text
        self.categoryId = id
    }
    
}

extension EditExclusiveStoryViewControllerJM : SendNameOfLanguage{
    func languageName(name: String, id: String, langKey: String) {
        languageTextField.resignFirstResponder()
        if name == "" && id == "" && langKey == ""{
            return
        }
        self.languageTextField.text = name
        self.languageData = name
    }
}

extension EditExclusiveStoryViewControllerJM: SendNameOfCurrency {
    func currencyName(name: String, id: String) {
        currencyTextField.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        self.currencyTextField.text = name
        self.currencyCode = id
    }
}

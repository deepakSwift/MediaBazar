//
//  PostStoryViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class PostStoryViewControllerJM: UIViewController {
    
    @IBOutlet weak var headLineTextField : UITextField!
    @IBOutlet weak var categoryTextField : UITextField!
    @IBOutlet weak var languageTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    
    @IBOutlet weak var keywordView : UIView!
    @IBOutlet weak var textView : UITextField!
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var keywordButton : UIButton!
    
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
    var categoryID = ""
    var keywordList = [String]()
    var keywordID = [String]()
    
    var currentDate = ""
    
    var getBlogStorydata = storyModal()
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setUpUI()
        setUpButton()
        setupCollectionView()
        setUpDatePickerView()
        setUpData()
        countryTextField.delegate = self
        languageTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        categoryTextField.delegate = self
        
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keywordView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        
        
    }
    
    func setUpButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        keywordButton.addTarget(self, action: #selector(onClickeyword), for: .touchUpInside)
        checkTermsButton.addTarget(self, action: #selector(onclickSalestermsButton(_:)), for: .touchUpInside)
        salesAndConditionButton.addTarget(self, action: #selector(onClickSalesConditionButton), for: .touchUpInside)
    }
    
    func setUpData(){
        
        self.countryTextField.text = self.currentUserLogin.prevJouralistData.country.name
        self.stateTextField.text = self.currentUserLogin.prevJouralistData.state.stateName
        self.cityTextField.text = self.currentUserLogin.prevJouralistData.city.cityName
        self.dateTextField.text = self.currentDate
        
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


    
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "KeywordsCollectionViewCell", bundle: nil)
        keywordCollectionView.register(nib, forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        self.keywordCollectionView.dataSource = self
        self.keywordCollectionView.delegate = self
        
        if let flowLayout = keywordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
        
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.currentDate = dateFormatter.string(from: todaysDate)
        print("currentDate========\(currentDate)")
        
    }
    
    
    @objc func onClickContinueButton(){

        guard let headline = headLineTextField.text, headline != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the headline")
            return
        }

        guard let category = categoryTextField.text, category != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the  category")
            return
        }

        guard let language = languageTextField.text, language != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the  language")
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

        guard let date = dateTextField.text, date != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the date")
            return
        }

        guard keywordList.count > 0 else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the keyword")
            return
        }

        guard let description = textView.text, description != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the text")
            return
        }
        
//         if checkButtonFlag == false {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please agree sales terma and conditions.")
//
//        }


        let keyWord = "\(keywordList)"
        var keyWordDataId = keyWord.replacingOccurrences(of: "[", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "]", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: "\"", with: "")
        keyWordDataId = keyWordDataId.replacingOccurrences(of: " ", with: "")
        print("=========keyWord=========\(keyWordDataId)")


        blogStoryForm(headline: headLineTextField.text!, categoryId: categoryID, languageCode: languageTextField.text!, country: countryData, state:stateData, city: cityData, date: dateTextField.text!, stepCount: "1", keyWordID:keyWordDataId, description: textView.text!, header: currentUserLogin.token)
        
//        let PostStoryTypeVC = AppStoryboard.Journalist.viewController(PostStoryTypeViewControllerJM.self)
//        self.navigationController?.pushViewController(PostStoryTypeVC, animated: true)

                
    }
    
    
    @objc func onClickeyword(){
        //        let keyWordVC = AppStoryboard.Journalist.viewController(KeywordSearchVC.self)
        //        keyWordVC.delegate = self
        //        self.present(keyWordVC, animated: true, completion: nil)
        
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
    
    func blogStoryForm(headline: String, categoryId: String, languageCode: String, country: String, state: String, city: String, date: String, stepCount: String, keyWordID : String, description: String, header : String){
        Webservices.sharedInstance.blogFormFill(headLine: headline, categoryId: categoryId, languageCode: languageCode, country: country, state: state, city: city, date: date, stepCount: stepCount, keyWordId: keyWordID, description: description, header: header){
            (result,message,response) in
            
            if result == 200{
                print(response)
                if let somecategory = response{
                    self.getBlogStorydata = somecategory
                    print("======================\(somecategory)")
                }
                let PostStoryTypeVC = AppStoryboard.Journalist.viewController(PostStoryTypeViewControllerJM.self)
                PostStoryTypeVC.blogId = self.getBlogStorydata.blogID
                self.navigationController?.pushViewController(PostStoryTypeVC, animated: true)
                
            } else{
                //                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
}


extension PostStoryViewControllerJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension PostStoryViewControllerJM: UITextFieldDelegate {
    
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
            
        }
    }
}

extension PostStoryViewControllerJM : SendNameOfLanguage{
    func languageName(name: String, id: String, langKey: String) {
        languageTextField.resignFirstResponder()
        if name == "" && id == "" && langKey == ""{
            return
        }
        self.languageTextField.text = name
        self.languageData = name
    }
}

extension PostStoryViewControllerJM: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        countryTextField.resignFirstResponder()
        if name == "" && id == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
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

extension PostStoryViewControllerJM: SendNameOfState {
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

extension PostStoryViewControllerJM: SendNameOfCity {
    
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


extension PostStoryViewControllerJM : SendNameOfCategory{
    func CategoryName(text: String, id: String) {
        categoryTextField.resignFirstResponder()
        if text == "" && id == ""{
            return
        }
        self.categoryTextField.text = text
        self.categoryID = id
    }
    
}

//extension PostStoryViewControllerJM : SendNameOfKeyword{
//    func keywordName(name: String, id: String) {
//        keywordList.append(name)
//        keywordID.append(id)
//        keywordCollectionView.reloadData()
//        keywordCollectionView.layoutSubviews()
//    }
//}

extension PostStoryViewControllerJM: SendKeywordName{
    func keywordName(name: [String]) {
        keywordList.append(contentsOf: name)
        keywordCollectionView.reloadData()
    }
}



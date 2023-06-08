//
//  EditJobVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 17/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditJobVC: UIViewController {

    @IBOutlet weak var textFiledJobCategory: UITextField!
    @IBOutlet weak var textFiledState: UITextField!
    @IBOutlet weak var textFiledEmployement: UITextField!
    @IBOutlet weak var textFieldWorkExp: UITextField!
    @IBOutlet weak var textFiledRole: UITextField!
    @IBOutlet weak var textFiledCity: UITextField!
    @IBOutlet weak var textFiledCountry: UITextField!
    @IBOutlet weak var textFiledExpectedSalary: UITextField!
    @IBOutlet weak var textFieldCurrency: UITextField!
    @IBOutlet weak var textFieldEducation: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var buttonPost: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonKeywords: UIButton!
    @IBOutlet weak var buttonFunctional: UIButton!
    @IBOutlet weak var uiViewKeyword: UIView!
    @IBOutlet weak var uiViewFunctional: UIView!
    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    @IBOutlet weak var functionalCollectionView : UICollectionView!
    @IBOutlet weak var buttonBack: UIButton!
    
    var currenUserLogin : User!
    var countryId = ""
    var countryData = ""
    var stateId = ""
    var stateData = ""
    var cityData = ""
    var keyWordNameArray = [String]()
    var functionalAreaNameArray = [String]()
    var functionalAreaIdArray = [String]()
    var functionalAreaIdConvertedFormat = ""
    var keywordsArrayConvertedFormat = ""
    var jobroleId = ""
    var jobQualificationId = ""
    var jobCategoryId = ""
    
    var getPreviousData = GetJobDetailsModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTextFields()
        setupCollectionView()
        setupPreviousData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //setupPreviousData()
    }
    
    func setupUI() {
         CommonClass.makeViewCircularWithCornerRadius(descriptionView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        buttonCancel.makeRoundCorner(20)
        buttonCancel.makeBorder(1, color: .black)
        buttonPost.makeRoundCorner(20)
        uiViewKeyword.makeBorder(0.5, color: .lightGray)
        uiViewFunctional.makeBorder(0.5, color: .lightGray)
        uiViewKeyword.makeRoundCorner(5)
        uiViewFunctional.makeRoundCorner(5)
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
        keywordsCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        functionalCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
        self.keywordsCollectionView.dataSource = self
        self.keywordsCollectionView.delegate = self
    
        self.functionalCollectionView.dataSource = self
        self.functionalCollectionView.delegate = self
    }
    
    func setupTextFields() {
        textFiledJobCategory.delegate = self
        textFiledRole.delegate = self
        textFieldEducation.delegate = self
        textFiledCity.delegate = self
        textFiledCountry.delegate = self
        textFiledState.delegate = self
        textFieldCurrency.delegate = self
        textFiledEmployement.delegate = self
    }
    
    func setupButton() {
        buttonCancel.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        buttonPost.addTarget(self, action: #selector(postButtonPressed), for: .touchUpInside)
        buttonKeywords.addTarget(self, action: #selector(keywordButtonPressed), for: .touchUpInside)
        buttonFunctional.addTarget(self, action: #selector(functionalAreaButtonPressed), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupPreviousData() {
       
        for data in getPreviousData.jobKeywordName.enumerated() {
            keyWordNameArray.append(data.element)
            let langData = "\(keyWordNameArray)"
            var keywords = langData.replacingOccurrences(of: "[", with: "")
            keywords = keywords.replacingOccurrences(of: "]", with: "")
            keywords = keywords.replacingOccurrences(of: "\"", with: "")
            keywords = keywords.replacingOccurrences(of: " ", with: "")
            self.keywordsArrayConvertedFormat = keywords
        }
        
        for data in getPreviousData.jobFunctionalAreaId.enumerated() {
            functionalAreaNameArray.append(data.element.jobFunctionalAreaName)
            functionalAreaIdArray.append(data.element.id)
            let langData = "\(functionalAreaIdArray)"
            var functionaAreaId = langData.replacingOccurrences(of: "[", with: "")
            functionaAreaId = functionaAreaId.replacingOccurrences(of: "]", with: "")
            functionaAreaId = functionaAreaId.replacingOccurrences(of: "\"", with: "")
            functionaAreaId = functionaAreaId.replacingOccurrences(of: " ", with: "")
            self.functionalAreaIdConvertedFormat = functionaAreaId
        }
        
        descriptionView.text = getPreviousData.jobDescription
        textFieldWorkExp.text = getPreviousData.workExperience
        textFiledExpectedSalary.text = getPreviousData.expectedSalary
        textFiledEmployement.text = getPreviousData.employementType
        textFiledJobCategory.text = getPreviousData.jobCategoryId.jobCategoryName
        self.jobCategoryId = getPreviousData.jobCategoryId.id
        textFiledRole.text = getPreviousData.jobRoleId.jobRoleName
        self.jobroleId = getPreviousData.jobRoleId.id
        textFieldEducation.text = getPreviousData.jobQualificationId.jobQualificationName
        self.jobQualificationId = getPreviousData.jobQualificationId.id
        textFieldCurrency.text = getPreviousData.country.currencyName
        
        //-----CountryData-----
        textFiledCountry.text = getPreviousData.country.name
        var countryObject: [String:String] = [:]
        countryObject.updateValue(getPreviousData.country.name, forKey: "name")
        countryObject.updateValue(getPreviousData.country.placeId, forKey: "id")
        countryObject.updateValue(getPreviousData.country.sortName, forKey: "sortname")
        countryObject.updateValue(getPreviousData.country.phoneCode, forKey: "phonecode")
        countryObject.updateValue(getPreviousData.country.symbol, forKey: "symbol")
        countryObject.updateValue(getPreviousData.country.currencyName, forKey: "currencyName")
         let jsonData = try! JSONSerialization.data(withJSONObject: countryObject, options: .prettyPrinted)
         if let jsonString = String(data: jsonData, encoding: .utf8) {
             print(jsonString)
             countryData = jsonString
        }
        
        //-----StateData-----
        textFiledState.text = getPreviousData.state.stateName
        var stateObject: [String:String] = [:]
        stateObject.updateValue(getPreviousData.state.stateId, forKey: "id")
        stateObject.updateValue(getPreviousData.state.stateName, forKey: "name")
        stateObject.updateValue(getPreviousData.state.countryId, forKey: "country_id")
        stateObject.updateValue(getPreviousData.state.symbol, forKey: "symbol")
        stateObject.updateValue(getPreviousData.state.currencyName, forKey: "currencyName")
        let stateJsonData = try! JSONSerialization.data(withJSONObject: stateObject, options: .prettyPrinted)
        if let jsonString = String(data: stateJsonData, encoding: .utf8) {
            print(jsonString)
            stateData = jsonString
        }
        
        //-----CityData-----
        textFiledCity.text = getPreviousData.city.name
        var cityObject: [String:String] = [:]
        cityObject.updateValue(getPreviousData.city.placeId, forKey: "id")
        cityObject.updateValue(getPreviousData.city.name, forKey: "name")
        cityObject.updateValue(getPreviousData.city.stateId, forKey: "state_id")
        let cityjsonData = try! JSONSerialization.data(withJSONObject: cityObject, options: .prettyPrinted)
        if let jsonString = String(data: cityjsonData, encoding: .utf8) {
            print(jsonString)
            cityData = jsonString
        }
    }
    
    @objc func cancelButtonPressed() {
       // self.dismiss(animated: true, completion: nil)
    }
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func postButtonPressed() {
        if isValidate() {
            updateJob(jobRoleId: jobroleId, jobQualificationId: jobQualificationId, jobCategoryId: jobCategoryId, jobFunctionalAreaId: functionalAreaIdConvertedFormat, jobKeywordName: keywordsArrayConvertedFormat, workExperience: textFieldWorkExp.text!, expectedSalary: textFiledExpectedSalary.text!, employementType: textFiledEmployement.text!, jobDescription: descriptionView.text!, country: countryData, state: stateData, city: cityData, jobId: getPreviousData.jobId, header: currenUserLogin.mediahouseToken)
        }
    }
    
    @objc func keywordButtonPressed() {
        let keywordVC = AppStoryboard.MediaHouse.viewController(CutomJobKeywordsSearchVC.self)
        keywordVC.delegate = self
        self.present(keywordVC, animated: true, completion: nil)
    }
    
    @objc func functionalAreaButtonPressed() {
      let functionalArea = AppStoryboard.MediaHouse.viewController(FunctionalAreaSearchVC.self)
        functionalArea.delegate = self
        self.present(functionalArea, animated: true, completion: nil)
    }
    
    //------postJob----------
    func updateJob(jobRoleId: String,jobQualificationId: String,jobCategoryId: String,jobFunctionalAreaId: String,jobKeywordName: String,workExperience: String,expectedSalary: String,employementType: String,jobDescription: String,country: String,state: String,city: String,jobId: String, header:String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.updateJob(jobRoleId: jobRoleId, jobQualificationId: jobQualificationId, jobCategoryId: jobCategoryId, jobFunctionalAreaId: jobFunctionalAreaId, jobKeywordName: jobKeywordName, workExperience: workExperience, expectedSalary: expectedSalary, employementType: employementType, jobDescription: jobDescription, country: country, state: state, city: city, jobId: jobId, header: header) { (result,message,response) in
            CommonClass.hideLoader()
            if result == 200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        
        if keyWordNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the keywords")
            return false
        }
        else if functionalAreaNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the functional area.")
            return false
        }
        else if textFiledJobCategory.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the job category.")
            return false
        }
        else if textFiledCountry.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the country name.")
            return false
        }
        else if textFiledState.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the state name.")
            return false
        }
        else if textFiledCity.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the city name.")
            return false
        }
        else if textFiledRole.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the job role.")
            return false
        }
        else if textFieldWorkExp.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the work experience.")
            return false
        }
        else if textFiledEmployement.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the employment type.")
            return false
        }
        else if textFieldCurrency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the preferred currency.")
            return false
        }
        else if textFieldCurrency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the currency.")
            return false
        }
        else if textFiledExpectedSalary.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the expected salery.")
            return false
        }
        else if textFieldEducation.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter education.")
            return false
        }
        else if descriptionView.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the description.")
            return false
        }
        return true
    }
    
}

//---------CollectionView-----------
extension EditJobVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == keywordsCollectionView{
            print("====cell count=======\(keyWordNameArray.count)")
            return keyWordNameArray.count
        } else{
            return functionalAreaNameArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == keywordsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            //keywordsCollectionView
            //cell.delegate = self
            cell.aoiLabel.text = keyWordNameArray[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellkeyword(sender:)), for: .touchUpInside)
            return cell
            
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            //cell.delegate = self
            cell.aoiLabel.text = functionalAreaNameArray[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellTargetAudience(sender:)), for: .touchUpInside)
            return cell
        }
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
        keywordsCollectionView.reloadData()
        
    }

    @objc func deleteCellTargetAudience(sender: UIButton){
        print(sender.tag)
        let name = functionalAreaNameArray[sender.tag]
        functionalAreaNameArray.removeAll(where: { $0 == name })
        let id = functionalAreaIdArray[sender.tag]
        functionalAreaIdArray.removeAll(where: { $0 == id })
        
        let langData = "\(functionalAreaIdArray)"
        var functionaAreaId = langData.replacingOccurrences(of: "[", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: "]", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: "\"", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: " ", with: "")
        self.functionalAreaIdConvertedFormat = functionaAreaId
        functionalCollectionView.reloadData()
    }
    
}

//------- TextField delegate ------
extension EditJobVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField == textFiledJobCategory {
            let JobCategorySearchVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCategorySearchVC") as! JobCategorySearchVC
            JobCategorySearchVC.delegate = self
            self.present(JobCategorySearchVC, animated: true, completion: nil)
         } else if textField == textFiledRole {
            let JobRoleSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "JobRoleSearchVC") as! JobRoleSearchVC
            JobRoleSearchVC.delegate = self
            self.present(JobRoleSearchVC, animated: true, completion: nil)
        } else if textField == textFieldEducation {
           let EducationSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "EducationSearchVC") as! EducationSearchVC
            EducationSearchVC.delegate = self
            self.present(EducationSearchVC, animated: true, completion: nil)
        } else if textField == textFiledState {
            if textFiledCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else {
                let stateSearchVC = AppStoryboard.PreLogin.viewController(StateSearchVC.self)
                stateSearchVC.delegate = self
                stateSearchVC.countryId = countryId
                self.present(stateSearchVC, animated: true, completion: nil)
            }
        } else if textField == textFiledCity {
            if textFiledCountry.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose country first.")
            } else if textFiledState.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose state first.")
            } else {
                let citySearchVC = AppStoryboard.PreLogin.viewController(CitySearchVC.self)
                citySearchVC.delegate = self
                citySearchVC.stateId = stateId
                self.present(citySearchVC, animated: true, completion: nil)
            }
        } else if textField == textFiledCountry {
            let countryListSearchVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
            countryListSearchVC.delegate = self
            self.present(countryListSearchVC, animated: true, completion: nil)
        } else if textField == textFieldCurrency {
            //--------
        } else if textField == textFiledEmployement {
            let employmentTypeVC = AppStoryboard.MediaHouse.viewController(EmploymentTypeVC.self)
            employmentTypeVC.delegate = self
            self.present(employmentTypeVC, animated: true, completion: nil)
        }
    }
}

//------getting jobCategory data
extension EditJobVC: SendNameOfJobCategory {
    func jobCategoryName(name: String, id: String) {
        textFiledJobCategory.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFiledJobCategory.text = name
        self.jobCategoryId = id
    }
}

//------getting jobRole data
extension EditJobVC: SendNameOfJobRole {
    func jobRoleName(name: String, id: String) {
        textFiledRole.resignFirstResponder()
        if name == "" && id == "" {
            return
        }
        textFiledRole.text = name
        self.jobroleId = id
        
    }
}

//------getting jobQualification data
extension EditJobVC: SendNameOfJobQualification {
    func JobQualificationName(name: String, id: String) {
        textFieldEducation.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFieldEducation.text = name
        self.jobQualificationId = id
    }
}

//------getting EmployementType data
extension EditJobVC: SendNameOfEmployementType {
    func employementTypeName(name: String) {
        textFiledEmployement.resignFirstResponder()
        if name == ""{
            return
        }
        textFiledEmployement.text = name
    }
}

extension EditJobVC: SendNameOfCountry {
    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
        textFiledCountry.resignFirstResponder()
        if name == "" && id  == "" && sortName == "" && phoneCode == "" && currencyName == "" && symbol == ""{
            return
        }
        self.textFiledCountry.text = name
        self.textFieldCurrency.text = currencyName
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

extension EditJobVC: SendNameOfState {
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

extension EditJobVC: SendNameOfCity {
    func cityName(name: String, id: String, stateId: String) {
        textFiledCity.resignFirstResponder()
        if name == "" && id == "" && stateId == ""{
            return
        }
        self.textFiledCity.text = name
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
extension EditJobVC: SendJobKeywordName {
    func keywordName(name: [String]) {
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordsCollectionView.reloadData()
        self.functionalCollectionView.reloadData()
        
        let langData = "\(keyWordNameArray)"
        var keywords = langData.replacingOccurrences(of: "[", with: "")
        keywords = keywords.replacingOccurrences(of: "]", with: "")
        keywords = keywords.replacingOccurrences(of: "\"", with: "")
        keywords = keywords.replacingOccurrences(of: " ", with: "")
        self.keywordsArrayConvertedFormat = keywords
    }
}

//-----gettingJob FunctionalArea-------
extension EditJobVC: SendFunctionaAreaName {
    func functionalAreaName(name: [String], id: [String]) {
        self.functionalAreaNameArray.append(contentsOf: name)
        self.functionalAreaIdArray.append(contentsOf: id)
        self.keywordsCollectionView.reloadData()
        self.functionalCollectionView.reloadData()
        
        let langData = "\(functionalAreaIdArray)"
        var functionaAreaId = langData.replacingOccurrences(of: "[", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: "]", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: "\"", with: "")
        functionaAreaId = functionaAreaId.replacingOccurrences(of: " ", with: "")
        self.functionalAreaIdConvertedFormat = functionaAreaId
    }
}

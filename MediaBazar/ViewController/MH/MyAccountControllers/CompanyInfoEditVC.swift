//
//  CompanyInfoEditVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 11/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CompanyInfoEditVC: UIViewController {

    @IBOutlet weak var textFieldAreaInterest: UITextField!
    @IBOutlet weak var textFieldFrequency: UITextField!
    @IBOutlet weak var textFieldWebsite: UITextField!
    @IBOutlet weak var textFieldCirculation: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonTargetAudience: UIButton!
    @IBOutlet weak var buttonKeywordsAudience: UIButton!
    @IBOutlet weak var targetAudienceCollectionView : UICollectionView!
    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    @IBOutlet weak var uiViewTargetAudience: UIView!
    @IBOutlet weak var uiViewKeywords: UIView!
    @IBOutlet weak var buttonBack: UIButton!

//    var areaOfInterest = [String]()
//    var targetAudiance = [String]()
//    var areaOfInterestName = [String]()
//    var targetAudienceName = [String]()
    
    var getCompanyData = CompanyProfileModel()
    var keyWordNameArray = [String]()
    var areaOfInterestId = ""
    var frequencyId = ""
    var targetAudience = [String]()
    var getCompanyInfo: ProffesionalDetailModel?
    
    var targetAudianceNameArray = [String]()
    var targetAudianceIdArray = [String]()
    var targetAudianceSortNameArray = [String]()
    var targetAudiancePhoneCodeArray = [String]()
    var targetAudianceCurrencyNameArray = [String]()
    var targetAudianceSymbolArray = [String]()
    var currenUserLogin : User!
    var getMediaHouseId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupCollectionView()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        buttonContinue.makeRoundCorner(20)
        textFieldFrequency.delegate = self
        textFieldAreaInterest.delegate = self
        CommonClass.makeViewCircularWithCornerRadius(uiViewTargetAudience, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(uiViewKeywords, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    func setupData() {
        //----AreaOfInterest
        var getAreaOfInterestName = [String]()
        var getAreaOfInterestId = [String]()
        for data in getCompanyData.areaOfInterest.enumerated() {
            getAreaOfInterestName.append(data.element.categoryName)
            getAreaOfInterestId.append(data.element.id)
        }
        textFieldAreaInterest.text = getAreaOfInterestName[0]
        self.areaOfInterestId = getAreaOfInterestId[0]
        
        //----TargetAudience
        for targetAudienceData in getCompanyData.targetAudience.enumerated() {
            self.targetAudianceNameArray.append(targetAudienceData.element.name)
            self.targetAudianceIdArray.append(targetAudienceData.element.targetId)
            self.targetAudianceSortNameArray.append(targetAudienceData.element.sortname)
            self.targetAudiancePhoneCodeArray.append(targetAudienceData.element.phonecode)
            self.targetAudianceCurrencyNameArray.append(targetAudienceData.element.currencyName)
            self.targetAudianceSymbolArray.append(targetAudienceData.element.symbol)
            self.targetAudienceCollectionView.reloadData()
        }
        
        var count = 0
        for _ in targetAudianceNameArray.enumerated() {             //---For multiple selection
            var dict = Dictionary<String,String>()
            dict.updateValue(targetAudianceIdArray[count], forKey: "id")
            dict.updateValue(targetAudianceNameArray[count], forKey: "name")
            dict.updateValue(targetAudianceSortNameArray[count], forKey: "sortname")
            dict.updateValue(targetAudiancePhoneCodeArray[count], forKey: "phonecode")
            dict.updateValue(targetAudianceSymbolArray[count], forKey: "symbol")
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
            targetAudience.append(text)
        }
        //-----frequncyId-----
        textFieldFrequency.text = getCompanyData.frequencyId.mediahouseFrequencyName
        self.frequencyId = getCompanyData.frequencyId.Id
        
        //-----KeywordsName-------
        for data in getCompanyData.keywordName.enumerated() {
            keyWordNameArray.append(data.element)
            self.keywordsCollectionView.reloadData()
        }
        
        textFieldWebsite.text = getCompanyData.website
        textFieldCirculation.text = getCompanyData.audience
        
    }
    
    fileprivate func setupCollectionView() {
            let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
            keywordsCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
            targetAudienceCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
            
            self.keywordsCollectionView.dataSource = self
            self.keywordsCollectionView.delegate = self
        
            self.targetAudienceCollectionView.dataSource = self
            self.targetAudienceCollectionView.delegate = self
        
        setupCollectionViewLayout()
        }
    
    func setupCollectionViewLayout() {
        if let aoiFlowLayout = keywordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

    }


    func setupButton(){
        buttonContinue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
        buttonTargetAudience.addTarget(self, action: #selector(onClickTargetAudience), for: .touchUpInside)
        buttonKeywordsAudience.addTarget(self, action: #selector(onClickKeywords), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(onClickBackBtn), for: .touchUpInside)
    }
    
    @objc func continueButtonpressed() {
        if isValidate() {
            let langData = "\(keyWordNameArray)"
            var keywords = langData.replacingOccurrences(of: "[", with: "")
            keywords = keywords.replacingOccurrences(of: "]", with: "")
            keywords = keywords.replacingOccurrences(of: "\"", with: "")
            keywords = keywords.replacingOccurrences(of: " ", with: "")
            
            var text = "["
            for index in 0..<targetAudience.count {
                let item = targetAudience[index]
                //                       text += item.textDict(true)
                text += item
                text += (index == targetAudience.count-1) ? "" : ","
            }
            text = text+"]"
            print(text)
            
            CommonClass.showLoader()
            companyInformation(areaOfInterest: areaOfInterestId, targetAudience: text, frequencyId: frequencyId, mediahouseId: self.currenUserLogin.mediahouseId, keywordName: keywords, stepCount: "2", website: textFieldWebsite.text!, audience: textFieldCirculation.text!)
        }
//        let socialInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanySocialInfoVC") as! CompanySocialInfoVC
//        self.navigationController?.pushViewController(socialInfoVC, animated: true)
    }
    
    @objc func onClickTargetAudience(){
        let countryListVC = AppStoryboard.PreLogin.viewController(CustomCountySearchVC.self)
        countryListVC.delegate = self
        self.present(countryListVC, animated: true, completion: nil)
    }
    
    @objc func onClickKeywords(){
        let keywordVC = AppStoryboard.PreLogin.viewController(CustomKeywordSearchVC.self)
        keywordVC.delegate = self
        self.present(keywordVC, animated: true, completion: nil)
    }
    
    @objc func onClickBackBtn(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
         if textFieldAreaInterest.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the area of interest.")
            return false
        }
        else if targetAudianceNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the target audience.")
            return false
        }
        else if textFieldFrequency.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the frequency.")
            return false
        }
        else if keyWordNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the keywords.")
            return false
        }
        else if textFieldWebsite.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the website name.")
            return false
        }
        else if textFieldCirculation.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the circulation.")
            return false
        }
        return true
    }
    
    //--------Api Call ----------
    func companyInformation(areaOfInterest: String, targetAudience: String, frequencyId: String, mediahouseId: String, keywordName: String, stepCount: String, website: String, audience: String){
           
                WebService3.sharedInstance.companyInformation(areaOfInterest: areaOfInterest, targetAudience: targetAudience, frequencyId: frequencyId, mediahouseId: mediahouseId, keywordName: keywordName, stepCount: stepCount, website: website, audience: audience) { (result, response, message)  in
                print(result)
                CommonClass.hideLoader()
                if result == 200{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(message)
                    //NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
}


//---------CollectionView-----------
extension CompanyInfoEditVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == keywordsCollectionView{
            print("====cell count=======\(keyWordNameArray.count)")
            return keyWordNameArray.count
        } else{
            return targetAudianceNameArray.count
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
            cell.aoiLabel.text = targetAudianceNameArray[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellTargetAudience(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func deleteCellkeyword(sender: UIButton){
        print(sender.tag)
        let name = keyWordNameArray[sender.tag]
        keyWordNameArray.removeAll(where: { $0 == name })
        keywordsCollectionView.reloadData()
        
    }

    @objc func deleteCellTargetAudience(sender: UIButton){
        print(sender.tag)
        let name = targetAudianceNameArray[sender.tag]
        targetAudianceNameArray.removeAll(where: { $0 == name })
        
        let id = targetAudianceIdArray[sender.tag]
        targetAudianceIdArray.removeAll(where: { $0 == id })
        
        let sortName = targetAudianceSortNameArray[sender.tag]
        targetAudianceSortNameArray.removeAll(where: { $0 == sortName })
        
        let phoneCode = targetAudiancePhoneCodeArray[sender.tag]
        targetAudiancePhoneCodeArray.removeAll(where: { $0 == phoneCode })
        
        let currencyName = targetAudianceCurrencyNameArray[sender.tag]
        targetAudianceCurrencyNameArray.removeAll(where: { $0 == currencyName })
        
        let symbol = targetAudianceSymbolArray[sender.tag]
        targetAudianceSymbolArray.removeAll(where: { $0 == symbol })
        
        targetAudienceCollectionView.reloadData()
    }
}

//------- TextField delegate ------
extension CompanyInfoEditVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField == textFieldFrequency {
            let frequencySearchVC = AppStoryboard.PreLogin.viewController(FrequencySearchVC.self)
            frequencySearchVC.delegate = self
            self.present(frequencySearchVC, animated: true, completion: nil)
         } else if textField == textFieldAreaInterest {
            let aresOfInterestVC = AppStoryboard.PreLogin.viewController(AreaOfInterestSearchVC.self)
            aresOfInterestVC.delegate = self
            self.present(aresOfInterestVC, animated: true, completion: nil)
        }
    }
}

//-------getKeywordsName-----
extension CompanyInfoEditVC: SendKeywordName {
    func keywordName(name: [String]) {
        print("================\(name)")
        //self.keyWordNameArray = name
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordsCollectionView.reloadData()
        self.targetAudienceCollectionView.reloadData()
    }
}

extension CompanyInfoEditVC: SendNameOfFrequency {
    func frequencyName(name: String, id: String) {
        textFieldFrequency.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFieldFrequency.text = name
        print("================\(name)")
        print("================\(id)")
        self.frequencyId = id
    }
}

extension CompanyInfoEditVC: SendNameOfAreaInterest {
    func AreaOfInterestName(name: String, id: String) {
        textFieldAreaInterest.resignFirstResponder()
        if name == "" && id == ""{
            return
        }
        textFieldAreaInterest.text = name
        self.areaOfInterestId = id
    }
}

extension CompanyInfoEditVC: SendCountryName {
    
    func countryName(name: [String], id: [String], sortName: [String], phoneCode: [String], currencyName: [String], symbol: [String]) {
        self.targetAudianceNameArray.append(contentsOf: name)
        self.targetAudianceIdArray.append(contentsOf: id)
        self.targetAudianceSortNameArray.append(contentsOf: sortName)
        self.targetAudiancePhoneCodeArray.append(contentsOf: phoneCode)
        self.targetAudianceCurrencyNameArray.append(contentsOf: currencyName)
        self.targetAudianceSymbolArray.append(contentsOf: symbol)
        self.targetAudienceCollectionView.reloadData()
        
        
       var count = 0
        for _ in name.enumerated() {             //---For multiple selection
             
            var dict = Dictionary<String,String>()
            dict.updateValue(id[count], forKey: "id")
            dict.updateValue(name[count], forKey: "name")
            dict.updateValue(sortName[count], forKey: "sortname")
            dict.updateValue(phoneCode[count], forKey: "phonecode")
            dict.updateValue(symbol[count], forKey: "symbol")
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
            targetAudience.append(text)
            
        }
    }
        

}




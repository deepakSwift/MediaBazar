//
//  CompanyAddressInfoVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CompanyAddressInfoVC: UIViewController {

//    @IBOutlet weak var textFieldAreaInterest: UITextField!
    @IBOutlet weak var textFieldFrequency: UITextField!
    @IBOutlet weak var textFieldWebsite: UITextField!
    @IBOutlet weak var textFieldCirculation: UITextField!
    @IBOutlet weak var buttonContinue: UIButton!
    @IBOutlet weak var buttonTargetAudience: UIButton!
    @IBOutlet weak var buttonKeywordsAudience: UIButton!
    @IBOutlet weak var buttonAreaOfInterest: UIButton!
    @IBOutlet weak var targetAudienceCollectionView : UICollectionView!
    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    @IBOutlet weak var aoiCollectionView: UICollectionView!
    @IBOutlet weak var uiViewTargetAudience: UIView!
    @IBOutlet weak var uiViewKeywords: UIView!
    @IBOutlet weak var areaOfInterestView : UIView!
    @IBOutlet weak var backButton : UIButton!

//    var areaOfInterest = [String]()
//    var targetAudiance = [String]()
//    var areaOfInterestName = [String]()
//    var targetAudienceName = [String]()
    
    var areaOfInterestName = [String]()
    var areaOfInterest = [String]()
    var keyWordNameArray = [String]()
    var areaOfInterestId = [String]()
    var frequencyId = ""
    var targetAudience = [String]()
    var getCompanyInfo: ProffesionalDetailModel?
    
    var targetAudianceNameArray = [String]()
    var targetAudianceIdArray = [String]()
    var targetAudianceSortNameArray = [String]()
    var targetAudiancePhoneCodeArray = [String]()
    var targetAudianceCurrencyNameArray = [String]()
    var targetAudianceSymbolArray = [String]()
    
    var getMediaHouseId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        buttonContinue.makeRoundCorner(20)
        textFieldFrequency.delegate = self
//        textFieldAreaInterest.delegate = self
        CommonClass.makeViewCircularWithCornerRadius(uiViewTargetAudience, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(areaOfInterestView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(uiViewKeywords, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    fileprivate func setupCollectionView() {
            let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
            aoiCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
            keywordsCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
            targetAudienceCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
            self.aoiCollectionView.dataSource = self
            self.aoiCollectionView.delegate = self
            self.keywordsCollectionView.dataSource = self
            self.keywordsCollectionView.delegate = self
            self.targetAudienceCollectionView.dataSource = self
            self.targetAudienceCollectionView.delegate = self
            setupCollectionViewLayout()
        }
    
    func setupCollectionViewLayout() {
        if let aresInterest = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let aoiFlowLayout = keywordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            aresInterest.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

    }

    func setupButton(){
        buttonContinue.addTarget(self, action: #selector(continueButtonpressed), for: .touchUpInside)
        buttonTargetAudience.addTarget(self, action: #selector(onClickTargetAudience), for: .touchUpInside)
        buttonKeywordsAudience.addTarget(self, action: #selector(onClickKeywords), for: .touchUpInside)
        buttonAreaOfInterest.addTarget(self, action: #selector(onClickAreaOfInterest), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    @objc func continueButtonpressed() {
        if isValidate() {
            
            let aoiData = "\(areaOfInterestId)"
            var aoi = aoiData.replacingOccurrences(of: "[", with: "")
            aoi = aoi.replacingOccurrences(of: "]", with: "")
            aoi = aoi.replacingOccurrences(of: "\"", with: "")
            aoi = aoi.replacingOccurrences(of: " ", with: "")
            
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
            companyInformation(areaOfInterest: aoi, targetAudience: text, frequencyId: frequencyId, mediahouseId: getMediaHouseId, keywordName: keywords, stepCount: "2", website: textFieldWebsite.text!, audience: textFieldCirculation.text!)
        }
        
//        let socialInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanySocialInfoVC") as! CompanySocialInfoVC
//        self.navigationController?.pushViewController(socialInfoVC, animated: true)
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickTargetAudience(){
        let countryListVC = AppStoryboard.PreLogin.viewController(CustomCountySearchVC.self)
        countryListVC.delegate = self
        
        countryListVC.selectedTarget = targetAudianceNameArray
        self.present(countryListVC, animated: true, completion: nil)
    }
    
    @objc func onClickKeywords(){
        let keywordVC = self.storyboard?.instantiateViewController(withIdentifier: "CustomKeywordSearchVC") as! CustomKeywordSearchVC
        keywordVC.delegate = self
        keywordVC.selectedKeywords = keyWordNameArray
        self.present(keywordVC, animated: true, completion: nil)
    }
    
    @objc func onClickAreaOfInterest(){

        let aresOfInterestVC = AppStoryboard.Journalist.viewController(CustomAOIViewController.self)
        aresOfInterestVC.delegate = self
        aresOfInterestVC.getAlreddySelectedArray = areaOfInterestName
        self.present(aresOfInterestVC, animated: true, completion: nil)
    }
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
//         if textFieldAreaInterest.text == "" {
//            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select Area of Interest.")
//            return false
//        }
        if areaOfInterestName.count == 0{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select Area of Interesr")
        }
            
        else if targetAudianceNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select Target Audience.")
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
         else if !(textFieldWebsite.text?.isValidURL())! {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter Website.")
            return false
        }
        else if textFieldCirculation.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter Circulation | Audience | Viewership")
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
                    let socialInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanySocialInfoVC") as! CompanySocialInfoVC
                    socialInfoVC.mediaHouseId = self.getMediaHouseId
                    self.navigationController?.pushViewController(socialInfoVC, animated: true)
                }else{
                    print(message)
                    //NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
}


//---------CollectionView-----------
extension CompanyAddressInfoVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == keywordsCollectionView{
            print("====cell count=======\(keyWordNameArray.count)")
            return keyWordNameArray.count
        } else if collectionView == targetAudienceCollectionView{
            return targetAudianceNameArray.count
        }else {
            return areaOfInterestName.count
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
            
        } else if collectionView == targetAudienceCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            //cell.delegate = self
            //setupCollectionViewLayout()
            cell.aoiLabel.text = targetAudianceNameArray[indexPath.item] + ""
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellTargetAudience(sender:)), for: .touchUpInside)
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
//            cell.delegate = self
            cell.aoiLabel.text = areaOfInterestName[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellAoi(sender:)), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return "String".size(withAttributes: nil)
    }
    
    
    @objc func deleteCellkeyword(sender: UIButton){
        print(sender.tag)
        let name = keyWordNameArray[sender.tag]
        keyWordNameArray.removeAll(where: { $0 == name })
        keywordsCollectionView.reloadData()
        
    }
    
    @objc func deleteCellAoi(sender: UIButton){
        print(sender.tag)
        let id = areaOfInterestId[sender.tag]
        let name = areaOfInterestName[sender.tag]
        areaOfInterest.removeAll(where: { $0 == id })
        areaOfInterestName.removeAll(where: { $0 == name })
        aoiCollectionView.reloadData()
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
        
        print("===========After delete============")
        print("=============\(targetAudianceNameArray)")
        print("=============\(targetAudianceIdArray)")
        print("=============\(targetAudianceSortNameArray)")
        print("=============\(targetAudiancePhoneCodeArray)")
        print("=============\(targetAudianceCurrencyNameArray)")
        print("=============\(targetAudianceSymbolArray)")
        
        targetAudienceCollectionView.reloadData()
        
        
    }
}

//------- TextField delegate ------
extension CompanyAddressInfoVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField == textFieldFrequency {
            let FrequencySearchVC = self.storyboard?.instantiateViewController(withIdentifier: "FrequencySearchVC") as! FrequencySearchVC
            FrequencySearchVC.delegate = self
            self.present(FrequencySearchVC, animated: true, completion: nil)
         }
    }
}

//-------getKeywordsName-----
extension CompanyAddressInfoVC: SendKeywordName {
    func keywordName(name: [String]) {
        print("================\(name)")
        //self.keyWordNameArray = name
        self.keyWordNameArray.append(contentsOf: name)
        self.keywordsCollectionView.reloadData()
    }
}

extension CompanyAddressInfoVC: SendNameOfFrequency {
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

//extension CompanyAddressInfoVC: SendNameOfAreaInterest {
//    func AreaOfInterestName(name: String, id: String) {
//        textFieldAreaInterest.text = name
//        self.areaOfInterestId = id
//    }
//}

extension CompanyAddressInfoVC: SendAOIName{
func keywordName(name: [String], id: [String]) {
    print("name====\(name)")
    print("id====\(id)")
    self.areaOfInterestName.append(contentsOf: name)
    self.areaOfInterestId.append(contentsOf: id)
    self.aoiCollectionView.reloadData()
    
    
        
    }
}

extension CompanyAddressInfoVC: SendCountryName {
    
    func countryName(name: [String], id: [String], sortName: [String], phoneCode: [String], currencyName: [String], symbol: [String]) {
        
        
        self.targetAudianceNameArray.append(contentsOf: name)
        self.targetAudianceIdArray.append(contentsOf: id)
        self.targetAudianceSortNameArray.append(contentsOf: sortName)
        self.targetAudiancePhoneCodeArray.append(contentsOf: phoneCode)
        self.targetAudianceCurrencyNameArray.append(contentsOf: currencyName)
        self.targetAudianceSymbolArray.append(contentsOf: symbol)
        self.targetAudienceCollectionView.reloadData()
        
        print("=======After append=========")
        print("name====================\(name)")
        print("id====================\(id)")
        
        
        var count = 0
        for data in name.enumerated() {             //---For multiple selection
             
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
        
//        var dict = Dictionary<String,String>()
//        dict.updateValue(id[0], forKey: "id")
//        dict.updateValue(name[0], forKey: "name")
//        dict.updateValue(sortName[0], forKey: "sortname")
//        dict.updateValue(phoneCode[0], forKey: "phonecode")
//        dict.updateValue(symbol[0], forKey: "symbol")
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
//        //        return text
//        print("======================\(text)")
//        targetAudience.append(text)
    }
        

}


extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

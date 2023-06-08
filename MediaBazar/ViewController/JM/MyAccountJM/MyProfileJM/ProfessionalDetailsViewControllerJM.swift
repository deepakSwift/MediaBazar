//
//  ProfessionalDetailsViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices

class ProfessionalDetailsViewControllerJM: UIViewController {
    
    @IBOutlet weak var professionalDetailTableView : UITableView!
    
    @IBOutlet weak var pdfLabel : UILabel!
    @IBOutlet weak var pdfImage : UIImageView!
    @IBOutlet weak var buttonTargetAudience: UIButton!
    @IBOutlet weak var buttonAreaOfInterest: UIButton!
    @IBOutlet weak var buttonLanguage : UIButton!
    @IBOutlet weak var uploadTapped: UIButton!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var aoiCollectionView: UICollectionView!
    @IBOutlet weak var targetAudienceCollectionView : UICollectionView!
    
    @IBOutlet weak var areaOfInterestView : UIView!
    @IBOutlet weak var targetView : UIView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var detailedResume : UITextView!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var professionalDetailData = profileModal()
    
    var categoryData = [categoryTypeModal]()
    var targetData = [categoryTypeModal]()
    
    var selectedPDF: URL?
    var languageId = [String]()
    var languageName = [String]()
    var areaOfInterestName = [String]()
    var areaOfInterestId = [String]()
    var areadOfInterestArray = ""
    
    var targetAudianceName = [String]()
    var tartgetAudianceId = [String]()
    
    
    var targetAudiance = [String]()
    
    var targetAudianceNameArray = [String]()
    var targetAudianceIdArray = [String]()
    var targetAudianceSortNameArray = [String]()
    var targetAudiancePhoneCodeArray = [String]()
    var targetAudianceCurrencyNameArray = [String]()
    var targetAudianceSymbolArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupButton()
        setupUI()
        fillData()
        setupCollectionView()
        
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(areaOfInterestView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(targetView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(detailedResume, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        
    }
    
    func fillData(){
        
        for data in professionalDetailData.areaOfInterest.enumerated(){
            let aoi = data.element.categoryName
            areaOfInterestName.append(aoi)
            let aoiID = data.element.id
            areaOfInterestId.append(aoiID)
            let langData = "\(areaOfInterestId)"
            var aois = langData.replacingOccurrences(of: "[", with: "")
            aois = aois.replacingOccurrences(of: "]", with: "")
            aois = aois.replacingOccurrences(of: "\"", with: "")
            aois = aois.replacingOccurrences(of: " ", with: "")
            self.areadOfInterestArray = aois
            print("=========aoi=========\(aoi)")
            
            
        }
        
        
        for targetAudienceData in professionalDetailData.targetAudience.enumerated() {
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
            targetAudiance.append(text)
        
            self.detailedResume.text = self.professionalDetailData.resumeDetails
            
            let resumeUrl = "\(self.baseUrl)\(self.professionalDetailData.uploadResume)"
            let urls = URL(string: (resumeUrl))
            self.selectedPDF = urls
            if let tempUrl = urls {
                pdfImage.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "Documents"))
            }
            
//            let getUrl = "\(self.baseUrl)\(self.profileData.shortVideo)"
//            let url = URL(string: getUrl)
//            if let thumbnailImage = getThumbnailImage(forUrl: url!) {
//               profileVideo.image = thumbnailImage
//            }


    }
}
    func setupButton(){ 
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonAreaOfInterest.addTarget(self, action: #selector(onClickAreaOfInterestButton), for: .touchUpInside)
//        buttonLanguage.addTarget(self, action: #selector(onClickLanguageButton), for: .touchUpInside)
        buttonTargetAudience.addTarget(self, action: #selector(onClickTargetAudienceButton), for: .touchUpInside)
        uploadTapped.addTarget(self, action: #selector(onClickUpdoadDocument), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(onClickOnSaveButton), for: .touchUpInside)
    }
    
    func celldynamicSize() {
        if let aoiFlowLayout = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
        aoiCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        targetAudienceCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
        self.aoiCollectionView.dataSource = self
        self.aoiCollectionView.delegate = self
        
        self.targetAudienceCollectionView.dataSource = self
        self.targetAudienceCollectionView.delegate = self
        
        if let aoiFlowLayout = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }

        
    }
    
    func handleGetImage() {
        let alert = UIAlertController(title: "Add Resume", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.openFile()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickAreaOfInterestButton(){
//        let aresOfInterestVC = AppStoryboard.PreLogin.viewController(AreaOfInterestSearchVC.self)
//        aresOfInterestVC.delegate = self
//        self.present(aresOfInterestVC, animated: true, completion: nil)
        
           let aresOfInterestVC = AppStoryboard.Journalist.viewController(CustomAOIViewController.self)
            aresOfInterestVC.delegate = self
            self.present(aresOfInterestVC, animated: true, completion: nil)
    }
    
    @objc func onClickLanguageButton(){
        let languageVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
        languageVC.delegate = self
        self.present(languageVC, animated: true, completion: nil)
        
    }
    
    @objc func onClickTargetAudienceButton(){
        //        let countryListVC = AppStoryboard.PreLogin.viewController(CountrySearchVC.self)
        //        countryListVC.delegate = self
        //        self.present(countryListVC, animated: true, completion: nil)
        let targetAudienceVC = AppStoryboard.PreLogin.viewController(CustomCountySearchVC.self)
        targetAudienceVC.delegate = self
        self.present(targetAudienceVC, animated: true, completion: nil)
    }
    
    @objc func onClickUpdoadDocument(){
        handleGetImage()
    }
    
    @objc func onClickOnSaveButton(){
        
        let langData = "\(areaOfInterestId)"
        var aoi = langData.replacingOccurrences(of: "[", with: "")
        aoi = aoi.replacingOccurrences(of: "]", with: "")
        aoi = aoi.replacingOccurrences(of: "\"", with: "")
        aoi = aoi.replacingOccurrences(of: " ", with: "")
        print("=========aoi=========\(aoi)")
                
        var text = "["
        for index in 0..<targetAudiance.count {
            let item = targetAudiance[index]
            //                       text += item.textDict(true)
            text += item
            text += (index == targetAudiance.count-1) ? "" : ","
        }
        text = text+"]"
        print(text)
        
        //convert pdf url into data
        var pdfdata = Data()
        
        guard let data = selectedPDF else {
            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the Resume.")
        }
        do {
            pdfdata = try Data(contentsOf: data)
        } catch {}
        
        getprofesionalDetail(areaOfInterest: aoi, targetAudience: text, resumeDetails: "detailedResume.text!", journalistId: professionalDetailData.id, uploadResume: pdfdata, stepCount: "2")
    }
    
    func getprofesionalDetail(areaOfInterest: String, targetAudience: String, resumeDetails: String, journalistId: String, uploadResume: Data, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.ProfessionalDetailsData(areaOfInterest: areaOfInterest, targetAudience: targetAudience, resumeDetails: resumeDetails, journalistId: journalistId, uploadResume: uploadResume, stepCount: stepCount){(result, response, message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                self.navigationController?.popViewController(animated: true)
               NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
              NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}



extension ProfessionalDetailsViewControllerJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aoiCollectionView{
            print("====cell count=======\(professionalDetailData.areaOfInterest.count)")
            return areaOfInterestName.count
        } else {
            return targetAudianceNameArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == aoiCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            cell.delegate = self
            cell.aoiLabel.text = areaOfInterestName[indexPath.row]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellAoi(sender:)), for: .touchUpInside)
            return cell
            
        }  else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            cell.delegate = self
            cell.aoiLabel.text = targetAudianceNameArray[indexPath.row]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellTargetAudience(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func deleteCellAoi(sender: UIButton){
        print(sender.tag)
        let id = areaOfInterestId[sender.tag]
        let name = areaOfInterestName[sender.tag]
        areaOfInterestId.removeAll(where: { $0 == id })
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
            
            targetAudienceCollectionView.reloadData()
        }
    
}

extension ProfessionalDetailsViewControllerJM: AccessCollectionViewCell {
    func deleteSingleCell<T>(_ cell: T) where T : UICollectionViewCell {
        if let indexPath = self.aoiCollectionView.indexPath(for: cell), let targetindexPath = self.targetAudienceCollectionView.indexPath(for: cell) {
            print("Selected Cell ----- \(indexPath.item)")
            
            areaOfInterestId.remove(at: indexPath.item)
            aoiCollectionView.reloadData()
            
            targetAudianceName.remove(at: targetindexPath.item)
            targetAudienceCollectionView.reloadData()
            
        }
    }
}


extension ProfessionalDetailsViewControllerJM: SendNameOfAreaInterest{
    func AreaOfInterestName(name: String, id: String) {
        fillData()
        areaOfInterestId.append(id)
        areaOfInterestName.append(name)
        aoiCollectionView.reloadData()
        aoiCollectionView.layoutSubviews()
    }
    
}

extension ProfessionalDetailsViewControllerJM: SendAOIName{
    func keywordName(name: [String], id: [String]) {
        print("name====\(name)")
        print("id====\(id)")
        self.areaOfInterestName.append(contentsOf: name)
        self.areaOfInterestId.append(contentsOf: id)
            self.aoiCollectionView.reloadData()
            
            let langData = "\(areaOfInterestId)"
            var keywords = langData.replacingOccurrences(of: "[", with: "")
            keywords = keywords.replacingOccurrences(of: "]", with: "")
            keywords = keywords.replacingOccurrences(of: "\"", with: "")
            keywords = keywords.replacingOccurrences(of: " ", with: "")
            self.areadOfInterestArray = keywords
            
        }
    }
    
    

extension ProfessionalDetailsViewControllerJM: SendCountryName{
    func countryName(name: [String], id: [String], sortName: [String], phoneCode: [String], currencyName: [String], symbol: [String]) {
        self.targetAudianceNameArray.append(contentsOf: name)
        self.targetAudianceIdArray.append(contentsOf: id)
        self.targetAudianceSortNameArray.append(contentsOf: sortName)
        self.targetAudiancePhoneCodeArray.append(contentsOf: phoneCode)
        self.targetAudianceCurrencyNameArray.append(contentsOf: currencyName)
        self.targetAudianceSymbolArray.append(contentsOf: symbol)
        self.targetAudienceCollectionView.reloadData()
        
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
            targetAudiance.append(text)
            
        }
        
    }
    
    
}


extension ProfessionalDetailsViewControllerJM: SendNameOfLanguage{
    func languageName(name: String, id: String, langKey: String) {
        fillData()
        languageId.append(id)
        languageName.append(name)
        
    }
    
    
}


extension ProfessionalDetailsViewControllerJM: UIDocumentPickerDelegate {
    
    func openFile() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String,], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            print("URL Failed")
            return
        }
        self.selectedPDF = selectedFileURL
        let pdfViewController = PDFController(pdfUrl: selectedFileURL)
        pdfImage.isHidden = false
        pdfLabel.isHidden = false
        pdfImage.image = #imageLiteral(resourceName: "Documents")
        pdfLabel.text = "application.pdf"
        //pdfViewController.delegate = self
        present(pdfViewController, animated: true, completion: nil)
        
    }
}




//===============single SElection==================
//extension ProfessionalDetailsViewControllerJM: SendNameOfCountry{
//    func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
//
//        print("========\(name)")
//        print("========\(id)")
//        print("========\(sortName)")
//        print("========\(phoneCode)")
//        print("========\(currencyName)")
//        print("========\(symbol)")
//        targetAudianceName.append(name)
//        targetAudienceCollectionView.reloadData()
//
//        var dict = Dictionary<String,String>()
//        dict.updateValue(name, forKey: "id")
//        dict.updateValue(sortName, forKey: "sortname")
//        dict.updateValue(id, forKey: "name")
//        dict.updateValue(phoneCode, forKey: "phonecode")
//        dict.updateValue(symbol, forKey: "symbol")
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
//
//        targetAudiance.append(text)
//    }
//
//}

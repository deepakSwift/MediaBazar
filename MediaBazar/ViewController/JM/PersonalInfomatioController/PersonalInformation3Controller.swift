//
//  PersonalInformation3Controller.swift
//  MediaBazar
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices

class PersonalInformation3Controller: UIViewController {
    
    @IBOutlet weak var labelPdfName: UILabel!
    @IBOutlet weak var imageViewPdfThumnails: UIImageView!
    @IBOutlet weak var buttonTargetAudience: UIButton!
    @IBOutlet weak var buttonAreaOfInterest: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var aoiCollectionView: UICollectionView!
    @IBOutlet weak var targetAudienceCollectionView : UICollectionView!
    
    @IBOutlet weak var areaOfInterestView : UIView!
    @IBOutlet weak var targetView : UIView!
    @IBOutlet weak var detailedResume : UITextView!
    @IBOutlet weak var uploadTapped: UIButton!
    @IBOutlet weak var continueButton : UIButton!
    
    var profesionalDetailArray = [ProffesionalDetailModel]()
    var currenUserLogin : User!
    var selectedPDF: URL?
    var areaOfInterest = [String]()
    var targetAudiance = [String]()
    var cityObject = [String]()
    var journalistId = ""
    
    var areaOfInterestName = [String]()
    var targetAudienceName = [String]()
    var areaOfInterestId = [String]()
    var areadOfInterestArray = ""
    
    
    var targetAudianceNameArray = [String]()
    var targetAudianceIdArray = [String]()
    var targetAudianceSortNameArray = [String]()
    var targetAudiancePhoneCodeArray = [String]()
    var targetAudianceCurrencyNameArray = [String]()
    var targetAudianceSymbolArray = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupCollectionView()
        self.currenUserLogin = User.loadSavedUser()
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        buttonAreaOfInterest.addTarget(self, action: #selector(onClickAreaOfInterest), for: .touchUpInside)
        buttonTargetAudience.addTarget(self, action: #selector(onClickTargetAudience), for: .touchUpInside)
        uploadTapped.addTarget(self, action: #selector(onclickDocUpload), for: .touchUpInside)
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(areaOfInterestView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        //CommonClass.makeViewCircularWithCornerRadius(languageView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(targetView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(detailedResume, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        imageViewPdfThumnails.isHidden = true
        labelPdfName.isHidden = true
    }
    
    
    func celldynamicSize() {
        //        if let aoiFlowLayout = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        //            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //        }
        if let flowLayout = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "EditableBoxCollectionViewCell", bundle: nil)
        aoiCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        // languageCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        targetAudienceCollectionView.register(nib, forCellWithReuseIdentifier: "EditableBoxCollectionViewCell")
        
        self.aoiCollectionView.dataSource = self
        self.aoiCollectionView.delegate = self
        
        self.targetAudienceCollectionView.dataSource = self
        self.targetAudienceCollectionView.delegate = self
        
        //        self.celldynamicSize()
        
        if let aoiFlowLayout = aoiCollectionView.collectionViewLayout as? UICollectionViewFlowLayout, let targetFlowLayout = targetAudienceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            aoiFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            targetFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onclickDocUpload() {
        handleGetImage()
    }
    
    @objc func onClickContinueButton(){
        if isValidate() {
            let langData = "\(areaOfInterestId)"
            var aoi = langData.replacingOccurrences(of: "[", with: "")
            aoi = aoi.replacingOccurrences(of: "]", with: "")
            aoi = aoi.replacingOccurrences(of: "\"", with: "")
            aoi = aoi.replacingOccurrences(of: " ", with: "")
            //print("=========aoi=========\(aoi)")
            
            
            var text = "["
            for index in 0..<targetAudiance.count {
                let item = targetAudiance[index]
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
            
            getprofesionalDetail(areaOfInterest: aoi, targetAudience: text, resumeDetails: "detailedResume.text!", journalistId: journalistId, uploadResume: pdfdata, stepCount: "2")
        }
        //        let referenceVC = AppStoryboard.PreLogin.viewController(ReferenceViewController.self)
        //        self.navigationController?.pushViewController(referenceVC, animated: true)
    }
    
    @objc func onClickAreaOfInterest(){
        
        let aresOfInterestVC = AppStoryboard.Journalist.viewController(CustomAOIViewController.self)
        aresOfInterestVC.delegate = self
        aresOfInterestVC.getAlreddySelectedArray = areaOfInterestName
        self.present(aresOfInterestVC, animated: true, completion: nil)
    }
    
    @objc func onClickTargetAudience(){
        
        let targetAudienceVC = AppStoryboard.PreLogin.viewController(CustomCountySearchVC.self)
        targetAudienceVC.delegate = self
        targetAudienceVC.selectedTarget = targetAudianceNameArray
        self.present(targetAudienceVC, animated: true, completion: nil)
    }
    
    //--------Api Call ----------
    func getprofesionalDetail(areaOfInterest: String, targetAudience: String, resumeDetails: String, journalistId: String, uploadResume: Data, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.ProfessionalDetailsData(areaOfInterest: areaOfInterest, targetAudience: targetAudience, resumeDetails: resumeDetails, journalistId: journalistId, uploadResume: uploadResume, stepCount: stepCount){(result, response, message) in
            CommonClass.hideLoader()
            print(result)
            
            if result == 200{
                
                if self.currenUserLogin.prevJouralistData.invitedStatus == 0{
                    let referenceVC = AppStoryboard.PreLogin.viewController(NewReferenceViewController.self)
                    referenceVC.journalistId = journalistId
                    self.navigationController?.pushViewController(referenceVC, animated: true)
                }else{
                    let perviousWorkVC = AppStoryboard.PreLogin.viewController(PerviousWorkViewController.self)
                    perviousWorkVC.journalistId = journalistId
                    self.navigationController?.pushViewController(perviousWorkVC, animated: true)
                }
                
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
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
    
    //------TextFields Validations-------
    func isValidate()-> Bool {
        if areaOfInterestName.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the area of interest.")
            return false
        }
        else if targetAudianceNameArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the country for target Audience.")
            return false
        }
        else if detailedResume.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the details about resume.")
            return false
        }
        return true
    }
    
}


//---------CollectionView-----------
extension PersonalInformation3Controller: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aoiCollectionView{
            print("====cell count=======\(areaOfInterestName.count)")
            
            return areaOfInterestName.count
        } else{
            return targetAudianceNameArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == aoiCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            cell.delegate = self
            cell.aoiLabel.text = areaOfInterestName[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellAoi(sender:)), for: .touchUpInside)
            return cell
            
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditableBoxCollectionViewCell", for: indexPath) as? EditableBoxCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            cell.delegate = self
            cell.aoiLabel.text = targetAudianceNameArray[indexPath.item]
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(deleteCellTargetAudience(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return "String".size(withAttributes: nil)
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
        //        print(sender.tag)
        //        let id = targetAudiance[sender.tag]
        //        let name = targetAudienceName[sender.tag]
        //        targetAudiance.removeAll(where: { $0 == id })
        //        targetAudienceName.removeAll(where: { $0 == name })
        //        targetAudienceCollectionView.reloadData()
        
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

extension PersonalInformation3Controller: AccessCollectionViewCell {
    func deleteSingleCell<T>(_ cell: T) where T : UICollectionViewCell {
        if let indexPath = self.aoiCollectionView.indexPath(for: cell), let targetindexPath = self.targetAudienceCollectionView.indexPath(for: cell) {
            print("Selected Cell ----- \(indexPath.item)")
            
            areaOfInterest.remove(at: indexPath.item)
            aoiCollectionView.reloadData()
            
            targetAudiance.remove(at: targetindexPath.item)
            targetAudienceCollectionView.reloadData()
            
            
        }
    }
}


extension PersonalInformation3Controller: SendCountryName{
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

extension PersonalInformation3Controller: SendAOIName{
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










/*extension PersonalInformation3Controller: SendNameOfAreaInterest {
 func AreaOfInterestName(name: String, id: String) {
 areaOfInterest.append(id)
 areaOfInterestName.append(name)
 aoiCollectionView.reloadData()
 aoiCollectionView.layoutSubviews()
 }
 }*/

/*extension PersonalInformation3Controller: SendNameOfCountry {
 func countryName(name: String, id: String, sortName: String, phoneCode: String, currencyName: String, symbol: String) {
 
 print("========\(name)")
 print("========\(id)")
 print("========\(sortName)")
 print("========\(phoneCode)")
 print("========\(currencyName)")
 print("========\(symbol)")
 targetAudienceName.append(name)
 targetAudienceCollectionView.reloadData()
 
 //        let arrayOfObj = ["id" : id, "sortname" : sortName, "name" : name, "phonecode" : phoneCode, "symbol" : symbol, "currencyName": currencyName]
 //        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfObj, options: .prettyPrinted)
 //        if let jsonString = String(data: jsonData, encoding: .utf8) {
 //            print("==========\(jsonString)")
 ////            var data = jsonString
 ////            data.removeFirst()
 ////            data.removeLast()
 //            targetAudiance.append(jsonString)
 //         }
 
 var dict = Dictionary<String,String>()
 dict.updateValue(name, forKey: "id")
 dict.updateValue(sortName, forKey: "sortname")
 dict.updateValue(id, forKey: "name")
 dict.updateValue(phoneCode, forKey: "phonecode")
 dict.updateValue(symbol, forKey: "symbol")
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
 
 
 //    func textDict(_ isSelected:Bool) -> String {
 //           var dict = Dictionary<String,String>()
 //           dict.updateValue(self.guidLinesID, forKey:"guidelines_id")
 //           dict.updateValue(self.sessionId, forKey:"session_id")
 //           dict.updateValue(self.guidlines, forKey:"guidelines")
 //           dict.updateValue(isSelected ? "1":"0", forKey:"status")
 //           let doubleQ = "\""
 //           var text = "{"
 //           let dictCount = dict.keys.count
 //           for (index, element) in dict.enumerated(){
 //               let key = doubleQ+element.key+doubleQ
 //               let value = doubleQ+element.value+doubleQ
 //               text = text+key+":"+value
 //               text = text+((index == dictCount-1) ? "":",")
 //           }
 //           text = text+"}"
 //           return text
 //       }
 }
 }*/


// Document Picker pdf
extension PersonalInformation3Controller: UIDocumentPickerDelegate {
    
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
        imageViewPdfThumnails.isHidden = false
        labelPdfName.isHidden = false
        imageViewPdfThumnails.image = #imageLiteral(resourceName: "Documents")
        //        labelPdfName.text = "application.pdf"
        //pdfViewController.delegate = self
        let fileName = selectedPDF?.absoluteString.fileName()
        let extensionName = selectedPDF?.absoluteString.fileExtension()
        self.labelPdfName.text = (fileName ?? " ") + "." + (extensionName ?? " ")
        present(pdfViewController, animated: true, completion: nil)
        
    }
}










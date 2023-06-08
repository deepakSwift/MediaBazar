//
//  TranslateTranscribeControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices

class TranslateTranscribeControllerJM: UIViewController {

    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var selectServiceTypeTextField : UITextField!
    @IBOutlet weak var fromTextField : UITextField!
    @IBOutlet weak var toTextField : UITextField!
    @IBOutlet weak var fileTypeTextField : UITextField!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var uploadFileButton : UIButton!
    @IBOutlet weak var notificationButton : UIButton!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var labelfileName : UILabel!
    
    let selectServicePickerView = UIPickerView()
    var selectServiceArray = ["Translate","Trancribe"]
    let fileTypePickerView = UIPickerView()
    var fileTypeArray = ["Audio","Video","Document"]
    var langData = ""
    var isLanguage = false
    var currentUserLogin : User!
    var selectedPDF: URL?
    var mediaURLs: URL?
    var videoData = Data()
    var pdfdata = Data()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupPickerView()
        // Do any additional setup after loading the view.
    }
    
    func setupPickerView(){
        selectServiceTypeTextField.inputView = selectServicePickerView
        selectServiceTypeTextField.delegate = self
        selectServicePickerView.dataSource = self
        selectServicePickerView.delegate = self
        
        fileTypeTextField.inputView = fileTypePickerView
        fileTypeTextField.delegate = self
        fileTypePickerView.dataSource = self
        fileTypePickerView.delegate = self
        
        fromTextField.delegate = self
        toTextField.delegate = self

    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func setupButton(){
          submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
          uploadFileButton.addTarget(self, action: #selector(uploadFileButtonPressed), for: .touchUpInside)
      }
      
    @objc func uploadFileButtonPressed(){
        if fileTypeTextField.text == "Audio" {
        } else if fileTypeTextField.text == "Video" {
           handleGallery()
        } else if fileTypeTextField.text == "Document" {
            handleGetDocument()
        }
    }
    
    func handleGallery() {
        
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.openFile()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleGetDocument() {
           let alert = UIAlertController(title: "Add Document", message: nil, preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
               self.openFile()
           }))
           
           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
           
           self.present(alert, animated: true, completion: nil)
       }
    
      @objc func submitButtonPressed(){
        
        if isValidate() {
//            translateTranscribe(audio: "", video: videoData, Document: pdfdata, emailId: emailTextField.text!, serviceType: selectServiceTypeTextField.text!, fromLanguage: fromTextField.text!, toLanguage: toTextField.text!, fileType: fileTypeTextField.text!, header: currentUserLogin.token)
        }
        
      }
    
    
//    func translateTranscribe(audio: String?, video: Data?, Document: Data?, emailId: String, serviceType: String, fromLanguage:String, toLanguage: String,fileType: String,header: String) {
//        CommonClass.showLoader()
//        Webservices.sharedInstance.translateJM(audio: audio, video: video, Document: Document, emailId: emailId, serviceType: serviceType, fromLanguage: fromLanguage, toLanguage: toLanguage, fileType: fileType, header: header){ (result, response, message) in
//            CommonClass.hideLoader()
//
//            if result == 200{
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
//            }else{
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
//            }
//        }
//    }
    
    //------TextFields Validations-------
        func isValidate()-> Bool {
             if selectServiceTypeTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the service type.")
                return false
            }
            else if fromTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the from language.")
                return false
            }
            else if toTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the to language.")
                return false
            }
            else if emailTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the email address.")
                return false
            }
            else if !(emailTextField.text?.isValidEmail)!{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid email address.")
                return false
            }
            else if fileTypeTextField.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the file type.")
                return false
            }
             else if notificationButton.imageView?.image == nil  {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the file.")
                return false
            }

            return true
        }

}

//------PickerView and Texttfield delegate
extension TranslateTranscribeControllerJM: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == selectServicePickerView{
            return selectServiceArray.count
        } else {
            return fileTypeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == selectServicePickerView{
            return selectServiceArray[row]
        } else {
            return fileTypeArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == selectServicePickerView{
            selectServiceTypeTextField.text = selectServiceArray[row]
            
        } else {
            fileTypeTextField.text = fileTypeArray[row]
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fromTextField {
            let preLangugeVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
            preLangugeVC.delegate = self
            isLanguage = true
            self.present(preLangugeVC, animated: true, completion: nil)
        } else if textField == toTextField {
            let preLangugeVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
            preLangugeVC.delegate = self
            isLanguage = false
            self.present(preLangugeVC, animated: true, completion: nil)
        }
    }
}

//--------GetLanguageName--------
extension TranslateTranscribeControllerJM: SendNameOfLanguage {
    func languageName(name: String, id: String, langKey: String) {
        if isLanguage {
           fromTextField.text = name
        } else {
            toTextField.text = name
        }
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

//----Document Picker pdf-------
extension TranslateTranscribeControllerJM: UIDocumentPickerDelegate {
    
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
//        imageViewPdfThumnails.isHidden = false
//        labelPdfName.isHidden = false
        notificationButton.setImage(#imageLiteral(resourceName: "images"), for: .normal)
        labelfileName.text = "application.pdf"
        //pdfViewController.delegate = self

        //-------convert pdf url into data---------
        guard let datas = selectedPDF else {
            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the document.")
        }
        do {
            pdfdata = try Data(contentsOf: datas)
        } catch {}

        present(pdfViewController, animated: true, completion: nil)
        
//        let types: [String] = [kUTTypeText as String]
//        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
//        documentPicker.delegate = self
//        documentPicker.modalPresentationStyle = .formSheet
//        self.present(documentPicker, animated: true, completion: nil)
    }
}


//------- Image Picker Extension ------
extension TranslateTranscribeControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
       if let chosenImage = info[.editedImage] as? UIImage{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
        }else if let chosenImage = info[.originalImage] as? UIImage{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
        }else if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.movie" {
            let mediaURL = info[.mediaURL] as! URL
            self.mediaURLs = mediaURL
            uploadFileButton.setImage(#imageLiteral(resourceName: "VideoThumbnails"), for: .normal)
            labelfileName.text = "application.mp4"
        
        //---------convert video url into data--------
        
        guard let data = mediaURLs else {
            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
        }
        do {
            videoData = try Data(contentsOf: data)
        } catch {}
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}






    
//    @IBOutlet weak var topView : UIView!
//    @IBOutlet weak var translateTableView : UITableView!
//    @IBOutlet weak var submitButton : UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupButton()
//    }
//
//
//    func setupUI(){
//        topView.applyShadow()
//        self.translateTableView.dataSource = self
//        self.translateTableView.delegate = self
//        translateTableView.rowHeight = UITableView.automaticDimension
//        translateTableView.estimatedRowHeight = 1000
//        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
//    }
//
//    func setupButton(){
//        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
//    }
//
//    @objc func submitButtonPressed(){
//        let paymentVC = AppStoryboard.PreLogin.viewController(PaymantMethodViewController.self)
//        paymentVC.fromTranslate = "Translate"
//        self.navigationController?.pushViewController(paymentVC, animated: true)
//    }
//
//}
//
//extension TranslateTranscribeControllerJM : UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TranslateTranscribeTableViewCellJM") as! TranslateTranscribeTableViewCellJM
//        cell.delegate = self
//        return cell
//    }
//}
//
//extension TranslateTranscribeControllerJM : DataFromCellToMainController{
//    func backButtonPressed() {}
//
//    func updateTable() {
//        self.translateTableView.reloadData()
//    }
//
//
//}

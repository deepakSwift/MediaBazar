//
//  NewTraslateAndTranscribeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewTraslateAndTranscribeViewControllerJM: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var selectServiceTextField : UITextField!
    @IBOutlet weak var ToLanguageTextFileld : UITextField!
    @IBOutlet weak var fileTypeTextField : UITextField!
    @IBOutlet weak var toLabel : UILabel!
    @IBOutlet weak var toSelectButton : UIButton!
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var uploadFileButton : UIButton!
    @IBOutlet weak var notificationButton : UIButton!
    @IBOutlet weak var submitButton : UIButton!
    
    @IBOutlet weak var textUploadImage : UIImageView!
    @IBOutlet weak var uploadFileLabel : UILabel!
    
    let selectServicePickerView = UIPickerView()
    var selectServiceArray = ["Translate","Trancribe"]
    
    let fileTypePickerView = UIPickerView()
    var fileTypeArray = ["Audio","Video","Text"]
    
    var langData = ""
    var selectedTxt: URL?
    var textData = Data()
    
    var mediaURLs: URL?
    var videoData = Data()
    var imagePicker = UIImagePickerController()
    
    var finalFileSize = ""
    
    var getPriceData = profileModal()
    var currentUserLogin : User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupPickerView()
        ToLanguageTextFileld.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        selectServiceTextField.text = "Trancribe"
        setUpTextField()
        
    }
    
    func setupButton(){
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        uploadFileButton.addTarget(self, action: #selector(uploadFileButtonPressed), for: .touchUpInside)
    }
    
    
    func setUpTextField(){
        if selectServiceTextField.text == "Trancribe"{
            toLabel.isHidden = true
            ToLanguageTextFileld.isHidden = true
            toSelectButton.isHidden = true
        } else if selectServiceTextField.text == "Translate"{
            toLabel.isHidden = false
            ToLanguageTextFileld.isHidden = false
            toSelectButton.isHidden = false
        }
    }
    
    func setUpselectFileData(){
        if self.selectServiceTextField.text == "Translate"{
            if fileTypeTextField.text == "Text"{
                
            }else if fileTypeTextField.text == "Audio"{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You cannot translate audio File")
                imagePicker.dismiss(animated: true, completion: nil)
            } else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You cannot translate video File")
                imagePicker.dismiss(animated: true, completion: nil)
            }
        } else {
            if fileTypeTextField.text == "Audio"{
                
            }else if fileTypeTextField.text == "Video"{
                
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You cannot translate text File")
                imagePicker.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    
    func setupPickerView(){
        selectServiceTextField.inputView = selectServicePickerView
        selectServiceTextField.delegate = self
        selectServicePickerView.dataSource = self
        selectServicePickerView.delegate = self
        
        fileTypeTextField.inputView = fileTypePickerView
        fileTypeTextField.delegate = self
        fileTypePickerView.dataSource = self
        fileTypePickerView.delegate = self
    }
    
    @objc func uploadFileButtonPressed(){
        if fileTypeTextField.text == "Audio" {
        } else if fileTypeTextField.text == "Video" {
            handleGallery()
        } else if fileTypeTextField.text == "Text" {
            handleGetDocument()
        }
    }
    
    @objc func submitButtonPressed(){
        
        let paymentVC = AppStoryboard.Journalist.viewController(PayNowViewControllerJM.self)
        paymentVC.selectServiceType = selectServiceTextField.text!
        
        if selectServiceTextField.text == "Trancribe"{
            paymentVC.selectServiceType = "transcribe"
        }else {
            paymentVC.selectServiceType = "translate"
        }
        
        paymentVC.email = emailTextField.text!
        
        if fileTypeTextField.text == "Video"{
            paymentVC.fileType = "video"
            paymentVC.fileDataVideo = videoData
        }else if fileTypeTextField.text == "Audio"{
            paymentVC.fileType = "audio"
        }else {
            paymentVC.fileType = "text"
            paymentVC.fileDataText = textData
        }
        //        paymentVC.fileType = fileTypeTextField.text!
        paymentVC.language = ToLanguageTextFileld.text!
        //        paymentVC.fileData = textData
        paymentVC.fileSize = finalFileSize
        paymentVC.filePrice = "\(getPriceData.price)"
        paymentVC.translateAndTranscribePay = "payAmount"
        self.navigationController?.pushViewController(paymentVC, animated: true)
        
    }
    
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func handleGallery() {
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleGetDocument() {
        let alert = UIAlertController(title: "Add Document", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.attachDocument()
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getFilePrice(fileSize : String, fileType : String, header : String ) {
        Webservices.sharedInstance.getTranslateAndtranscribePrice(fileSize: fileSize, fileType: fileType, header: header){(result,response,message)  in
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory = message {
                    self.getPriceData = somecategory
                    print("=============\(self.getPriceData.currency)")
                    print("=============\(self.getPriceData.price)")
                    self.submitButton.setTitle("SUBMIT AND PAY  \(self.getPriceData.currency)\(self.getPriceData.price)", for: .normal)
                    print(somecategory)
                }
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: response)
            }
        }
    }
    
}

//------PickerView and Texttfield delegate
extension NewTraslateAndTranscribeViewControllerJM: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
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
            selectServiceTextField.text = selectServiceArray[row]
            setUpTextField()
        } else {
            fileTypeTextField.text = fileTypeArray[row]
            setUpselectFileData()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == ToLanguageTextFileld{
            let preLangugeVC = AppStoryboard.PreLogin.viewController(ToLanguageViewControllerJM.self)
            preLangugeVC.delegate = self
            self.present(preLangugeVC, animated: true, completion: nil)
        }
    }
}

//--------GetLanguageName--------
extension NewTraslateAndTranscribeViewControllerJM: SendNameOfToLanguage {
    func languageName(name: String, id: String, langKey: String) {
        ToLanguageTextFileld.text = name
        
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


extension NewTraslateAndTranscribeViewControllerJM: UIDocumentPickerDelegate {
    
    private func attachDocument() {
        let types: [String] = [kUTTypeText as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            print("URL Failed")
            return
        }
        self.selectedTxt = selectedFileURL
        let fileName = selectedTxt?.absoluteString.fileName()
        let extensionName = selectedTxt?.absoluteString.fileExtension()
        
        self.uploadFileLabel.text = (fileName ?? " ") + "." + (extensionName ?? " ")
        //        self.uploadFileLabel.text = "\(fileName)"
        self.textUploadImage.image = #imageLiteral(resourceName: "Documents")
        
        print("selectedTxt=========\(selectedTxt)")
        
        //-------convert txt url into data---------
        guard let datas = selectedTxt else {
            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the document.")
        }
        do {
            textData = try Data(contentsOf: datas)
        } catch {}
        
        print("textData======\(textData)")
        
        do {
            let resources = try selectedTxt?.resourceValues(forKeys:[.fileSizeKey])
            let fileSize = resources?.fileSize!
            print ("fileSize=======\(fileSize!)")
            self.finalFileSize = "\(fileSize!)"
            getFilePrice(fileSize: "\(fileSize!)", fileType: "text", header: currentUserLogin.token)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


//------- Image Picker Extension ------
extension NewTraslateAndTranscribeViewControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            
            let fileName = mediaURLs?.absoluteString.fileName()
            let extensionName = mediaURLs?.absoluteString.fileExtension()
            
            self.uploadFileLabel.text = (fileName ?? " ") + "." + (extensionName ?? " ")
            if let thumbnailImage = getThumbnailImage(forUrl: mediaURLs!) {
                textUploadImage.image = thumbnailImage
            }
            
            //---------convert video url into data--------
            guard let data = mediaURLs else {
                return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }
            do {
                videoData = try Data(contentsOf: data)
            } catch {}
            
            print("videoData======\(videoData)")
            
            let asset = AVURLAsset.init(url: mediaURL) // AVURLAsset.init(url: outputFileURL as URL)
            // get the time in seconds
            let durationInSeconds = asset.duration.seconds
            print("==== Duration is ",durationInSeconds)
            self.finalFileSize = "\(durationInSeconds)"
            getFilePrice(fileSize: "\(durationInSeconds)", fileType: "video", header: currentUserLogin.token)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

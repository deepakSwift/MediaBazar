//
//  MyContentUpdoadControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices

class MyContentUpdoadControllerJM: UIViewController {
    
    @IBOutlet weak var contentCollectionView : UICollectionView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var uploadButton : UIButton!
    
    var contentData = contentModal()
    var currentUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    
    let imagePicker = UIImagePickerController()
    
    var selectedAllFiles = [URL]()
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var uploadedContentData = [storyListModal]()
    
    var checkButtonFlag2 = false
    
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setUpCollectionView()
        setupButton()
        setupUI()
        self.currentUserLogin = User.loadSavedUser()
        getContentData(page: "0", header: currentUserLogin.token)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.currentUserLogin = User.loadSavedUser()
//        getContentData(page: "0", header: currentUserLogin.token)
    }
    
    func setUpCollectionView(){
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.delegate = self
//        self.contentCollectionView.collectionViewLayout = self
       
        
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(clickOnUoploadButton), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnUoploadButton(){
        handleGetImage()
        
        var contentData = [Data]()
        
        for contentURL in selectedAllFiles {
            print("URL ------ \(contentURL)")
            if let data = try? Data(contentsOf: contentURL){
                print(data)
                contentData.append(data)
                print("imageData=============\(contentData)")
                
            }
        }
        
        postContentData(mycontnt: contentData, header: currentUserLogin.token)
        
        
        
    }
    
    func handleGetImage() {
        let alert = UIAlertController(title: "Add Content", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Images", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Files", style: .default, handler: { _ in
            self.openFile()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Video", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Audio", style: .default, handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveImage(pickedImage: UIImage) -> URL? {
        let imageURL = document.appendingPathComponent("\(Date().timeIntervalSince1970).png", isDirectory: true)
        do {
            try pickedImage.pngData()?.write(to: imageURL)
            print("Added successfully")
            return imageURL
        } catch {
            print("Not added")
        }
        return nil
    }
    
    
    func getContentData(page : String,header : String){
        Webservices.sharedInstance.getupdoadContentData(page: page, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.contentData = somecategory
                    //                    self.contentCollectionView.reloadData()
                    self.scrollPage = true
                    self.uploadedContentData.append(contentsOf: somecategory.docs)
                    self.contentCollectionView.reloadData()
                    self.page = somecategory.page
                    self.totalPages = somecategory.pages
                    if self.page == self.totalPages{
                        self.scrollPage = false
                    }else {
                        self.scrollPage = true
                    }
                    print("page=====\(self.page)")
                    print("\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func contentDeleteByID(contentID : String, header : String){
        Webservices.sharedInstance.deleteUploadedContentByID(contentID: contentID, header: header){
            (result,message,response) in
            if result == 200{
                print("===================\(response)")
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }

    }
    
    
    
    func postContentData(mycontnt: [Data], header: String){
        Webservices.sharedInstance.postupdoadContentData(upload: mycontnt, header: header){
            (result,message,response) in
            if result == 200{
                print("===================\(response)")
                self.contentCollectionView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}
extension MyContentUpdoadControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            if let imageUrl = saveImage(pickedImage: selectedImage) {
                //                                self.selectedURl = imageUrl
                self.selectedAllFiles.append(imageUrl)
                
                print("selectedURl========\(selectedAllFiles)")
                print("selectedAllFiles========\(selectedAllFiles.count)")
            }
            
            
            if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.movie" {
                let mediaURL = info[.mediaURL] as! URL
                self.selectedAllFiles.append(mediaURL)
                
                //                                self.selectedVideoURL = mediaURL
                print("selectedVideoURL========\(selectedAllFiles)")
                print("selectedVideoURL========\(selectedAllFiles.count)")
            }
            
            
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MyContentUpdoadControllerJM: UIDocumentPickerDelegate {
    
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
        
        //                self.selectedPDF = selectedFileURL
        self.selectedAllFiles.append(selectedFileURL)
        
        print("selectedFileArray========\(selectedAllFiles)")
        print("selectedFileArray========\(selectedAllFiles.count)")
        
        let pdfViewController = PDFController(pdfUrl: selectedFileURL)
        present(pdfViewController, animated: true, completion: nil)
        
        
    }
}

extension MyContentUpdoadControllerJM: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return contentData.docs.count
        return uploadedContentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyContentUpdoadCollectionViewCell", for: indexPath) as! MyContentUpdoadCollectionViewCell
        cell.popUpView.isHidden = true
        //        let arrdata = contentData.docs[indexPath.item]
        let arrdata = uploadedContentData[indexPath.item]
        cell.contentName.text = arrdata.myContent.contentOriginalName
        
        let ext = arrdata.myContent.contentDuplicateName.fileExtension()
        print("ext======\(ext)")
        
        if ext == "mp3" {
            cell.contentImage.image = #imageLiteral(resourceName: "images-2")
        } else if ext == "jpg" {
            let getContentUrl = "\(self.baseUrl)\(arrdata.myContent.contentDuplicateName)"
            let strWithNoSpace = getContentUrl.replacingOccurrences(of: " ", with: "%20")
            let url = NSURL(string: strWithNoSpace)
            cell.contentImage.sd_setImage(with: url! as URL)
        }else if ext == "png"{
            //            cell.contentImage.image = #imageLiteral(resourceName: "images2")
            let getPngFile = "\(self.baseUrl)\(arrdata.myContent.contentDuplicateName)"
            let strWithNoSpace = getPngFile.replacingOccurrences(of: " ", with: "%20")
            print("strWithNoSpace===========\(strWithNoSpace)")
            let url = NSURL(string: strWithNoSpace)
            cell.contentImage.sd_setImage(with: url! as URL)
        } else if ext == "pdf"{
            cell.contentImage.image = #imageLiteral(resourceName: "Documents")
        } else {
            cell.contentImage.image = #imageLiteral(resourceName: "images-1")
        }
        
        cell.popupButton.addTarget(self, action: #selector(onClickPopUpButton(sender:)), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(onClickDeleteButton(_:)), for: .touchUpInside)
        cell.renameButton.addTarget(self, action: #selector(onClickRenameButton(_:)), for: .touchUpInside)
        
        return cell
        
    }
 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !scrollPage { return }
        if (uploadedContentData.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            getContentData(page: "\(page)", header: currentUserLogin.token)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let collectionViewWidth = collectionView.bounds.width
//        return CGSize(width: (collectionViewWidth-95)/2, height: (collectionViewWidth-160)/2)
//    }
    
    @objc func onClickPopUpButton(sender : UIButton){
        
        if let indexPath = sender.collectionViewIndexPath(self.contentCollectionView) as IndexPath? {
            let cell = self.contentCollectionView.cellForItem(at: indexPath) as? MyContentUpdoadCollectionViewCell
            
            sender.isSelected = !sender.isSelected
            if sender.isSelected == true{
                cell?.popUpView.isHidden = true
            }else if sender.isSelected == false{
                cell?.popUpView.isHidden = false
            }
        }

    }
    
    @IBAction func onClickDeleteButton(_ sender : UIButton){
        
        if let indexpath = sender.collectionViewIndexPath(self.contentCollectionView) as IndexPath? {
           let cell = self.contentCollectionView.cellForItem(at: indexpath) as? MyContentUpdoadCollectionViewCell
            cell?.popUpView.isHidden = true

            let ids = uploadedContentData[indexpath.item].id
            print("printID=====\(ids)")
            contentDeleteByID(contentID: ids, header: currentUserLogin.token)
            self.contentCollectionView.reloadData()
        }
    }
    
    
    @objc func onClickRenameButton(_ sender : UIButton){
        
        let renamePopUpVC = AppStoryboard.Journalist.viewController(ContentRenameUploadViewController.self)
        if let indexpath = sender.collectionViewIndexPath(self.contentCollectionView) as IndexPath? {
            
            let cell = self.contentCollectionView.cellForItem(at: indexpath) as? MyContentUpdoadCollectionViewCell
            cell?.popUpView.isHidden = true

            let contentIDs = uploadedContentData[indexpath.item].id
            renamePopUpVC.contentID = contentIDs
            renamePopUpVC.contentName = uploadedContentData[indexpath.item].myContent.contentOriginalName
            }

        renamePopUpVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        renamePopUpVC.modalPresentationStyle = .overFullScreen
        
        self.present(renamePopUpVC,animated:true,completion:nil)
        
    }


}

//extension MyContentUpdoadControllerJM: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let collectionViewWidth = collectionView.bounds.width
//        return CGSize(width: (collectionViewWidth)/2, height: (collectionViewWidth-100)/2)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 31
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 35
//    }
//
//}


extension MyContentUpdoadControllerJM: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 20) / 2 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth)

    }
}

//Check the media file extension
extension String {
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}

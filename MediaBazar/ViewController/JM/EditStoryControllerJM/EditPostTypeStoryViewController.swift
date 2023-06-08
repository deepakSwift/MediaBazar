//
//  EditPostTypeStoryViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 22/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices
import MediaPlayer


enum FileButtonTypes: String {
    case ButtonTypePhoto = "ButtonTypePhoto"
    case ButtonTypeVideo = "ButtonTypeVideo"
}


class EditPostTypeStoryViewController: UIViewController {
    
    @IBOutlet weak var postStoryTableView : UITableView!
    @IBOutlet weak var imageButtonView : UIView!
    @IBOutlet weak var thumbnailImageButtonView : UIView!
    @IBOutlet weak var videoButtonView : UIView!
    @IBOutlet weak var audioButtonView : UIView!
    @IBOutlet weak var documentButtonView : UIView!
    @IBOutlet weak var topView : UIView!
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var textButton : UIButton!
    @IBOutlet weak var imageButton : UIButton!
    @IBOutlet weak var thumbnailButton : UIButton!
    @IBOutlet weak var videoButton : UIButton!
    @IBOutlet weak var audioButton : UIButton!
    @IBOutlet weak var documentButton : UIButton!
    @IBOutlet weak var saveStoryButton : UIButton!
    @IBOutlet weak var postStoryButton : UIButton!
    
    @IBOutlet weak var textContainerView : UIView!
    @IBOutlet weak var imageContainerView : UIView!
    @IBOutlet weak var thumbnailContainerView : UIView!
    @IBOutlet weak var videoContainerView : UIView!
    @IBOutlet weak var audioContainerView : UIView!
    @IBOutlet weak var documentContainerView : UIView!
    
    @IBOutlet weak var imageCollectionView : UICollectionView!
    @IBOutlet weak var thumbnaimImageCollectionVIew : UICollectionView!
    @IBOutlet weak var videoCollectioView : UICollectionView!
    @IBOutlet weak var audioCollectionView : UICollectionView!
    @IBOutlet weak var supportinDocumentCollectionView : UICollectionView!
    
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var pdfTextImageView : UIImageView!
    @IBOutlet weak var uploadTextPdfButton : UIButton!
        
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    var currentUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var storyDetail = storyListModal()
    
    var selectedTextDocument = [URL]()
    var selectedImageArray = [URL]()
    var selectedThumbnailArray = [URL]()
    var selectedVideoArray = [URL]()
    var selectedFileArray = [URL]()
    var selectedAudioArray = [URL]()
    
    
    var imageTextNote = [String]()
    var thumbnailNote = [String]()
    var videoNote = [String]()
    var supportingDocumentNote = [String]()
    var audioNote = [String]()
    
    var updateSelectedTextDocument = [URL]()
    var updateSelectedImageArray = [URL]()
    var updateSelectedThumbnailArray = [URL]()
    var updateSelectedVideoArray = [URL]()
    var updateSelectedFileArray = [URL]()
    var updateSelectedAudioArray = [URL]()
    
    
    
    var imagePicker = UIImagePickerController()
    var buttonType: FileButtonTypes = .ButtonTypePhoto
    
    
    
    var selectedURl: URL? {
        didSet {
            if imageButton.isSelected == true {
                self.updateSelectedImageArray.append(selectedURl!)
                print("updateSelectedImageArray===========---\(updateSelectedImageArray.count)")
            } else if thumbnailButton.isSelected == true {
                self.updateSelectedThumbnailArray.append(selectedURl!)
                print("updateSelectedThumbnailArray===========---\(updateSelectedThumbnailArray.count)")
            }
        }
    }
    
    
    var selectedPdfUrl: URL?{
        didSet{
            if documentButton.isSelected == true{
                self.updateSelectedFileArray.append(selectedPdfUrl!)
                print("updateSelectedFileArray---------------\(updateSelectedFileArray.count)")
            } else if uploadTextPdfButton.isSelected == true {
                self.updateSelectedTextDocument.append(selectedPdfUrl!)
                print("updateSelectedTextDocument===========\(updateSelectedTextDocument.count)")
                
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentUserLogin = User.loadSavedUser()
        setPerviousData()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadCollectionViewData()
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveStoryButton, borderColor: .gray, borderWidth: 1, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(postStoryButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        //        self.supportinDocumentCollectionView.DataSource = self
        
        self.supportinDocumentCollectionView.delegate = self
        
    }
    
    func reloadCollectionViewData(){
        imageCollectionView.reloadData()
        thumbnaimImageCollectionVIew.reloadData()
        videoCollectioView.reloadData()
        audioCollectionView.reloadData()
        supportinDocumentCollectionView.reloadData()
    }
    
    
    func hideAndShowCollectionView(){
        if selectedTextDocument.count == 0{
            textView.isHidden = true
            pdfTextImageView.isHidden = true
            uploadTextPdfButton.isHidden = true
        } else {
            textView.isHidden = false
            pdfTextImageView.isHidden = false
            uploadTextPdfButton.isHidden = false
        }
        
        if selectedImageArray.count == 0{
            imageCollectionView.isHidden = true
        } else {
            imageCollectionView.isHidden = false
        }
        
        if selectedThumbnailArray.count == 0{
            thumbnaimImageCollectionVIew.isHidden = true
        } else {
            thumbnaimImageCollectionVIew.isHidden = false
        }
        
        if selectedVideoArray.count == 0{
            videoCollectioView.isHidden = true
        }else {
            videoCollectioView.isHidden = false
        }
        
        if selectedFileArray.count == 0{
            supportinDocumentCollectionView.isHidden = true
        } else {
            supportinDocumentCollectionView.isHidden = false
        }
        
        if selectedAudioArray.count == 0{
            audioCollectionView.isHidden = true
        } else {
            audioCollectionView.isHidden = false
        }
        
        
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton
            ), for: .touchUpInside)
        
        saveStoryButton.addTarget(self, action: #selector(onClickSaveButton), for: .touchUpInside)
        postStoryButton.addTarget(self, action: #selector(onClickPostButton), for: .touchUpInside)
        
        imageButton.addTarget(self, action: #selector(onClickImagePickerView), for: .touchUpInside)
        thumbnailButton.addTarget(self, action: #selector(onClickThumbnailImagePickerView), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(onClickVideoPickerView), for: .touchUpInside)
        audioButton.addTarget(self, action: #selector(onClickAudioPickerView), for: .touchUpInside)
        documentButton.addTarget(self, action: #selector(onclickDocUpload), for: .touchUpInside)
        uploadTextPdfButton.addTarget(self, action: #selector(onCLickTextPfdUpload), for: .touchUpInside)
        
    }
    
    
    func handleGetDocument() {
        
        let alert = UIAlertController(title: "Add Resume", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.openFile()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleGetPickerView(){
        
        buttonType = .ButtonTypePhoto
        
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleGetVideoPickerView(){
        
        buttonType = .ButtonTypeVideo
        
        let alert = UIAlertController(title: "Add Media", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Video Library", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func handleAudioPicker() {
        
        let alert = UIAlertController(title: "Add Audio", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.openAudio()
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
    
    
    
    
    func setPerviousData(){
        
        for imageUrl in storyDetail.uploadImages.enumerated(){
            let images = imageUrl.element.Image
            if let url = URL(string: "\(self.baseUrl)\(images)"){
                self.selectedImageArray.append(url)
            }
            //            self.imageTextNote.append(imageNoote)
            print("selectedImageArray=========1\(selectedImageArray)")
        }
        
        for thumbnailUrl in storyDetail.uploadThumbnails.enumerated(){
            let thumbnailImages = thumbnailUrl.element.thumbnale
            if let url = URL(string: "\(self.baseUrl)\(thumbnailImages)"){
                self.selectedThumbnailArray.append(url)
            }
            //            self.thumbnailNote.append(thumbNote)
            print("selectedThumbnailArray=========\(selectedThumbnailArray)")
            
        }
        
        for videoUrl in storyDetail.uploadVideos.enumerated(){
            let videos = videoUrl.element.video
            if let url = URL(string: "\(self.baseUrl)\(videos)"){
                self.selectedVideoArray.append(url)
            }
            //            self.videoNote.append(videoNote)
            print("selectedThumbnailArray========\(selectedVideoArray)")
            
        }
        
        for audioUrl in storyDetail.uploadAudios.enumerated(){
            let audios = audioUrl.element.audio
            if let url = URL(string: "\(self.baseUrl)\(audios)"){
                self.selectedAudioArray.append(url)
            }
            //            self.audioNote.append(audNote)
            print("selectedAudioArray=========\(selectedAudioArray)")
        }
        
        for documentUrl in storyDetail.supportingDocs.enumerated(){
            let docus = documentUrl.element.doc
            if let url = URL(string: "\(self.baseUrl)\(docus)"){
                self.selectedFileArray.append(url)
            }
            //            self.audioNote.append(docNote)
            print("selectedFileArray===========\(selectedFileArray)")
            
        }
        
    }
    
    func setUpCollectionView(){
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        
        self.thumbnaimImageCollectionVIew.dataSource = self
        self.thumbnaimImageCollectionVIew.delegate = self
        
        self.videoCollectioView.dataSource = self
        self.videoCollectioView.delegate = self
        
        self.supportinDocumentCollectionView.dataSource = self
        self.supportinDocumentCollectionView.delegate = self
        
        self.audioCollectionView.dataSource = self
        self.audioCollectionView.delegate = self
        
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
    
    @objc func onClickNoteButton(sender : UIButton){

        let noteVC = AppStoryboard.Journalist.viewController(StoryNoteViewControllerJM.self)
        let fieldNote = storyDetail.uploadImages[sender.tag].imageNote
        noteVC.note = fieldNote
        noteVC.showNote = "note"
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickThumbnailNoteButton(sender : UIButton){
        
        let noteVC = AppStoryboard.Journalist.viewController(ThumbImageNoteViewController.self)
        let fieldNote = storyDetail.uploadThumbnails[sender.tag].thumbnaleNote
        noteVC.note = fieldNote
        noteVC.showNote = "note"
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickVideoNoteButton(sender : UIButton){
        
        let noteVC = AppStoryboard.Journalist.viewController(VideoNoteViewController.self)
        let fieldNote = storyDetail.uploadVideos[sender.tag].videoNote
        noteVC.note = fieldNote
        noteVC.showNote = "note"
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickSupportingDocumentNoteButton(sender : UIButton){
        
        let noteVC = AppStoryboard.Journalist.viewController(SupportingDocuNoteViewController.self)
        let fieldNote = storyDetail.supportingDocs[sender.tag].docNote
        noteVC.note = fieldNote
        noteVC.showNote = "note"
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        //        noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickAudioNoteButton(sender : UIButton){
        
        let noteVC = AppStoryboard.Journalist.viewController(AudioNoteViewController.self)
        let fieldNote = storyDetail.uploadAudios[sender.tag].audioNote
        noteVC.note = fieldNote
        noteVC.showNote = "note"
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        //         noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.pop(true)
    }
    
    
    @objc func onclickDocUpload() {
        imageButton.isSelected = false
        thumbnailButton.isSelected = false
        videoButton.isSelected = false
        documentButton.isSelected = true
        uploadTextPdfButton.isSelected = false
        //        handlesupportintDocCollectionView()
        handleGetDocument()
    }
    
    @objc func onCLickTextPfdUpload(){
        imageButton.isSelected = false
        thumbnailButton.isSelected = false
        videoButton.isSelected = false
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = true
        
        handleGetDocument()
    }
    
    @objc func onClickImagePickerView(_sender: UIButton){
        imageButton.isSelected = true
        thumbnailButton.isSelected = false
        videoButton.isSelected = false
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        //        handleImageCollectionView()
        handleGetPickerView()
        
        
    }
    
    @objc func onClickThumbnailImagePickerView(){
        imageButton.isSelected = false
        thumbnailButton.isSelected = true
        videoButton.isSelected = false
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        //        handleThumbnailImageCollectionView()
        handleGetPickerView()
        
    }
    
    @objc func onClickVideoPickerView(){
        imageButton.isSelected = false
        thumbnailButton.isSelected = false
        videoButton.isSelected = true
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        //        handleVideoCollectionView()
        handleGetVideoPickerView()
        
    }
    
    @objc func onClickAudioPickerView(){
        handleAudioPicker()
    }
    
    
    @objc func clickOnDeleteImagesButton(sender : UIButton){
        let storyID = storyDetail.id
        print("storyID=====\(storyID)")
        let fieldID = storyDetail.uploadImages[sender.tag].id
        print("fieldID=====\(fieldID)")
        deleteFileById(storyID: storyID, fieldID: fieldID, header: currentUserLogin.token)
        
    }
    
    @objc func clickOnDeleteThumbnailImagesButton(sender : UIButton){
        let storyID = storyDetail.id
        print("storyID=====\(storyID)")
        let fieldID = storyDetail.uploadThumbnails[sender.tag].id
        print("fieldID=====\(fieldID)")
        deleteFileById(storyID: storyID, fieldID: fieldID, header: currentUserLogin.token)
        
    }
    
    @objc func clickOnDeleteVideoButton(sender : UIButton){
        let storyID = storyDetail.id
        print("storyID=====\(storyID)")
        let fieldID = storyDetail.uploadVideos[sender.tag].id
        print("fieldID=====\(fieldID)")
        deleteFileById(storyID: storyID, fieldID: fieldID, header: currentUserLogin.token)
        
    }
    
    @objc func clickOnDeleteAudioButton(sender : UIButton){
        let storyID = storyDetail.id
        print("storyID=====\(storyID)")
        let fieldID = storyDetail.uploadAudios[sender.tag].id
        print("fieldID=====\(fieldID)")
        
    }
    
    @objc func clickOnDeleteSupportingDocuButton(sender : UIButton){
        let storyID = storyDetail.id
        print("storyID=====\(storyID)")
        let fieldID = storyDetail.supportingDocs[sender.tag].id
        print("fieldID=====\(fieldID)")
        deleteFileById(storyID: storyID, fieldID: fieldID, header: currentUserLogin.token)
        
    }

    
    
    @objc func onClickPostButton(){
        
        //        getDataByCollobrateGroup()
        
        var imageData = [Data]()
        var thumbnailData = [Data]()
        var videoData = [Data]()
        var supportingDocu = [Data]()
        var textData = [Data]()
        //        var pdfData = [Data]()
        
        
        
        let imgNote = "\(imageTextNote)"
        var imgsNote = imgNote.replacingOccurrences(of: "[", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: "]", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: "\"", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: " ", with: "")
        print("=========imgsNote=========\(imgsNote)")
        
        let thumbImgNote = "\(thumbnailNote)"
        var thumbImgsNote = thumbImgNote.replacingOccurrences(of: "[", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: "]", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: "\"", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: " ", with: "")
        print("=========thumbImgsNote=========\(thumbImgsNote)")
        
        
        let videosNote = "\(videoNote)"
        var videosNotes = videosNote.replacingOccurrences(of: "[", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: "]", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: "\"", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: " ", with: "")
        print("=========videosNotes=========\(videosNotes)")
        
        let supportingsDocumentNote = "\(supportingDocumentNote)"
        var supportingNotes = supportingsDocumentNote.replacingOccurrences(of: "[", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: "]", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: "\"", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: " ", with: "")
        print("=========supportingNotes=========\(supportingNotes)")
        
        let audiosNote = "\(audioNote)"
        var audiosNotes = audiosNote.replacingOccurrences(of: "[", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: "]", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: "\"", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: " ", with: "")
        print("=========audiosNotes=========\(audiosNotes)")
        
        
        
        for imageURL in updateSelectedImageArray {
            print("URL ------ \(imageURL)")
            if let data = try? Data(contentsOf: imageURL){
                print(data)
                imageData.append(data)
                print("imageData=============\(imageData)")
                
            }
        }
        
        for thumURL in updateSelectedThumbnailArray{
            print("URL ----------\(thumURL)")
            if let data = try? Data(contentsOf: thumURL), let singleImage = UIImage(data: data), let thuData = singleImage.jpegData(compressionQuality: 0.9){
                print(thuData)
                thumbnailData.append(thuData)
                print("thumbnailData=============\(thumbnailData)")
                
            }
        }
        
        for videoURL in updateSelectedVideoArray{
            print("URL -------\(videoURL)")
            if let data = try? Data(contentsOf: videoURL){
                print(data)
                videoData.append(data)
                print("videoData=============\(videoData)")
                
            }
        }
        
        for supportingDocuURL in updateSelectedFileArray{
            print("URL -------\(supportingDocuURL)")
            if let data = try? Data(contentsOf: supportingDocuURL){
                print(data)
                supportingDocu.append(data)
                print("supportingDocu=============\(supportingDocu)")
            }
        }
        
        for textDocuURL in updateSelectedTextDocument{
            print("URL -------\(textDocuURL)")
            if let data = try? Data(contentsOf: textDocuURL){
                print(data)
                textData.append(data)
                print("textDocuURL=============\(textDocuURL)")
            }
        }
        
        let text = textView.text
        
        updateStory(storyID: storyDetail.id, uploadText: textData, textNote: text ?? "", uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes,uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote,header: currentUserLogin.token)
        
        
    }
    
    @objc func onClickSaveButton(){
        
        //        getDataByCollobrateGroup()
        
        var imageData = [Data]()
        var thumbnailData = [Data]()
        var videoData = [Data]()
        var supportingDocu = [Data]()
        var textData = [Data]()
        
        
        //        var pdfData = [Data]()
        
        let imgNote = "\(imageTextNote)"
        var imgsNote = imgNote.replacingOccurrences(of: "[", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: "]", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: "\"", with: "")
        imgsNote = imgsNote.replacingOccurrences(of: " ", with: "")
        print("=========imgsNote=========\(imgsNote)")
        
        let thumbImgNote = "\(thumbnailNote)"
        var thumbImgsNote = thumbImgNote.replacingOccurrences(of: "[", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: "]", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: "\"", with: "")
        thumbImgsNote = thumbImgsNote.replacingOccurrences(of: " ", with: "")
        print("=========thumbImgsNote=========\(thumbImgsNote)")
        
        
        let videosNote = "\(videoNote)"
        var videosNotes = videosNote.replacingOccurrences(of: "[", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: "]", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: "\"", with: "")
        videosNotes = videosNotes.replacingOccurrences(of: " ", with: "")
        print("=========videosNotes=========\(videosNotes)")
        
        let supportingsDocumentNote = "\(supportingDocumentNote)"
        var supportingNotes = supportingsDocumentNote.replacingOccurrences(of: "[", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: "]", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: "\"", with: "")
        supportingNotes = supportingNotes.replacingOccurrences(of: " ", with: "")
        print("=========supportingNotes=========\(supportingNotes)")
        
        let audiosNote = "\(audioNote)"
        var audiosNotes = audiosNote.replacingOccurrences(of: "[", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: "]", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: "\"", with: "")
        audiosNotes = audiosNotes.replacingOccurrences(of: " ", with: "")
        print("=========audiosNotes=========\(audiosNotes)")
        
        
        for imageURL in updateSelectedImageArray {
            print("URL ------ \(imageURL)")
            if let data = try? Data(contentsOf: imageURL){
                print(data)
                imageData.append(data)
                print("imageData=============\(imageData)")
                
                
            }
        }
        
        for thumURL in updateSelectedThumbnailArray{
            print("URL ----------\(thumURL)")
            if let data = try? Data(contentsOf: thumURL), let singleImage = UIImage(data: data), let thuData = singleImage.jpegData(compressionQuality: 0.9){
                print(thuData)
                thumbnailData.append(thuData)
                print("thumbnailData=============\(thumbnailData)")
                
            }
        }
        
        for videoURL in updateSelectedVideoArray{
            print("URL -------\(videoURL)")
            if let data = try? Data(contentsOf: videoURL){
                print(data)
                videoData.append(data)
                print("videoData=============\(videoData)")
                
            }
        }
        
        for supportingDocuURL in updateSelectedFileArray{
            print("URL -------\(supportingDocuURL)")
            if let data = try? Data(contentsOf: supportingDocuURL){
                print(data)
                supportingDocu.append(data)
                print("supportingDocu=============\(supportingDocu)")
            }
        }
        
        for textDocuURL in updateSelectedTextDocument{
            print("URL -------\(textDocuURL)")
            if let data = try? Data(contentsOf: textDocuURL){
                print(data)
                textData.append(data)
                print("textDocuURL=============\(textDocuURL)")
            }
        }
        
        let text = textView.text
        
        updateStory(storyID: storyDetail.id, uploadText: textData, textNote: text ?? "", uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes,uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote,header: currentUserLogin.token)
    }
    
    
    func updateStory(storyID: String, uploadText: [Data], textNote : String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote : String, supportingDocu: [Data], docNote: String, uploadAudio: String, audioNote: String,uploadThumbnail: [Data], thumbnailNote: String, header: String){
        Webservices.sharedInstance.updateSecondFormStory(storyID: storyID, uploadTexts: uploadText, textNote: textNote, uploadImages: uploadImages, imageNote: imageNote, uploadVideos: uploadVideos, videoNote: videoNote, supportingDocs: supportingDocu, docNote: docNote, uploadAudio: uploadAudio, audioNote: audioNote, uploadThumbnails: uploadThumbnail, thumbnailNote: thumbnailNote, header: header){
            (result,message,response) in
            if result == 200{
                self.reloadCollectionViewData()
                self.hideAndShowCollectionView()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func deleteFileById(storyID: String, fieldID: String, header: String){
        Webservices.sharedInstance.deleteFileByStoryID(storyID: storyID, fieldID: fieldID, storyHeader: header){
            (result,message,response) in
            if result == 200{
                self.reloadCollectionViewData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }


    
    
}

extension EditPostTypeStoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return selectedImageArray.count
        } else if collectionView == thumbnaimImageCollectionVIew{
            return selectedThumbnailArray.count
        } else if collectionView == videoCollectioView {
            return selectedVideoArray.count
        } else if collectionView == audioCollectionView{
            return selectedAudioArray.count
        } else {
            return selectedFileArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == imageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            let arrdata = selectedImageArray[indexPath.item]
            cell.img.sd_setImage(with: arrdata)
            
            let name = storyDetail.uploadImages[indexPath.item]
            cell.imageName.text = name.Image
            //            cell.img.image = #imageLiteral(resourceName: "images5")
            cell.noteButton.tag = indexPath.row
            cell.noteButton.addTarget(self, action: #selector(onClickNoteButton(sender:)), for: .touchUpInside)
            print("=========\(selectedImageArray)")
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(clickOnDeleteImagesButton(sender:)), for: .touchUpInside)
            
            
            return cell
        } else if collectionView == thumbnaimImageCollectionVIew {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailImagesCollectionViewCell", for: indexPath) as! ThumbnailImagesCollectionViewCell
            let arrdata = selectedThumbnailArray[indexPath.item]
            cell.thumbNailImage.sd_setImage(with: arrdata)
            
            let name = storyDetail.uploadThumbnails[indexPath.item]
            cell.thumbnailName.text = name.thumbnale
            
            //            cell.thumbNailImage.image = #imageLiteral(resourceName: "images45")
            cell.noteButton.tag = indexPath.row
            cell.noteButton.addTarget(self, action: #selector(onClickThumbnailNoteButton(sender:)), for: .touchUpInside)
            print("=========\(selectedThumbnailArray)")
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(clickOnDeleteThumbnailImagesButton(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == supportinDocumentCollectionView{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:"SupportingDocumentCollectionViewCell", for: indexPath) as! SupportingDocumentCollectionViewCell
            cell.pdfThumbnailImage.image = #imageLiteral(resourceName: "Documents")
            let name = storyDetail.supportingDocs[indexPath.item]
            cell.pdfName.text = name.doc
            
            cell.noteButton.tag = indexPath.row
            cell.noteButton.addTarget(self, action: #selector(onClickSupportingDocumentNoteButton(sender:)), for: .touchUpInside)
            print("=========\(selectedFileArray)")
            
            cell.deletButton.tag = indexPath.row
            cell.deletButton.addTarget(self, action: #selector(clickOnDeleteSupportingDocuButton(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == videoCollectioView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as! VideosCollectionViewCell
            let arrdata = selectedVideoArray[indexPath.item]
            
            if let thumbnailImage = getThumbnailImage(forUrl: arrdata) {
                cell.videoImage.image = thumbnailImage
            }
            
            let name = storyDetail.uploadVideos[indexPath.item]
            cell.videoName.text = name.video
            //            cell.videoImage.image = #imageLiteral(resourceName: "images1")
            cell.noteButton.tag = indexPath.row
            cell.noteButton.addTarget(self, action: #selector(onClickVideoNoteButton(sender:)), for: .touchUpInside)
            print("=========\(selectedVideoArray)")
            
            cell.deletButton.tag = indexPath.row
            cell.deletButton.addTarget(self, action: #selector(clickOnDeleteVideoButton(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == audioCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudiosCollectionViewCell", for: indexPath) as! AudiosCollectionViewCell
            cell.audioImage.image = #imageLiteral(resourceName: "images-2")
            let name = storyDetail.uploadAudios[indexPath.item]
            cell.videoName.text = name.audio
            
            cell.noteButton.tag = indexPath.row
            cell.noteButton.addTarget(self, action: #selector(onClickAudioNoteButton(sender:)), for: .touchUpInside)
            //                        print("=========\(selectedVideoArray)")
            
            cell.deletButton.tag = indexPath.row
            cell.deletButton.addTarget(self, action: #selector(clickOnDeleteAudioButton(sender:)), for: .touchUpInside)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.bounds.height
        let cellWidth = collectionViewHeight * (160 / 260)
        return CGSize(width: cellWidth, height: collectionViewHeight)
    }
    
}



// updoad document
extension EditPostTypeStoryViewController: UIDocumentPickerDelegate {
    
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
        self.selectedPdfUrl = selectedFileURL
        let pdfViewController = PDFController(pdfUrl: selectedFileURL)
        
        //        if let selcetedPdfUrl = selectedPDF{
        //            self.selectedFileArray.append(selectedPDF!)
        //            self.supportinDocumentCollectionView.reloadData()
        //            print("====================\(selectedFileArray.count)")
        //        }
        self.supportinDocumentCollectionView.reloadData()
        
        
        present(pdfViewController, animated: true, completion: nil)
    }
}

// upload image & Video
extension EditPostTypeStoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        if buttonType == .ButtonTypePhoto{
            var selectedImageFromPicker: UIImage?
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker {
                if let imageUrl = saveImage(pickedImage: selectedImage) {
                    self.selectedURl = imageUrl
                    self.imageCollectionView.reloadData()
                    self.thumbnaimImageCollectionVIew.reloadData()
                }
                print("selectedimage")
            }
        } else if buttonType == .ButtonTypeVideo{
            
            var selectedImageFromPicker: UIImage?
            
            if let chosenImage = info[.editedImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let chosenImage = info[.originalImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.movie" {
                let mediaURL = info[.mediaURL] as! URL
                self.updateSelectedVideoArray.append(mediaURL)
                self.videoCollectioView.reloadData()
                print("==============\(updateSelectedVideoArray.count)")
                print("==============\(updateSelectedVideoArray)")
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}




extension EditPostTypeStoryViewController: MPMediaPickerControllerDelegate{
    
    func openAudio() {
        //        let audiopicker = MPMediaPickerController(mediaTypes: MPMediaType.anyAudio)
        let audiopicker = MPMediaPickerController(mediaTypes: MPMediaType.music)
        audiopicker.prompt = "Audio"
        audiopicker.delegate = self
        audiopicker.allowsPickingMultipleItems = true
        self.present(audiopicker, animated: true, completion: nil)
    }
    
    //    func openAudio() {
    //        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeMovie as String,], in: .import)
    //        documentPicker.delegate = self
    //        documentPicker.allowsMultipleSelection = true
    //        present(documentPicker, animated: true, completion: nil)
    //    }
    
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        guard mediaItemCollection.items.first != nil else {
            NSLog("No item selected.")
            return
        }
        
        //        guard let selectedFileURL = mediaItemCollection.items.first else {
        //            print("URL Failed")
        //            return
        //        }
        
        
        //
        //        self.songUrl = mediaItem.value(forProperty: MPMediaItemPropertyAssetURL) as! NSURL
        //        print(songUrl)
        //
        self.dismiss(animated: true, completion: nil)
        
        //run any code you want once the user has picked their chosen audio
    }
    
    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension EditPostTypeStoryViewController:sendImageNote{
    func imageNote(note: String) {
        self.imageTextNote.append(note)
        //        self.imageTextNote = note
        print("imageTextNote=========\(imageTextNote)")
    }
}
extension EditPostTypeStoryViewController:sendThumbImageNote{
    func thumbImageNote(note: String) {
        self.thumbnailNote.append(note)
        //        self.thumbnailNote = note
        print("thumbnailNote=========\(thumbnailNote)")
    }
}
extension EditPostTypeStoryViewController:sendVideoNote{
    func videoNote(note: String) {
        self.videoNote.append(note)
        //        self.videoNote = note
        print("videoNote=========\(videoNote)")
    }
}
extension EditPostTypeStoryViewController:sendDocumentNote{
    func documentNote(note: String) {
        self.supportingDocumentNote.append(note)
        //         self.supportingDocumentNote = note
        print("supportingDocumentNote=========\(supportingDocumentNote)")
    }
}

//
//  PostStoryTypeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AVFoundation

enum FileButtonType: String {
    case ButtonTypePhoto = "ButtonTypePhoto"
    case ButtonTypeVideo = "ButtonTypeVideo"
}

class PostStoryTypeViewControllerJM: UIViewController {
    
    //    @IBOutlet weak var postStoryTableView : UITableView!
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
    @IBOutlet weak var groupContaineView : UIView!
    
    @IBOutlet weak var imageCollectionView : UICollectionView!
    @IBOutlet weak var thumbnaimImageCollectionVIew : UICollectionView!
    @IBOutlet weak var videoCollectioView : UICollectionView!
    @IBOutlet weak var audioCollectionView : UICollectionView!
    @IBOutlet weak var supportinDocumentCollectionView : UICollectionView!
    
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var pdfTextImageView : UIImageView!
    @IBOutlet weak var uploadTextPdfButton : UIButton!
    
    @IBOutlet weak var collabrationTableView : UITableView!
    @IBOutlet weak var buttonCheck : UIButton!
    
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    var currentUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var blogId = ""
    var storyType = ""
    
    //    var selectedPDF: URL?
    
    var selectedFileArray = [URL]()
    var selectedImageArray = [URL]()
    var selectedThumbnailArray = [URL]()
    var selectedVideoArray = [URL]()
    var selectedTextDocument = [URL]()
    
    var selectedNewAudio = [URL]()
    
    var imageTextNote = [String]()
    var thumbnailNote = [String]()
    var videoNote = [String]()
    var supportingDocumentNote = [String]()
    var audioNote = [String]()
    
    
    var imagePicker = UIImagePickerController()
    var buttonType: FileButtonType = .ButtonTypePhoto
    
    var selectedAudio: URL?
    var songUrl: NSURL = NSURL()
    var player = AVPlayer()
    
    var newGroupData = newRequestModal()
    var selectedGroup = [storyListModal]()
    
    var groupID = ""
    var memberID = [String]()
    
    var selectedMyContentArray = [URL]()
    
    
    
    var selectedURl: URL? {
        didSet {
            if imageButton.isSelected == true {
                self.selectedImageArray.append(selectedURl!)
                print("selectedImageArray===========\(selectedImageArray.count)")
            } else if thumbnailButton.isSelected == true {
                self.selectedThumbnailArray.append(selectedURl!)
                print("selectedThumbnailArray===========\(selectedThumbnailArray.count)")
            }
        }
    }
    
    
    var selectedPdfUrl: URL?{
        didSet{
            if documentButton.isSelected == true{
                self.selectedFileArray.append(selectedPdfUrl!)
                print("selectedFileArray---------------\(selectedFileArray.count)")
            } else if uploadTextPdfButton.isSelected == true {
                self.selectedTextDocument.append(selectedPdfUrl!)
                print("selectedTextDocument===========\(selectedTextDocument.count)")
                
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setUpCollectionView()
        //        getDataByCollobrateGroup()
        
        audioCollectionView.isHidden = true
        collabrationTableView.isHidden = true
        groupContaineView.isHidden = true
        imagePicker.delegate = self
        //        postStoryTableView.reloadData()
        //        postStoryTableView.rowHeight = UITableView.automaticDimension
        //        postStoryTableView.estimatedRowHeight = 1500
        
        handleImageCollectionView()
        handleThumbnailImageCollectionView()
        handlesupportintDocCollectionView()
        handleVideoCollectionView()
        
        self.currentUserLogin = User.loadSavedUser()
        getGroupData(searchKey: "", header: currentUserLogin.token)
        
        textView.isHidden = true
        pdfTextImageView.isHidden = true
        uploadTextPdfButton.isHidden = true
        
        // Do any additional setup after loading the view.
        
        
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
        
        self.collabrationTableView.dataSource = self
        self.collabrationTableView.delegate = self
        
        collabrationTableView.register(UINib(nibName: "CollabrationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CollabrationTableViewCell")
        
    }
    
    //    func getDataByCollobrateGroup(){
    //
    //        for selectedGroupID in selectedGroup.enumerated(){
    //            let temData = selectedGroupID.element.id
    //            groupID.append(temData)
    //            print("groupID=========\(groupID)")
    //        }
    //
    //        for selectedMemberID in selectedGroup.enumerated(){
    //            for selectedGroupMemberID in selectedMemberID.element.members.enumerated(){
    //                let temDat2 = selectedGroupMemberID.element.id
    //                memberID.append(temDat2)
    //                print("memberID=========\(memberID)")
    //
    //                let temdata3 = selectedGroupMemberID.element.status
    //                if temdata3 == 1{
    //                    memberIDbyStatus.append(selectedGroupMemberID.element.id)
    //                    print("memberIDbyStatus==========\(memberIDbyStatus)")
    //                }
    //            }
    //        }
    //    }
    //
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveStoryButton, borderColor: .gray, borderWidth: 1, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(postStoryButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        //        self.supportinDocumentCollectionView.DataSource = self
        
        self.supportinDocumentCollectionView.delegate = self
        
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton
            ), for: .touchUpInside)
        saveStoryButton.addTarget(self, action: #selector(onClickSaveButton), for: .touchUpInside)
        postStoryButton.addTarget(self, action: #selector(onClickPostButton), for: .touchUpInside)
        
        imageButton.addTarget(self, action: #selector(onClickImagePickerView), for: .touchUpInside)
        thumbnailButton.addTarget(self, action: #selector(onClickThumbnailImagePickerView), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(onClickVideoPickerView), for: .touchUpInside)
        audioButton.addTarget(self, action: #selector(handleAudioPicker), for: .touchUpInside)
        documentButton.addTarget(self, action: #selector(onclickDocUpload), for: .touchUpInside)
        uploadTextPdfButton.addTarget(self, action: #selector(onCLickTextPfdUpload), for: .touchUpInside)
        buttonCheck.addTarget(self, action: #selector(onclickCheckBtn), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(onclickTextButton(_:)), for: .touchUpInside)
    }
    
    func openMyContent(){
        let contentGallary = AppStoryboard.Journalist.viewController(MyContentGalaryViewController.self)
        selectedMyContentArray.removeAll()
        contentGallary.delegate = self
        self.navigationController?.pushViewController(contentGallary, animated: true)
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
        
        alert.addAction(UIAlertAction(title: "Select Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Select Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "My Content", style: .default, handler: { _ in
            self.openMyContent()
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
    
    @objc func handleAudioPicker() {
        
        let alert = UIAlertController(title: "Add Audio", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Files", style: .default, handler: { _ in
            self.openAudio(self.audioButton)
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
    
    
    @objc func onclickTextButton(_ sender: UIButton) {
        if sender.isSelected == true {
            textView.isHidden = true
            pdfTextImageView.isHidden = true
            uploadTextPdfButton.isHidden = true
            sender.isSelected = false
        } else {
            textView.isHidden = false
            pdfTextImageView.isHidden = false
            uploadTextPdfButton.isHidden = false
            sender.isSelected = true
            
        }
    }
    
    
    
    
    func handleImageCollectionView(){
        if selectedImageArray.count == 0{
            imageCollectionView.isHidden = true
            self.imageCollectionView.reloadData()
            //            self.postStoryTableView.reloadData()
        } else {
            imageCollectionView.isHidden = false
            self.imageCollectionView.reloadData()
            //            self.postStoryTableView.reloadData()
        }
    }
    
    
    func handleThumbnailImageCollectionView(){
        if selectedThumbnailArray.count == 0{
            thumbnaimImageCollectionVIew.isHidden = true
            self.thumbnaimImageCollectionVIew.reloadData()
            //            self.postStoryTableView.reloadData()
        } else {
            
            thumbnaimImageCollectionVIew.isHidden = false
            self.thumbnaimImageCollectionVIew.reloadData()
            //            self.postStoryTableView.reloadData()
        }
    }
    
    func handleVideoCollectionView(){
        if selectedVideoArray.count == 0{
            videoCollectioView.isHidden = true
            self.videoCollectioView.reloadData()
            //            self.postStoryTableView.reloadData()
        } else {
            videoCollectioView.isHidden = false
            self.videoCollectioView.reloadData()
            //            self.postStoryTableView.reloadData()
        }
    }
    
    
    func handlesupportintDocCollectionView(){
        if selectedFileArray.count == 0{
            supportinDocumentCollectionView.isHidden = true
            supportinDocumentCollectionView.reloadData()
            //            self.postStoryTableView.reloadData()
        } else {
            supportinDocumentCollectionView.isHidden = false
            supportinDocumentCollectionView.reloadData()
            //            self.postStoryTableView.reloadData()
        }
    }
    
    //    func handleTextView(){
    //        if selectedPdfUrl == nil{
    //            textView.isHidden = true
    //            pdfTextImageView.isHidden = false
    //
    //        } else {
    //            textView.isHidden = false
    //            pdfTextImageView.isHidden = true
    //        }
    //    }
    
    
    @objc func pressedBackButton(){
        self.navigationController?.pop(true)
    }
    
    @objc func onclickDocUpload() {
        imageButton.isSelected = false
        thumbnailButton.isSelected = false
        videoButton.isSelected = false
        documentButton.isSelected = true
        uploadTextPdfButton.isSelected = false
        handlesupportintDocCollectionView()
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
    
    @objc func onclickCheckBtn(_ sender: UIButton) {
        if sender.isSelected == true {
            groupContaineView.isHidden = true
            collabrationTableView.isHidden = true
            sender.isSelected = false
        } else {
            groupContaineView.isHidden = false
            collabrationTableView.isHidden = false
            sender.isSelected = true
            
        }
    }
    
    @objc func onClickImagePickerView(_sender: UIButton){
        imageButton.isSelected = true
        thumbnailButton.isSelected = false
        videoButton.isSelected = false
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        handleImageCollectionView()
        handleGetPickerView()
        
        
    }
    
    @objc func onClickThumbnailImagePickerView(){
        imageButton.isSelected = false
        thumbnailButton.isSelected = true
        videoButton.isSelected = false
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        handleThumbnailImageCollectionView()
        handleGetPickerView()
        
    }
    
    @objc func onClickVideoPickerView(){
        imageButton.isSelected = false
        thumbnailButton.isSelected = false
        videoButton.isSelected = true
        documentButton.isSelected = false
        uploadTextPdfButton.isSelected = false
        handleVideoCollectionView()
        handleGetVideoPickerView()
        
    }
    
    @objc func onClickAudioPickerView(){
        handleAudioPicker()
    }
    
    @objc func onClickPostButton(){
        
        //        getDataByCollobrateGroup()
        
        var imageData = [Data]()
        var thumbnailData = [Data]()
        var videoData = [Data]()
        var supportingDocu = [Data]()
        var textData = [Data]()
        //        var pdfData = [Data]()
        
        let memberIDs = "\(memberID)"
        var membersIDs = memberIDs.replacingOccurrences(of: "[", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: "]", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: "\"", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: " ", with: "")
        print("=========membersIDs=========\(membersIDs)")
        
        
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
        
        
        
        for imageURL in selectedImageArray {
            print("URL ------ \(imageURL)")
            if let data = try? Data(contentsOf: imageURL){
                print(data)
                imageData.append(data)
                print("imageData=============\(imageData)")
                
            }
        }
        
        for thumURL in selectedThumbnailArray{
            print("URL ----------\(thumURL)")
            if let data = try? Data(contentsOf: thumURL), let singleImage = UIImage(data: data), let thuData = singleImage.jpegData(compressionQuality: 0.9){
                print(thuData)
                thumbnailData.append(thuData)
                print("thumbnailData=============\(thumbnailData)")
                
            }
        }
        
        for videoURL in selectedVideoArray{
            print("URL -------\(videoURL)")
            if let data = try? Data(contentsOf: videoURL){
                print(data)
                videoData.append(data)
                print("videoData=============\(videoData)")
                
            }
        }
        
        for supportingDocuURL in selectedFileArray{
            print("URL -------\(supportingDocuURL)")
            if let data = try? Data(contentsOf: supportingDocuURL){
                print(data)
                supportingDocu.append(data)
                print("supportingDocu=============\(supportingDocu)")
            }
        }
        
        for textDocuURL in selectedTextDocument{
            print("URL -------\(textDocuURL)")
            if let data = try? Data(contentsOf: textDocuURL){
                print(data)
                textData.append(data)
                print("textDocuURL=============\(textDocuURL)")
            }
        }
        
        let text = textView.text
        
        //
        //        var pdfdata = [Data]()
        //        guard let data = selectedPdfUrl else {
        //            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the Resume.")
        //        }
        //        do {
        //            pdfdata = [try Data(contentsOf: data)]
        //        } catch {}
        
        //        postBlogForm(uploadText: pdfdata, textNote: "", uploadImages: imageData, imageNote: "", uploadVideos: videoData, videoNote: "", supportingDocu: supportingDocu, docNote: "", uploadAudio: "", audioNote: "", blogId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: "", typeStatus: "1", status: "1", header: currentUserLogin.token)
        
        
        
        //        if storyType == "sellStory"{
        //                        sellStoryForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: self.imageTextNote, uploadVideos: videoData, videoNote: self.videoNote, supportingDocu: supportingDocu, docNote: self.supportingDocumentNote, uploadAudio: "", audioNote: self.audioNote , storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: self.thumbnailNote, typeStatus: "1", status: "1", header: currentUserLogin.token)
        //        } else {
        //                        postBlogForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: self.imageTextNote, uploadVideos: videoData, videoNote: self.videoNote, supportingDocu: supportingDocu, docNote: self.supportingDocumentNote, uploadAudio: "", audioNote: self.audioNote, blogId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: self.thumbnailNote, typeStatus: "1", status: "1", header: currentUserLogin.token)
        //        }
        
        
        if groupID == ""{
            if storyType == "sellStory"{
                sellStoryForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "1", status: "1", header: currentUserLogin.token)
            }else {
                postBlogForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, blogId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "1", status: "1", header: currentUserLogin.token)
            }
        }else {
            sellStroryFormWithGroup(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "1", status: "1", collaborateGroupID: groupID, memberID: membersIDs, collaboratedSatus: "1", header: currentUserLogin.token)
            
        }
        
    }
    
    @objc func onClickSaveButton(){
        
        //        getDataByCollobrateGroup()
        
        var imageData = [Data]()
        var thumbnailData = [Data]()
        var videoData = [Data]()
        var supportingDocu = [Data]()
        var textData = [Data]()
        
        
        //        var pdfData = [Data]()
        
        let memberIDs = "\(memberID)"
        var membersIDs = memberIDs.replacingOccurrences(of: "[", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: "]", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: "\"", with: "")
        membersIDs = membersIDs.replacingOccurrences(of: " ", with: "")
        print("=========membersIDs=========\(membersIDs)")
        
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
        
        
        for imageURL in selectedImageArray {
            print("URL ------ \(imageURL)")
            if let data = try? Data(contentsOf: imageURL){
                print(data)
                imageData.append(data)
                print("imageData=============\(imageData)")
                
            }
        }
        
        for thumURL in selectedThumbnailArray{
            print("URL ----------\(thumURL)")
            if let data = try? Data(contentsOf: thumURL), let singleImage = UIImage(data: data), let thuData = singleImage.jpegData(compressionQuality: 0.9){
                print(thuData)
                thumbnailData.append(thuData)
                print("thumbnailData=============\(thumbnailData)")
                
            }
        }
        
        for videoURL in selectedVideoArray{
            print("URL -------\(videoURL)")
            if let data = try? Data(contentsOf: videoURL){
                print(data)
                videoData.append(data)
                print("videoData=============\(videoData)")
                
            }
        }
        
        for supportingDocuURL in selectedFileArray{
            print("URL -------\(supportingDocuURL)")
            if let data = try? Data(contentsOf: supportingDocuURL){
                print(data)
                supportingDocu.append(data)
                print("supportingDocu=============\(supportingDocu)")
            }
        }
        
        for textDocuURL in selectedTextDocument{
            print("URL -------\(textDocuURL)")
            if let data = try? Data(contentsOf: textDocuURL){
                print(data)
                textData.append(data)
                print("textDocuURL=============\(textDocuURL)")
            }
        }
        
        let text = textView.text
        
        //
        //        var pdfdata = [Data]()
        //        guard let data = selectedPdfUrl else {
        //            return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the Resume.")
        //        }
        //        do {
        //            pdfdata = [try Data(contentsOf: data)]
        //        } catch {}
        
        
        
        //        if storyType == "sellStory"{
        //                        sellStoryForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: self.imageTextNote, uploadVideos: videoData, videoNote: self.videoNote, supportingDocu: supportingDocu, docNote: self.supportingDocumentNote, uploadAudio: "", audioNote: self.audioNote, storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: self.thumbnailNote, typeStatus: "0", status: "1", header: currentUserLogin.token)
        //        } else {
        //                        postBlogForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: self.imageTextNote, uploadVideos: videoData, videoNote: self.videoNote, supportingDocu: supportingDocu, docNote: self.supportingDocumentNote, uploadAudio: "", audioNote: self.audioNote, blogId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: self.thumbnailNote, typeStatus: "0", status: "1", header: currentUserLogin.token)
        //        }
        
        
        if groupID == ""{
            if storyType == "sellStory"{
                sellStoryForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "0", status: "1", header: currentUserLogin.token)
            }else {
                postBlogForm(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, blogId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "0", status: "1", header: currentUserLogin.token)
            }
        }else {
            sellStroryFormWithGroup(uploadText: textData, textNote: text!, uploadImages: imageData, imageNote: imgsNote, uploadVideos: videoData, videoNote: videosNotes, supportingDocu: supportingDocu, docNote: supportingNotes, uploadAudio: "", audioNote: audiosNotes, storyId: blogId, uploadThumbnail: thumbnailData, thumbnailNote: thumbImgsNote, typeStatus: "0", status: "1", collaborateGroupID: groupID, memberID: membersIDs, collaboratedSatus: "1", header: currentUserLogin.token)
            
        }
        
    }
    
    @objc func onClickNoteButton(){
        
        let noteVC = AppStoryboard.Journalist.viewController(StoryNoteViewControllerJM.self)
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickThumbnailNoteButton(){
        
        let noteVC = AppStoryboard.Journalist.viewController(ThumbImageNoteViewController.self)
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickVideoNoteButton(){
        
        let noteVC = AppStoryboard.Journalist.viewController(VideoNoteViewController.self)
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func onClickSupportingDocumentNoteButton(){
        
        let noteVC = AppStoryboard.Journalist.viewController(SupportingDocuNoteViewController.self)
        noteVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        noteVC.modalPresentationStyle = .overFullScreen
        noteVC.delegate = self
        self.present(noteVC,animated:true,completion:nil)
        
    }
    
    @objc func clickOnImageDeleteButton(sender : UIButton){
        print("InedPath====\(sender.tag)")
        print("ImageCount==\(selectedImageArray.count)")
        selectedImageArray.remove(at: sender.tag)
        self.imageCollectionView.reloadData()
    }
    
    @objc func clickOnThumbnailDeleteButton(sender : UIButton){
        selectedThumbnailArray.remove(at: sender.tag)
        self.thumbnaimImageCollectionVIew.reloadData()
    }
    
    @objc func clickOnVideoDeleteButton(sender : UIButton){
        selectedVideoArray.remove(at: sender.tag)
        self.videoCollectioView.reloadData()
    }
    
    @objc func clickOnSupportingDocuDelete(sender : UIButton){
        selectedFileArray.remove(at: sender.tag)
        self.supportinDocumentCollectionView.reloadData()
    }
    
    
    
    
    
    
    func postBlogForm(uploadText: [Data], textNote : String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote : String, supportingDocu: [Data], docNote: String, uploadAudio: String, audioNote: String, blogId : String, uploadThumbnail: [Data], thumbnailNote: String, typeStatus: String, status: String,header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.blogFormFill2(uploadTexts: uploadText, textNote: textNote, uploadImages: uploadImages, imageNote: imageNote, uploadVideos: uploadVideos, videoNote: videoNote, supportingDocs: supportingDocu, docNote: docNote, uploadAudio: uploadAudio, audioNote: audioNote, blogId: blogId, uploadThumbnails: uploadThumbnail, thumbnailNote: thumbnailNote, typeStatus: typeStatus, status: status, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200 {
                print("===================\(response)")
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    func sellStoryForm(uploadText: [Data], textNote : String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote : String, supportingDocu: [Data], docNote: String, uploadAudio: String, audioNote: String, storyId : String, uploadThumbnail: [Data], thumbnailNote: String, typeStatus: String, status: String,header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.sellFormFill2(uploadTexts: uploadText, textNote: textNote, uploadImages: uploadImages, imageNote: imageNote, uploadVideos: uploadVideos, videoNote: videoNote, supportingDocs: supportingDocu, docNote: docNote, uploadAudio: uploadAudio, audioNote: audioNote, storyId: storyId, uploadThumbnails: uploadThumbnail, thumbnailNote: thumbnailNote, typeStatus: typeStatus, status: status, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                print("===================\(response)")
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func sellStroryFormWithGroup(uploadText: [Data], textNote : String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote : String, supportingDocu: [Data], docNote: String, uploadAudio: String, audioNote: String, storyId : String, uploadThumbnail: [Data], thumbnailNote: String, typeStatus: String, status: String,collaborateGroupID: String, memberID: String, collaboratedSatus: String, header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.sellFormFill2CollobrationWithGroup(uploadTexts: uploadText, textNote: textNote, uploadImages: uploadImages, imageNote: imageNote, uploadVideos: uploadVideos, videoNote: videoNote, supportingDocs: supportingDocu, docNote: docNote, uploadAudio: uploadAudio, audioNote: audioNote, storyId: storyId, uploadThumbnails: uploadThumbnail, thumbnailNote: thumbnailNote, typeStatus: typeStatus, status: status, collaborationGroupId: collaborateGroupID, memberIDs: memberID, collaboratedStatus: collaboratedSatus, header: header){
            (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                print("===================\(response)")
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getGroupData(searchKey: String, header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.addedGroupList(searchKey: searchKey, Header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.newGroupData = somecategory
                    self.collabrationTableView.reloadData()
                    print("\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
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
    
    
}

extension PostStoryTypeViewControllerJM: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return selectedImageArray.count
        } else if collectionView == thumbnaimImageCollectionVIew{
            return selectedThumbnailArray.count
        } else if collectionView == videoCollectioView {
            return selectedVideoArray.count
        } else {
            return selectedFileArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            let fileURL = selectedImageArray[indexPath.item]
            cell.img.load(url: fileURL)
            
            let fileName = fileURL.absoluteString.fileName()
            let extensionName = fileURL.absoluteString.fileExtension()
            cell.imageName.text = (fileName ?? " ") + "." + (extensionName ?? " ")
            
            cell.noteButton.addTarget(self, action: #selector(onClickNoteButton), for: .touchUpInside)
            print("=========\(selectedImageArray)")
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(clickOnImageDeleteButton(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == thumbnaimImageCollectionVIew {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailImagesCollectionViewCell", for: indexPath) as! ThumbnailImagesCollectionViewCell
            let fileURl = selectedThumbnailArray[indexPath.item]
            cell.thumbNailImage.load(url: fileURl)
            
            let fileName = fileURl.absoluteString.fileName()
            let extensionName = fileURl.absoluteString.fileExtension()
            cell.thumbnailName.text = (fileName ?? " ") + "." + (extensionName ?? " ")
            
            cell.noteButton.addTarget(self, action: #selector(onClickThumbnailNoteButton), for: .touchUpInside)
            print("=========\(selectedThumbnailArray)")
            cell.deleteButton.tag = indexPath.item
            cell.deleteButton.addTarget(self, action: #selector(clickOnThumbnailDeleteButton(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == supportinDocumentCollectionView{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier:"SupportingDocumentCollectionViewCell", for: indexPath) as! SupportingDocumentCollectionViewCell
            cell.pdfThumbnailImage.load(url: selectedFileArray[indexPath.item])
            cell.pdfThumbnailImage.image = #imageLiteral(resourceName: "images")
            
            let  fileURl = selectedFileArray[indexPath.item]
            let fileName = fileURl.absoluteString.fileName()
            let extensionName = fileURl.absoluteString.fileExtension()
            cell.pdfName.text = (fileName ?? " ") + "." + (extensionName ?? " ")
            
            cell.noteButton.addTarget(self, action: #selector(onClickSupportingDocumentNoteButton), for: .touchUpInside)
            print("=========\(selectedFileArray)")
            cell.deletButton.tag = indexPath.item
            cell.deletButton.addTarget(self, action: #selector(clickOnSupportingDocuDelete(sender:)), for: .touchUpInside)
            return cell
        } else if collectionView == videoCollectioView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as! VideosCollectionViewCell
            let fileURl = selectedVideoArray[indexPath.item]
            if let thumbnailImage = getThumbnailImage(forUrl: fileURl) {
                cell.videoImage.image = thumbnailImage
            }
            
            let fileName = fileURl.absoluteString.fileName()
            let extensionName = fileURl.absoluteString.fileExtension()
            cell.videoName.text = (fileName ?? " ") + "." + (extensionName ?? " ")
            
            //            cell.videoImage.load(url: fileURl)
            cell.noteButton.addTarget(self, action: #selector(onClickVideoNoteButton), for: .touchUpInside)
            print("=========\(selectedVideoArray)")
            cell.deletButton.tag = indexPath.item
            cell.deletButton.addTarget(self, action: #selector(clickOnVideoDeleteButton(sender:)), for: .touchUpInside)
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
extension PostStoryTypeViewControllerJM: UIDocumentPickerDelegate {
    
    func openFile() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String,kUTTypeAudio as String], in: .import)
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
extension PostStoryTypeViewControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                //                self.selectedVideoArray.append(mediaURL)
                self.videoCollectioView.reloadData()
                print("==============\(selectedVideoArray.count)")
                print("==============\(selectedVideoArray)")
                
                let asset = AVURLAsset.init(url: mediaURL)
                let durationVideo = asset.duration.seconds
                print("durationVideo=====\(durationVideo)")
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "upload 90 sec video")
                if selectedVideoArray.count == 0{
                    if durationVideo <= 90{
                        selectedVideoArray.append(mediaURL)
                    }else {
                        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "upload 90 sec video")
                        
                    }
                } else {
                    if durationVideo <= 60{
                        selectedVideoArray.append(mediaURL)
                    }else {
                        //                        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Updad 30 sec video")
                        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}




extension PostStoryTypeViewControllerJM: MPMediaPickerControllerDelegate{
    
    func openAudio( _ sender : UIButton) {
        let audiopicker = MPMediaPickerController(mediaTypes: .music)
        //        audiopicker.prompt = "Audio"
        audiopicker.allowsPickingMultipleItems = true
        audiopicker.popoverPresentationController?.sourceView = sender
        audiopicker.delegate = self
        self.present(audiopicker, animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // Get the system music player.
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        musicPlayer.setQueue(with: mediaItemCollection)
        
        mediaPicker.dismiss(animated: true)
        // Begin playback.
        //        musicPlayer.play()
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true)
    }
    
    //    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
    //
    //        guard mediaItemCollection.items.first != nil else {
    //            NSLog("No item selected.")
    //            return
    //        }
    //
    //        //        guard let selectedFileURL = mediaItemCollection.items.first else {
    //        //            print("URL Failed")
    //        //            return
    //        //        }
    //
    //
    //        //
    //        //        self.songUrl = mediaItem.value(forProperty: MPMediaItemPropertyAssetURL) as! NSURL
    //        //        print(songUrl)
    //        //
    //        self.dismiss(animated: true, completion: nil)
    //
    //        //run any code you want once the user has picked their chosen audio
    //    }
    //
    //    func mediaPickerDidCancel(mediaPicker: MPMediaPickerController) {
    //        self.dismiss(animated: true, completion: nil)
    //    }
    
}

extension PostStoryTypeViewControllerJM:sendImageNote{
    func imageNote(note: String) {
        self.imageTextNote.append(note)
        //        self.imageTextNote = note
        print("imageTextNote=========\(imageTextNote)")
    }
}
extension PostStoryTypeViewControllerJM:sendThumbImageNote{
    func thumbImageNote(note: String) {
        self.thumbnailNote.append(note)
        //        self.thumbnailNote = note
        print("thumbnailNote=========\(thumbnailNote)")
    }
}
extension PostStoryTypeViewControllerJM:sendVideoNote{
    func videoNote(note: String) {
        self.videoNote.append(note)
        //        self.videoNote = note
        print("videoNote=========\(videoNote)")
    }
}
extension PostStoryTypeViewControllerJM:sendDocumentNote{
    func documentNote(note: String) {
        self.supportingDocumentNote.append(note)
        //         self.supportingDocumentNote = note
        print("supportingDocumentNote=========\(supportingDocumentNote)")
    }
}


//--------tableView
extension PostStoryTypeViewControllerJM:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(newGroupData.docs.count,4)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollabrationTableViewCell", for: indexPath) as! CollabrationTableViewCell
        let arrdata = newGroupData.docs[indexPath.row]
        cell.groupName.text = arrdata.collaborationGroupName
        let getProfileUrl = "\(self.baseUrl)\(arrdata.userId.profilePic)"
        let url = NSURL(string: getProfileUrl)
        cell.groupImage.sd_setImage(with: url! as URL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrdata = newGroupData.docs[indexPath.row]
        self.groupID = arrdata.id
        //        self.selectedGroup.append(arrdata)
        for memberIDs in arrdata.members.enumerated(){
            if memberIDs.element.status == 1{
                memberID.append(memberIDs.element.journalistId.id)
            }
        }
        print("storyID======\(groupID)")
        print("memberID======\(memberID)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        for item in selectedGroup{
            if item.id == newGroupData.docs[indexPath.row].id{
                if let tempIndex = selectedGroup.firstIndex(of: item){
                    selectedGroup.remove(at: tempIndex)
                }
            }
        }
    }
    
    
}



extension PostStoryTypeViewControllerJM : selectMultipleContentMedia{
    func selectedData(image: [URL]) {
//       self.selectedImageArray.append(contentsOf: image)
//       print("selectedMyContentArray======\(selectedMyContentArray)")    }
    
    if imageButton.isSelected == true {
        self.selectedImageArray.append(contentsOf: image)
        print("selectedImageArray===========\(selectedMyContentArray.count)")
    } else if thumbnailButton.isSelected == true {
        self.selectedThumbnailArray.append(contentsOf: image)
        print("selectedThumbnailArray===========\(selectedThumbnailArray.count)")
    }
 }
}

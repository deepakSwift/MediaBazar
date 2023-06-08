//
//  MyProfileViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

enum ProfileButtonType: String {
    case ButtonProfilePhoto = "ButtonProfilePhoto"
    case ButtonProfileVideo = "ButtonProfileVideo"
}


class MyProfileViewControllerJM: UIViewController {
    
    @IBOutlet weak var myProfileTAbleView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var profileImg: RoundImageView!
    @IBOutlet weak var profileVideo : UIImageView!
    
    @IBOutlet weak var imageChangeButton : UIButton!
    @IBOutlet weak var videoChangeButton : UIButton!
    
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    var myProfileArray = ["Personal Information", "Professional Details", "References", "Previous Work", "Social Media Links"]
    var imagePicker = UIImagePickerController()
    var buttonType: ProfileButtonType = .ButtonProfilePhoto
    var mediaURLs: URL?
    var profileData = profileModal()
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.currentUserLogin = User.loadSavedUser()
        setupUI()
        setupTableView()
        setupButton()
        imagePicker.delegate = self
        getJournalistdata(header: currentUserLogin.token)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.currentUserLogin = User.loadSavedUser()
        getJournalistdata(header: currentUserLogin.token)
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupTableView(){
        self.myProfileTAbleView.dataSource = self
        self.myProfileTAbleView.delegate = self
    }
    
    func fillData(){
        
        let getProfileUrl = "\(self.baseUrl)\(self.profileData.profilePic)"
        let urls = URL(string: (getProfileUrl))
        if let tempUrl = urls {
            profileImg.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "person-1"))
        }
        
        let getUrl = "\(self.baseUrl)\(self.profileData.shortVideo)"
        let url = URL(string: getUrl)
        if let thumbnailImage = getThumbnailImage(forUrl: url!) {
           profileVideo.image = thumbnailImage
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
    
    @IBAction func buttonActionProfilePicture(_ sender: Any) {
        
        buttonType = .ButtonProfilePhoto
        
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
    
    
    @IBAction func buttonActionProfileVideo(_ sender: Any) {
        
        buttonType = .ButtonProfileVideo
        
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
    
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func postNewProfilePic(header: String, profileImageUrl: UIImage){
        Webservices.sharedInstance.updateProfilePic(header: header, profileImageUrl: profileImageUrl){(result,response,message)  in
            CommonClass.hideLoader()
            if result == 200 {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func postNewProfileVideo(profileVideo: Data, header: String){
        Webservices.sharedInstance.updatePofileVideo(header:header , profileVideo: profileVideo){(result,response,message)  in
            CommonClass.hideLoader()
            if result == 200 {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    func getJournalistdata(header: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.journalistProfileData(header: header){(result,response,message) in
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.profileData = somecategory
                    self.myProfileTAbleView.reloadData()
                    self.fillData()
                }
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension MyProfileViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myProfileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCellJM") as! MyProfileTableViewCellJM
        cell.myProfileLabel.text = myProfileArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let personalInfoVC = AppStoryboard.Journalist.viewController(PersonalInformationViewControllerJM.self)
            personalInfoVC.personalInfoData = self.profileData
            personalInfoVC.desgunationID = self.profileData.designationID
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        } else if indexPath.row == 1{
            let personalDetailVC = AppStoryboard.Journalist.viewController(ProfessionalDetailsViewControllerJM.self)
            personalDetailVC.professionalDetailData = self.profileData
            personalDetailVC.categoryData = self.profileData.areaOfInterest
            personalDetailVC.targetData = self.profileData.targetAudience
            self.navigationController?.pushViewController(personalDetailVC, animated: true)
        } else if indexPath.row == 2{
            let referenceVC = AppStoryboard.Journalist.viewController(ReferenceViewControllerJM.self)
            referenceVC.referenceData = self.profileData
            self.navigationController?.pushViewController(referenceVC, animated: true)
        } else if indexPath.row == 3{
            let perviousWorkVC = AppStoryboard.Journalist.viewController(PerviousWorkViewControllerJM.self)
            perviousWorkVC.privoiusWorkArray = self.profileData
            self.navigationController?.pushViewController(perviousWorkVC, animated: true)
        } else{
            let socialMediaVC = AppStoryboard.Journalist.viewController(SocialMediaLinksViewControllerJM.self)
            socialMediaVC.socialMedia = self.profileData
            self.navigationController?.pushViewController(socialMediaVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension MyProfileViewControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
//        imagePicker.mediaTypes = ["public.image", "public.movie"]
//        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//        imagePicker.allowsEditing = true
//        imagePicker.delegate = self
//        self.present(imagePicker, animated: true, completion: nil)
        
        
        if buttonType == .ButtonProfilePhoto{
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            imagePicker.mediaTypes = [ "public.movie"]
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.videoMaximumDuration = 30
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            print("duration\(imagePicker.videoMaximumDuration)")
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if buttonType == .ButtonProfilePhoto {
            
            if let chosenImage = info[.editedImage] as? UIImage{
                profileImg.image = chosenImage
            }else if let chosenImage = info[.originalImage] as? UIImage{
                profileImg.image = chosenImage
            }
            postNewProfilePic(header: currentUserLogin.token, profileImageUrl: self.profileImg.image!)
        } else if buttonType == .ButtonProfileVideo {
            
            if let chosenImage = info[.editedImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let chosenImage = info[.originalImage] as? UIImage{
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }else if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == "public.movie" {
                let mediaURL = info[.mediaURL] as! URL
                self.mediaURLs = mediaURL
//                profileVideo.image = #imageLiteral(resourceName: "VideoThumbnails")
                
                
            }
            
            var videoData = Data()
            guard let data = mediaURLs else {
                return NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please choose the video.")
            }
            do {
                videoData = try Data(contentsOf: data)
            } catch {}
            postNewProfileVideo(profileVideo: videoData, header: currentUserLogin.token)
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




//
//  MyProfileVCViewController.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var buttonActionChangeProfile: UIButton!
    @IBOutlet weak var buttonSocialMediaLink: UIButton!
    @IBOutlet weak var buttonCompanyInfo: UIButton!
    @IBOutlet weak var ProfileContainerView: UIView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonPersonalInfo: UIButton!
    
    var imagePicker = UIImagePickerController()
    var profileData = CompanyProfileModel()
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currenUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        self.currenUserLogin = User.loadSavedUser()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getMediaHousedata(header: self.currenUserLogin.mediahouseToken)
    }

    func setupData() {
        //--setProfilePicture
        let thumbnailUrl = "\(self.baseUrl)\(self.profileData.logo)"
        let urls = URL(string: (thumbnailUrl))
        if let tempUrl = urls {
            imageViewSetImg.sd_setImage(with: tempUrl as URL, placeholderImage: #imageLiteral(resourceName: "person-1"))
        }
        
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        imageViewSetImg.applyshadowWithCorner(containerView: ProfileContainerView, cornerRadious: 45)
        imageViewSetImg.clipsToBounds = true
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonCompanyInfo.addTarget(self, action: #selector(companyInfoButtonPressed), for: .touchUpInside)
        buttonSocialMediaLink.addTarget(self, action: #selector(socialMediaButtonPressed), for: .touchUpInside)
        buttonActionChangeProfile.addTarget(self, action: #selector(onClickUpdateLogo), for: .touchUpInside)
        buttonPersonalInfo.addTarget(self, action: #selector(onClickPersonalInfo), for: .touchUpInside)
    }

    @objc func backButtonPressed() {
       self.navigationController?.popViewController(animated: true)
    }
    
    @objc func companyInfoButtonPressed() {
        let compnyInfoVC = AppStoryboard.MediaHouse.viewController(CompanyInfoEditVC.self)
         //compnyInfoVC.getCompanyData = profileData
        compnyInfoVC.getCompanyData = profileData
        self.navigationController?.pushViewController(compnyInfoVC, animated: true)
    }
    
    @objc func socialMediaButtonPressed() {
        let companyInfoVC = AppStoryboard.MediaHouse.viewController(SocialMediaLinksEditVC.self)
        companyInfoVC.Facebook = profileData.facebookLink
        companyInfoVC.Snapchat = profileData.snapChatLink
        companyInfoVC.Instagram = profileData.instagramLink
        companyInfoVC.linkedIn = profileData.linkedinLink
        companyInfoVC.Twitter = profileData.twitterLink
        companyInfoVC.Youtube = profileData.youtubeLink
        
        self.navigationController?.pushViewController(companyInfoVC, animated: true)
    }
    
    @objc func onClickPersonalInfo() {
        let compnyInfoVC = AppStoryboard.MediaHouse.viewController(PersonalInfoEditVC.self)
         compnyInfoVC.getCompanyData = profileData
        print("name=================\(profileData.mediahouseTypeId.mediahouseTypeName)")
        print("id=================\(profileData.mediahouseTypeId.Id)")
        self.navigationController?.pushViewController(compnyInfoVC, animated: true)
    }
    
    @objc func onClickUpdateLogo() {
        
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
    
    //------GetMediaHouseProfile------
    func getMediaHousedata(header: String){
        CommonClass.showLoader()
        WebService3.sharedInstance.mediaHouseProfileData(header: header){(result,response,message) in
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.profileData = somecategory
                }
                self.setupData()
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func updateMediaLogo(profilePic: UIImage,header: String){
        CommonClass.showLoader()
           WebService3.sharedInstance.updateLogo(header: header, profileImageUrl: profilePic){(result,response,message)  in
                CommonClass.hideLoader()
               if result == 200 {
                   NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
               }else {
                   NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
               }
           }
       }
    
}

//------- Image Picker Extension ------
extension MyProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
            if let chosenImage = info[.editedImage] as? UIImage{
                imageViewSetImg.image = chosenImage
            }else if let chosenImage = info[.originalImage] as? UIImage{
                imageViewSetImg.image = chosenImage
            }
        updateMediaLogo(profilePic: self.imageViewSetImg.image!, header: self.currenUserLogin.mediahouseToken)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




//
//  CreateCollaborationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 07/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CreateCollaborationViewControllerJM: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var groupDetailTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var groupDetailButton : UIButton!
    @IBOutlet weak var groupImageView : UIImageView!
    @IBOutlet weak var uploadGroupImageButton : UIButton!
    @IBOutlet weak var groupNameLabel : UITextField!
    
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    var newGroupData = newRequestModal()
    var selectedUser = [invitejournalistListModdal]()
    var baseUrl = "https://apimediaprod.5wh.com/"
    var userID = [String]()
    var imagePicker = UIImagePickerController()
    var selectedURl: URL?
    var currentUserLogin : User!
    var storyTimeArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupButton()
        setupTableView()
        setUpdata()
        imagePicker.delegate = self
        self.currentUserLogin = User.loadSavedUser()
        
        
    }
    
    func setupTableView(){
        self.groupDetailTableView.dataSource = self
        self.groupDetailTableView.delegate = self
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        groupDetailButton.addTarget(self, action: #selector(pressedGroupButtonButton), for: .touchUpInside)
        uploadGroupImageButton.addTarget(self, action: #selector(clickOnUploadImageButton), for: .touchUpInside)
    }
    
    func calculateTime() {
        
        var tempTimeArray = [String]()
        for data in newGroupData.docs.enumerated() {
            let tempData = data.element.createdAt
            tempTimeArray.append(tempData)
        }
        
        for data1 in tempTimeArray.enumerated() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let formatedStartDate = dateFormatter.date(from: data1.element)
            let currentDate = Date()
            let dayCount = Set<Calendar.Component>([.day])
            let hourCount = Set<Calendar.Component>([.hour])
            let differenceOfDay = Calendar.current.dateComponents(dayCount, from: formatedStartDate!, to: currentDate)
            let differenceOfTimes = Calendar.current.dateComponents(hourCount, from: formatedStartDate!, to: currentDate)
            if differenceOfDay.day == 0 {
                storyTimeArray.append("\(differenceOfTimes.hour!) hr ago")
            } else {
                storyTimeArray.append("\(differenceOfDay.day!) day ago")
            }
        }
    }
    
    func setUpdata(){
        
//        let getProfileUrl = "\(self.baseUrl)\(selectedURl)"
//        let url = NSURL(string: getProfileUrl)
//        self.groupImageView.sd_setImage(with: url! as URL)
        
        for selectedUserID in selectedUser.enumerated(){
            let temData = selectedUserID.element.id
            userID.append(temData)
            
            print("userID=========\(userID)")
            
        }
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnUploadImageButton(){
        handleGetPickerView()
    }
    
    @objc func pressedGroupButtonButton(){
        //        let journalistIDDataId = userID.joined(separator: ",")
        
        let journalists = "\(userID)"
        var journalistsid = journalists.replacingOccurrences(of: "[", with: "")
        journalistsid = journalistsid.replacingOccurrences(of: "]", with: "")
        journalistsid = journalistsid.replacingOccurrences(of: "\"", with: "")
        journalistsid = journalistsid.replacingOccurrences(of: " ", with: "")
        
        print("=========journalistsid=========\(journalistsid)")
        
        guard let groupName = groupNameLabel.text, groupName != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the group name.")
            return
        }
        
        var imageData = Data()
        if let url = selectedURl{
            imageData = try! Data(contentsOf: url)
            
            print("selectedURl====\(selectedURl)")
            print(" imageData======\(imageData)")
        }
                
        
       createGroup(jouranalistId: journalistsid, groupName: groupNameLabel.text!, groupProfle: imageData, header: currentUserLogin.token)
        
        
    
        //        let detailVC = AppStoryboard.Journalist.viewController(ColloborationGroupDetailControllerJM.self)
        //        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func handleGetPickerView(){
        
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
    
    
    
    
    func createGroup(jouranalistId : String, groupName : String, groupProfle : Data?, header : String){
        Webservices.sharedInstance.createGroup(journalistID: jouranalistId, groupName: groupName, groupProfile: groupProfle, header: header){
            (result,message,response) in
            if result == 200{
                    if let somecategory = response{
                        self.newGroupData = somecategory
                        self.groupDetailTableView.reloadData()
                        self.calculateTime()
                        print("\(somecategory)")
                    }
                    else{
                        
                    }
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

extension CreateCollaborationViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCollaborationTableViewCellJM") as! CreateCollaborationTableViewCellJM
        let arrdata = selectedUser[indexPath.row]
        cell.nameLabel.text = ("\(arrdata.firstName) \(arrdata.lastName)")
        cell.sateLabel.text = ("\(arrdata.langCode) | \(arrdata.state.stateName)")
        let getProfileUrl = "\(self.baseUrl)\(arrdata.profilePic)"
        let url = NSURL(string: getProfileUrl)
        cell.userImage.sd_setImage(with: url! as URL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}


extension CreateCollaborationViewControllerJM: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            groupImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
            groupImageView.image = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            if let imageUrl = saveImage(pickedImage: selectedImage) {
                self.selectedURl = imageUrl
                
                print("selectedURl=======\(selectedURl ?? nil)")
            }
            print("selectedimage")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

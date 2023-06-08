//
//  MediaHouseAssignmentViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MediaHouseAssignmentViewControllerJM: UIViewController {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var topView : UIView!
    
    @IBOutlet weak var submitBUtton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var assignmentTitleLabel : UILabel!
    @IBOutlet weak var assignmentDescription : UILabel!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var journaistImage : UIImageView!
    
    //    let arrdata = searchEditorData.docs[indexPath.row]
    
    var assignmentDetailData = storyListModal()
    var currentUserLogin : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupButton()
        setUpData()
        self.currentUserLogin = User.loadSavedUser()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        containerView.applyShadow()
        textView.applyShadow()
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(submitBUtton, borderColor: .clear, borderWidth: 0, cornerRadius: 10)
        
    }
    
    func setUpData(){
        
        self.journalistName.text = ("\(assignmentDetailData.mediaHouseID.firstName) \(assignmentDetailData.mediaHouseID.middleName) \(assignmentDetailData.mediaHouseID.lastName)")
        self.assignmentTitleLabel.text = assignmentDetailData.assignmentTitle
        self.assignmentDescription.text = assignmentDetailData.assignmentDescription
        self.languageLabel.text = ("\(assignmentDetailData.langCode) | \(assignmentDetailData.country.name)")
        self.priceLabel.text = ("$ \(assignmentDetailData.price)")
        let url = NSURL(string: assignmentDetailData.mediaHouseID.profilePic)
        self.journaistImage.sd_setImage(with: url! as URL)
        
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        submitBUtton.addTarget(self, action: #selector(clickOnSubmitButton), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnSubmitButton(){
        
        guard let replay = textView.text, replay != "" else {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter comment")
            return
        }
        
        assignmentReplay(assignmentId: assignmentDetailData.id, assignmentReplay: textView.text!, header: currentUserLogin.token)

    }
    
    func assignmentReplay(assignmentId: String, assignmentReplay: String, header: String){
        Webservices.sharedInstance.replayAssignment(assignmentId: assignmentId, assignmentReplay: assignmentReplay, header: header){
            (result,message,response) in
            
            if result == 200{
                //                print(response)
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

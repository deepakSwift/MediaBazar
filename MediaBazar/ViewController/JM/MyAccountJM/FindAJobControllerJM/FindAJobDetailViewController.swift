//
//  FindAJobDetailViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FindAJobDetailViewController: UIViewController {
    
    @IBOutlet weak var jobDetailTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var functionAres = ""
    var currentUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    var detailData = storyListModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpButton()
        setUpUI()
        setUpData()
        self.currentUserLogin = User.loadSavedUser()
        self.jobDetailTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.jobDetailTableView.dataSource = self
        self.jobDetailTableView.delegate = self
    }
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBAckButton), for: .touchUpInside)
    }
    
    func setUpData(){
        for data1 in detailData.jobFunctionalAreaId.enumerated(){
            let tempData1 = data1.element.jobFunctionalAreaName
            functionAres = tempData1

        }        
    }
    
    @objc func clickOnBAckButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnAppliedButton(){
        appliedJob(jobID: detailData.id, header: currentUserLogin.token)
    }
    
    func appliedJob(jobID : String, header : String){
        Webservices.sharedInstance.postAppliedJob(jobId: jobID, header: header){
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

extension FindAJobDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindAJobDetailTableViewCell" ) as! FindAJobDetailTableViewCell
//        let arrdata = detailData.docs[indexPath.row]
        cell.namelabel.text = ("\(detailData.mediaHouseID.firstName) \(detailData.mediaHouseID.middleName) \(detailData.mediaHouseID.lastName)")
        cell.jobTitlet.text = detailData.mediaHouseID.organizationName
        cell.workExpLabel.text = ("\(detailData.workExperience) year")
        cell.cityLabel.text = detailData.state.stateName
        cell.salleryLabel.text = detailData.expectedSalary
        cell.jobDescriLabel.text = detailData.jobDescription
        cell.roleLabel.text = detailData.jobRoleId.jobRoleName
        cell.employmentTimeLabel.text = detailData.employementType
        cell.roleCategory.text = detailData.jobCategoryId.jobCategoryName
        cell.underGradutionLabel.text = detailData.jobQualificationId.jobQualificationName
        cell.postGraduationLabel.text = "Post Graducation not required"
        cell.doctorate.text = "Any Doctorate in any specialisation"
        
        let getProfileUrl = "\(self.baseUrl)\(detailData.mediaHouseID.profilePic)"
        let url = NSURL(string: getProfileUrl)
        cell.profileImage.sd_setImage(with: url! as URL)
        cell.keywordLabel.text = detailData.jobKeywordName.joined(separator: ", ")
        cell.fuctionalAreaLabel.text = functionAres
        cell.applyButton.addTarget(self, action: #selector(clickOnAppliedButton), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    
    
}

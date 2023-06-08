//
//  PersonalInformation4ViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PersonalInformation4ViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var submitInformationtableView : UITableView!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var textViewSuggetion: UITextView!
    
    //    var benefitArray = User()
    //    var benefitArray = [BenefitModel]()
    var adminBenefitsData = [DesignationModel]()
    var amdminBenefitsArray = [String]()
    var journalistId = ""
    var currenUserLogin : User!
    
    var signupData = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        getAdminBenefits()
        
        
    }
    
    func setupButton(){
        submitButton.addTarget(self, action: #selector(onclickSubmitButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
    }
    
    func setupUI(){
        self.submitInformationtableView.dataSource = self
        self.submitInformationtableView.delegate = self
        submitInformationtableView.rowHeight = UITableView.automaticDimension
        submitInformationtableView.estimatedRowHeight = 1000
        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(textViewSuggetion, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeightConstraints.constant = self.submitInformationtableView.contentSize.height
    }
    
    @objc func onclickSubmitButton(){
        
        let langData = "\(amdminBenefitsArray)"
        var adminBenefits = langData.replacingOccurrences(of: "[", with: "")
        adminBenefits = adminBenefits.replacingOccurrences(of: "]", with: "")
        adminBenefits = adminBenefits.replacingOccurrences(of: "\"", with: "")
        adminBenefits = adminBenefits.replacingOccurrences(of: " ", with: "")
        print("=========adminBenefits=========\(adminBenefits)")
        
        if isValidate() {
            getbenefit(platformBenefits: adminBenefits, journalistId: journalistId, platformSuggestion: textViewSuggetion.text!, stepCount: "6")
        }
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getbenefit(platformBenefits: String, journalistId: String, platformSuggestion: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.benefitData(platformBenefits: platformBenefits, journalistId: journalistId, platformSuggestion: platformSuggestion, stepCount: stepCount){(result,response,message) in
            print(result)
            CommonClass.hideLoader()
            if result == 200 {
                if let somecategory1 = response{
                    self.signupData = somecategory1
                    //                    self.benefitArray = somecategory1
                    //                    self.benefitArray.removeAll()
                    //                    self.benefitArray.append(contentsOf: somecategory1)
//                    let registrationVC = AppStoryboard.PreLogin.viewController(SplashScreenViewController.self)
//                    registrationVC.jourTokenByRegister = self.signupData.token
//                    registrationVC.jourTokenFlowSet = "flowSetByApproved"
//                    registrationVC.newUserSignUp = "membershipPlan"
//                    self.navigationController?.pushViewController(registrationVC, animated: true)
                    
                    let registratinFeeVeiw = AppStoryboard.PreLogin.viewController(RegistrationPlanViewController.self)
                    registratinFeeVeiw.jourTokenByRegister = self.signupData.token
                    registratinFeeVeiw.jourTokenFlowSet = "flowSetByApproved"
                    registratinFeeVeiw.newUserSignUp = "membershipPlan"
                    self.navigationController?.pushViewController(registratinFeeVeiw, animated: true)

                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func getAdminBenefits(){
        CommonClass.showLoader()
        Webservice.sharedInstance.adminBenefitsData { (result, response, message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.adminBenefitsData.removeAll()
                    self.adminBenefitsData.append(contentsOf: somecategory)
                    self.submitInformationtableView.reloadData()
                    self.viewWillLayoutSubviews()
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    //------TextFieldValidation-----
    func isValidate()-> Bool {
        
        if amdminBenefitsArray.count == 0 {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please select the benefits.")
            return false
        }
        return true
    }
}

extension PersonalInformation4ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminBenefitsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInformation4TableViewCell") as! PersonalInformation4TableViewCell
        cell.labelBenefits.text = adminBenefitsData[indexPath.row].benifitName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        amdminBenefitsArray.append(adminBenefitsData[indexPath.row].adminBenifitID)
        print(amdminBenefitsArray)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let id = adminBenefitsData[indexPath.row].adminBenifitID
        amdminBenefitsArray.removeAll(where: { $0 == id })
        print(amdminBenefitsArray)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    
}

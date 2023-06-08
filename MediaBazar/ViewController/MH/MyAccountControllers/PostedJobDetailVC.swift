//
//  PostedJobDetailVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PostedJobDetailVC: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonEdit: UIButton!
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelDisclosed: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonViewDetails: UIButton!
    @IBOutlet weak var labelDaysCount: UILabel!
    
    @IBOutlet weak var labeldescription: UILabel!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var labelFunctionalArea: UILabel!
    @IBOutlet weak var labelEmployementType: UILabel!
    @IBOutlet weak var labelRoleCetegory: UILabel!
    @IBOutlet weak var labelEducation: UILabel!
    
    var data = GetJobDetailsModel()
    var daysCount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButonPressed), for: .touchUpInside)
        buttonEdit.addTarget(self, action: #selector(editButonPressed), for: .touchUpInside)
        buttonEdit.makeRoundCorner(20)
    }
   
    func setupData() {
        labelTitle.text = data.jobKeywordName[0]
        labelSubtitle.text = data.mediahouseId.organizationName
        labelLocation.text = data.city.name
        labelYear.text = data.workExperience
        labelDisclosed.text = data.expectedSalary
        labelDaysCount.text = daysCount
        
        labeldescription.text = data.jobDescription
        labelRoleCetegory.text = data.jobCategoryId.jobCategoryName
        labelEducation.text = data.jobQualificationId.jobQualificationName
        labelEmployementType.text = data.employementType
        labelRole.text = data.jobRoleId.jobRoleName
        if data.jobFunctionalAreaId.count != 0 {
            labelFunctionalArea.text = data.jobFunctionalAreaId[0].jobFunctionalAreaName
        }
    }
    
    @objc func backButonPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func editButonPressed() {
        let editVC = AppStoryboard.MediaHouse.viewController(EditJobVC.self)
        editVC.getPreviousData = data
        self.navigationController?.pushViewController(editVC, animated: true)
    }

}

//
//  PersonalInformation2Controller.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PersonalInformation2Controller: UIViewController {
    
    @IBOutlet weak var personalInfo2TableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()

        // Do any additional setup after loading the view.
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onclickContinueButton), for: .touchUpInside)
    }
    
    func setupUI(){
        self.personalInfo2TableView.dataSource = self
        self.personalInfo2TableView.delegate = self
        personalInfo2TableView.rowHeight = UITableView.automaticDimension
        personalInfo2TableView.estimatedRowHeight = 1000
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    @objc func onclickContinueButton(){
        let personalInfo3VC = AppStoryboard.PreLogin.viewController(PersonalInformation3Controller.self)
        self.navigationController?.pushViewController(personalInfo3VC, animated: true)
    }
}

extension PersonalInformation2Controller: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInformation2TableViewCell") as! PersonalInformation2TableViewCell
        return cell
    }

}

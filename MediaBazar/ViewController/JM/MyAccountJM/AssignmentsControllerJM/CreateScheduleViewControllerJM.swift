//
//  CreateScheduleViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CreateScheduleViewControllerJM: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var createButton : UIButton!
    @IBOutlet weak var createScheduleTAbleView : UITableView!
    
    var datetextField = UITextField()
    var datePickerView : UIDatePicker = UIDatePicker()
    var dateD: Date?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupBUtton()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        self.createScheduleTAbleView.dataSource = self
        self.createScheduleTAbleView.delegate = self
        createScheduleTAbleView.rowHeight = UITableView.automaticDimension
        createScheduleTAbleView.estimatedRowHeight = 1000
        
    }
    
    func setupUI(){
        topView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(createButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func setupBUtton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(onClickCreateButton), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickCreateButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker ){
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateD = datePicker.date
        datetextField.text = dateFormatter.string(from: datePicker.date)
    }

    
}

extension CreateScheduleViewControllerJM : UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreateScheduleTableViewCellJM") as! CreateScheduleTableViewCellJM
        
        self.datetextField = cell.dateTextField
        self.datetextField.delegate = self
        
        self.datetextField.inputView = self.datePickerView
        datePickerView = UIDatePicker()
        
        datePickerView.datePickerMode = .date
        datePickerView.minimumDate = Date()
        cell.dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CreateScheduleViewControllerJM.dateChanged(datePicker:)), for: .valueChanged)
        datePickerView.minimumDate = Date()

        cell.delegate = self
        return cell
    }    
    
}


extension CreateScheduleViewControllerJM : DataFromCellToMainController{
    func updateTable() {
        self.createScheduleTAbleView.reloadData()
    }
}


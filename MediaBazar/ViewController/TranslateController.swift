//
//  TranslateController.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class TranslateController: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var translateTableView : UITableView!
    @IBOutlet weak var submitButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Coming soon...")
    }
    
    
    func setupUI(){
        topView.applyShadow()
        self.translateTableView.dataSource = self
        self.translateTableView.delegate = self
        translateTableView.rowHeight = UITableView.automaticDimension
        translateTableView.estimatedRowHeight = 1000
        CommonClass.makeViewCircularWithCornerRadius(submitButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    func setupButton(){
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    @objc func submitButtonPressed(){
        let paymentVC = AppStoryboard.PreLogin.viewController(PaymantMethodViewController.self)
        paymentVC.fromTranslate = "Translate"
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    
    
}

extension TranslateController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TranslateTableViewCell") as! TranslateTableViewCell
        cell.delegate = self
        return cell
    }
}


extension TranslateController : DataFromCellToMainController{
    func backButtonPressed() {}
    
    func updateTable() {
        self.translateTableView.reloadData()
    }
    
    
}

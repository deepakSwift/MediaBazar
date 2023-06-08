
//
//  viewFeedbackAlertVC.swift
//  MediaBazar
//
//  Created by Sagar Gupta on 15/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class viewFeedbackAlertVC: UIViewController {
    
    @IBOutlet weak var feedbackAlertView: UIView!
    @IBOutlet weak var popUpDismis: UIButton!
    @IBOutlet weak var feedbackTableView: UITableView!

    var enquiryDetail = [EnquiryDocsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        feedbackTableView.tableFooterView = UIView()
    }
    
    func setUpButton(){
        popUpDismis.addTarget(self, action: #selector(popUpDismisTapped), for: .touchUpInside)
    }
    @objc func popUpDismisTapped(){
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension viewFeedbackAlertVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enquiryDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewFeedbackTableViewCell") as! viewFeedbackTableViewCell
        cell.feedbackAlertName.text = enquiryDetail[indexPath.row].enquiryDescription
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

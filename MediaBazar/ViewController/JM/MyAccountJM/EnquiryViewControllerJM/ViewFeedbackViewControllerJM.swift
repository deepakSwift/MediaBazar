//
//  ViewFeedbackViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ViewFeedbackViewControllerJM: UIViewController {
    
    
    @IBOutlet weak var feedbackAlertView: UIView!
    @IBOutlet weak var popUpDismis: UIButton!
    
    var enquiryDetail = [EnquiryDocsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        
        
    }
    func setUpButton(){
        popUpDismis.addTarget(self, action: #selector(popUpDismisTapped), for: .touchUpInside)
    }
    @objc func popUpDismisTapped(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ViewFeedbackViewControllerJM: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewFeedbackTableViewCellJM") as! ViewFeedbackTableViewCellJM
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

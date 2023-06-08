//
//  ReporterAssignmentDetailsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 17/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ReporterAssignmentDetailsVC: UIViewController {

    @IBOutlet weak var imageViewSetImg : UIImageView!
    @IBOutlet weak var labelName : UILabel!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelTime : UILabel!
    @IBOutlet weak var labelDescription : UILabel!
    @IBOutlet weak var buttonBack : UIButton!
    @IBOutlet weak var buttonPay : UIButton!
    @IBOutlet weak var labeEeventTime : UILabel!
    
    var name = ""
    var getTitle = ""
    var time = ""
    var getDescription = ""
    var imgUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        buttonPay.makeRoundCorner(8)
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
   
    
    
    func setupData() {
        if let profileUrls = NSURL(string: (imgUrl)) {
           imageViewSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        labelName.text = name
        labelTitle.text = getTitle
        labelDescription.text = getDescription
        labelTime.text = time
    }
    
    @objc func onClickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

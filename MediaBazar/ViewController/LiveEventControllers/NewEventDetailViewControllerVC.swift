//
//  NewEventDetailViewControllerVC.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NewEventDetailViewControllerVC: UIViewController {
    
    @IBOutlet weak var ButtonBack: UIButton!
    @IBOutlet weak var labelProfilename: UILabel!
    @IBOutlet weak var profileSetImg: RoundImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTimeAddress: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTimeMessage: UILabel!
    @IBOutlet weak var labelboldTitle: UILabel!
    @IBOutlet weak var buttonShareds: UIButton!
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var dateAndTimeLabel : UILabel!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var headline = ""
    var time = ""
    var date = ""
    var country = ""
    var currency = ""
    var price = ""
    var descri = ""
    var name = ""
    var profileImage = ""
    var assignmentID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setUpData()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        CommonClass.makeViewCircularWithCornerRadius(buttonPay, borderColor: .clear, borderWidth: 0, cornerRadius: 20)

    }
    
    func setupButton() {
        ButtonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonPay.addTarget(self, action: #selector(onClickPayButton), for: .touchUpInside)
    }
    
    func setUpData(){
        
        let getProfileUrl = "\(self.baseUrl)\(profileImage)"
        if let profileUrls = NSURL(string: (getProfileUrl)) {
            profileSetImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
        }
        self.labelTitle.text = self.headline
        self.labelProfilename.text = self.name
        self.labelTimeAddress.text = "\(self.time) | \(self.date) | \(self.country)"
        self.labelPrice.text = "\(currency) \(price)"
        self.labelDescription.text = descri
        self.labelboldTitle.text = "You can watch the Live Conference Cover by \(name)"
        self.dateAndTimeLabel.text = "\(self.date), \(self.time)"
        self.labelTimeMessage.text = "you can pay on before \(self.date), \(self.time) to watch this video"
        self.buttonPay.setTitle("PAY  \(self.currency) \(self.price)", for: .normal)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickPayButton(){
        let payMethodVC = AppStoryboard.MediaHouse.viewController(PaymentMethodsEventViewController.self)
        payMethodVC.assignmentIds = assignmentID
        payMethodVC.price = price
        payMethodVC.currency = currency
        self.navigationController?.pushViewController(payMethodVC, animated: true)
    }
}

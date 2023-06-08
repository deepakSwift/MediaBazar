//
//  SocialMediaLinksTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textFieldFacebook: UITextField!
    @IBOutlet weak var textFieldTwitter: UITextField!
    @IBOutlet weak var textFieldLinkedInn: UITextField!
    @IBOutlet weak var textFieldSnapchat: UITextField!
    @IBOutlet weak var textFieldInstagram: UITextField!
    @IBOutlet weak var textFieldYoutube: UITextField!
    @IBOutlet weak var butonPrivatePolicy: UIButton!
    @IBOutlet weak var customerButton : UIButton!
    @IBOutlet weak var privacyButton : UIButton!
    @IBOutlet weak var buttonTermsAndCondition : UIButton!
    
    @IBOutlet weak var contractorButton1 : UIButton!
    @IBOutlet weak var ontractorButton2 : UIButton!
    @IBOutlet weak var ethicsButton : UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

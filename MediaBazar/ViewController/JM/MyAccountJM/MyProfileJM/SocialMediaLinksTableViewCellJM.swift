//
//  SocialMediaLinksTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var facebookLinkTextField : UITextField!
    @IBOutlet weak var twitterLinkTextFiled : UITextField!
    @IBOutlet weak var linkedInLinkTextField : UITextField!
    @IBOutlet weak var snapchatLinkTextField : UITextField!
    @IBOutlet weak var instagramLinkTextField : UITextField!
    @IBOutlet weak var youtubeLinkTextField : UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

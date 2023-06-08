//
//  JournalistProfileTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 10/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var profileVideo : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var userTypeLabel : UILabel!
    @IBOutlet weak var lastNameLabel : UILabel!
    @IBOutlet weak var averageRateingLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var storyDescri : UILabel!
    @IBOutlet weak var targetAudienceLAbel : UILabel!
    @IBOutlet weak var areaOfInterestLabel : UILabel!
    @IBOutlet weak var totalAssignment : UILabel!
    
    @IBOutlet weak var faceBookButton : UIButton!
    @IBOutlet weak var twitterButton : UIButton!
    @IBOutlet weak var linkedInButton : UIButton!
    @IBOutlet weak var snapchatButton : UIButton!
    @IBOutlet weak var instagramButton : UIButton!
    @IBOutlet weak var youtubeButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

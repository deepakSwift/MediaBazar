//
//  EventsTableViewCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var labelProfileName: UILabel!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var imageViewSetProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

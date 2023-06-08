//
//  ReviewsTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 14/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var reviewDetail : UILabel!
    @IBOutlet weak var rattingLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

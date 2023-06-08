//
//  ReviewHeadingTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 14/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ReviewHeadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rattingLabel : UILabel!
    @IBOutlet weak var noOfReviewLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

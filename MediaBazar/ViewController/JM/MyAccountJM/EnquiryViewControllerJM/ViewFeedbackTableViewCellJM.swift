//
//  ViewFeedbackTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ViewFeedbackTableViewCellJM: UITableViewCell {

        @IBOutlet weak var feedbackAlertView1: UIView!
        @IBOutlet weak var feedbackAlertName: UILabel!
        @IBOutlet weak var feedbackAlertDetail: UILabel!
        @IBOutlet weak var setImageView: UIImage!

        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

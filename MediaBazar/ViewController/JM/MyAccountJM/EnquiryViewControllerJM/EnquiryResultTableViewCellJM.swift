//
//  EnquiryResultTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryResultTableViewCellJM: UITableViewCell {

        @IBOutlet weak var resultImg: UIImageView!
        @IBOutlet weak var resultName: UILabel!
        @IBOutlet weak var resultViewFeedback: UIButton!
        @IBOutlet weak var resultDetail: UILabel!
        @IBOutlet weak var resultCellView: UIView!

        override func awakeFromNib() {
            super.awakeFromNib()
           
        }
        
        

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }

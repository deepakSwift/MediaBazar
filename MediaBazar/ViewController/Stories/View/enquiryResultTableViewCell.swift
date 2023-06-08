//
//  enquiryResultTableViewCell.swift
//  MediaBazar
//
//  Created by Sagar Gupta on 15/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class enquiryResultTableViewCell: UITableViewCell {
    
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

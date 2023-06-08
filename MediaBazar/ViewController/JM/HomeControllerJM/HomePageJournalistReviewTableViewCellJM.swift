//
//  HomePageJournalistReviewTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 09/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class HomePageJournalistReviewTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


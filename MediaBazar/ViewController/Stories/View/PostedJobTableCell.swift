//
//  PostedJobTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PostedJobTableCell: UITableViewCell {
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelDisclosed: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonViewDetails: UIButton!
    @IBOutlet weak var labelDaysCount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

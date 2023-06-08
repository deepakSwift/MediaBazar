//
//  JournalistStoryHeadingTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 10/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistStoryHeadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView : UIView!
    @IBOutlet weak var totalStoryLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

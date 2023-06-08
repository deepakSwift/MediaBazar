//
//  SearchProfileTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SearchProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var buttonViewProfile: UIButton!
    
    @IBOutlet weak var buttonChat: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

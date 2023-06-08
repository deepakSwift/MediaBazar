//
//  CustomKeywordTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 28/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CustomKeywordTableCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var uiImageCheck : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        uiImageCheck.image = selected ? #imageLiteral(resourceName: "Group 184") : #imageLiteral(resourceName: "Group 184-2")
        // Configure the view for the selected state
    }
    
}

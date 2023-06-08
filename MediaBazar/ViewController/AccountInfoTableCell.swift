//
//  AccountInfoTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AccountInfoTableCell: UITableViewCell {
    
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var imageViewSetImg: UIImageView!
    
    @IBOutlet weak var cellView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

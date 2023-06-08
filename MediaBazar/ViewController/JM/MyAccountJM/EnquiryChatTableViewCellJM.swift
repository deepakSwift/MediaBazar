//
//  EnquiryChatTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryChatTableViewCellJM: UITableViewCell {

        @IBOutlet weak var mediaImage : UIImageView!
        @IBOutlet weak var nameLabel : UILabel!
        @IBOutlet weak var messageLabel : UILabel!
        @IBOutlet weak var timeLabel : UILabel!

        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
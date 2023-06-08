//
//  GroupChatTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class GroupChatTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var groupImage : UIImageView!
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

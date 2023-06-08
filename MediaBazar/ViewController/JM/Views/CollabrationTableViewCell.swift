//
//  CollabrationTableViewCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CollabrationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupImage : UIImageView!
    @IBOutlet weak var selectedImageView : UIImageView!
    @IBOutlet weak var groupName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedImageView.image = selected ? #imageLiteral(resourceName: "Group 184") : #imageLiteral(resourceName: "Group 184-2")


        // Configure the view for the selected state
    }
    
}

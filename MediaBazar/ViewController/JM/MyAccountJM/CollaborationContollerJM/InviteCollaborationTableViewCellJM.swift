//
//  InviteCollaborationTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class InviteCollaborationTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var stateLabel : UILabel!
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

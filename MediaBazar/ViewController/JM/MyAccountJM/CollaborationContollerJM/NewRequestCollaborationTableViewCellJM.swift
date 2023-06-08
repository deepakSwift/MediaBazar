//
//  NewRequestCollaborationTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NewRequestCollaborationTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var groupname : UILabel!
    @IBOutlet weak var crealteLabel : UILabel!
    @IBOutlet weak var time : UILabel!
    @IBOutlet weak var profilePic : UIImageView!
    @IBOutlet weak var acceptButtob : UIButton!
    @IBOutlet weak var rejectButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

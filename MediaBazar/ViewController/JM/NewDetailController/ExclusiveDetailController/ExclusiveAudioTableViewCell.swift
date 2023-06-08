//
//  ExclusiveAudioTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ExclusiveAudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var audioUrlLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

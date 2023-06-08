//
//  NotificationTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class NotificationTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var buttonClear: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

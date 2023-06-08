//
//  SharedEarningTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SharedEarningTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var transactionID : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var logoImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

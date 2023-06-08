//
//  MyEarningsTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyEarningsTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var storyCategoryLabel : UILabel!
    @IBOutlet weak var headlineLabel : UILabel!
    @IBOutlet weak var soldOutLabel : UILabel!
    @IBOutlet weak var earnlabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

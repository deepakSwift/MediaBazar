//
//  PurchaseEvetListTableViewCellMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseEvetListTableViewCellMH: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var headinglabel : UILabel!
    @IBOutlet weak var timeDateLabel : UILabel!
    @IBOutlet weak var pricelabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var containerView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.applyShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

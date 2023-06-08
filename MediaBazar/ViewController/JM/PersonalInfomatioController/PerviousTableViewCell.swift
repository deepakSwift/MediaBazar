//
//  PerviousTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PerviousTableViewCell: UITableViewCell {

    @IBOutlet weak var textFieldLink: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
//    @IBOutlet weak var buttonAddMore: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

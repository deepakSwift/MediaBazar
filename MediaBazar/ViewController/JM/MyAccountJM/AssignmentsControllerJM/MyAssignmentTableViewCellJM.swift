//
//  MyAssignmentTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyAssignmentTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var countLabel : UILabel!
    @IBOutlet weak var headLineLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
//    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var brifDescri : UILabel!
    
    @IBOutlet weak var removeButton : UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        containerView.applyShadow()
    }

}

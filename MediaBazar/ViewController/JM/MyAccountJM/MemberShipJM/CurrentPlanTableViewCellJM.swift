//
//  CurrentPlanTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CurrentPlanTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var memberShipName : UILabel!
    @IBOutlet weak var memberShipDuration : UILabel!
    @IBOutlet weak var memberShipPrice : UILabel!
    @IBOutlet weak var memberShipExpireData : UILabel!
    @IBOutlet weak var upgrateButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    func setUpUI(){
        upgrateButton.makeRoundCorner(20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

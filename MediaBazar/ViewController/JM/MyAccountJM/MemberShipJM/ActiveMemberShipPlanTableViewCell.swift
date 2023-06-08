//
//  ActiveMemberShipPlanTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ActiveMemberShipPlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memberShipDiscri : UILabel!
    @IBOutlet weak var memberShipPrice : UILabel!
    @IBOutlet weak var memberShipDuration : UILabel!
    @IBOutlet weak var buyButton : UIButton!
    @IBOutlet weak var membershipNAme : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    func setUpUI(){
        buyButton.makeRoundCorner(20)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//
//  ColloborationGroupDetailTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ColloborationGroupDetailTableViewCellJM: UITableViewCell {
    @IBOutlet weak var memberImage : UIImageView!
    @IBOutlet weak var memberNameLabel : UILabel!
    @IBOutlet weak var typeButton : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpButton()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpButton(){
        typeButton.makeRoundCorner(10)
        memberImage.makeRounded()
        
    }

}

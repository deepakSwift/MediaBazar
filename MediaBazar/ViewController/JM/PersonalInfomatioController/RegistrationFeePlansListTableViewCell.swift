//
//  RegistrationFeePlansListTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class RegistrationFeePlansListTableViewCell: UITableViewCell {

    @IBOutlet weak var namelabel : UILabel!
    @IBOutlet weak var detalilLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var buyButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(buyButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)

    }

}

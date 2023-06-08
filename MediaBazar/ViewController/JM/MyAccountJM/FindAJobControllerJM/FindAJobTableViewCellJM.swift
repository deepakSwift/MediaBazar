//
//  FindAJobTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FindAJobTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var viewDetailsButton : UIButton!
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var labelName : UILabel!
    @IBOutlet weak var keywordName : UILabel!
    @IBOutlet weak var jobDiscription : UILabel!
    @IBOutlet weak var workExpLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var salleryLabel : UILabel!
    
    
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
        CommonClass.makeViewCircularWithCornerRadius(viewDetailsButton, borderColor: .black, borderWidth: 0.5, cornerRadius: 8)
    }

}

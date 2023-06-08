//
//  EditorsAssignmentTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditorsAssignmentTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var replayButton : UIButton!
    @IBOutlet weak var containerView : UIView!
    
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var assignmentTitleLabel : UILabel!
    @IBOutlet weak var assignmentDescription : UILabel!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var journaistImage : UIImageView!

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
        CommonClass.makeViewCircularWithCornerRadius(replayButton, borderColor: .black, borderWidth: 0.5, cornerRadius: 8)
    }

}

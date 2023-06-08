//
//  FindAJobDetailTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FindAJobDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var namelabel : UILabel!
    @IBOutlet weak var keywordLabel : UILabel!
    @IBOutlet weak var jobTitlet : UILabel!
    @IBOutlet weak var workExpLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var salleryLabel : UILabel!
    @IBOutlet weak var jobDescriLabel : UILabel!
    @IBOutlet weak var roleLabel : UILabel!
    @IBOutlet weak var fuctionalAreaLabel : UILabel!
    @IBOutlet weak var employmentTimeLabel : UILabel!
    @IBOutlet weak var roleCategory : UILabel!
    @IBOutlet weak var underGradutionLabel : UILabel!
    @IBOutlet weak var postGraduationLabel : UILabel!
    @IBOutlet weak var doctorate : UILabel!
    
    @IBOutlet weak var applyButton : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }
    
    func setUpUI(){
        applyButton.makeRoundCorner(20)
        profileImage.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

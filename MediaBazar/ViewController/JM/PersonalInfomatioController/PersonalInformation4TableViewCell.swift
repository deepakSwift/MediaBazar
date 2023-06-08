//
//  PersonalInformation4TableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PersonalInformation4TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelBenefits: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        checkImage.image = selected ? #imageLiteral(resourceName: "Group 184") : #imageLiteral(resourceName: "Group 184-2")
    
    }
    
    func setupUI(){
        
    }
    
}

//
//  EnquiryTableViewCell.swift
//  MediaBazar
//
//  Created by Sagar Gupta on 14/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headMemberImg: UIImageView!
    @IBOutlet weak var headMemberName: UILabel!
    @IBOutlet weak var headMemberTitle: UILabel!
    @IBOutlet weak var enquiryBtn: UIButton!
    @IBOutlet weak var memberDetailLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    

}


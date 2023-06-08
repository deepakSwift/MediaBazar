//
//  PersonalInformation2TableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PersonalInformation2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView : UIView!

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
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }

}

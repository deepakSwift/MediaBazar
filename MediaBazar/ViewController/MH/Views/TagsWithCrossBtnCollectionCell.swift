//
//  TagsWithCrossBtnCollectionCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class TagsWithCrossBtnCollectionCell: UICollectionViewCell {

    @IBOutlet weak var conatinerView: UIView!
    @IBOutlet weak var buttonTag: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    func setupUI() {
        buttonCancel.makeRounded()
        buttonTag.makeBorder(0.5, color: .black)
        //conatinerView.makeBorder(1, color: .lightGray)
    }

}

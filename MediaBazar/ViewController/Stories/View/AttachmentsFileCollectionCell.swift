//
//  AttachmentsFileCollectionCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AttachmentsFileCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var buttonNote: UIButton!
    @IBOutlet weak var labelImageName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }
    
    func setupCellUI() {
        //buttonNote.makeRoundCorner(7)
    }


}

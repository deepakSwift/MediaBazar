//
//  ThumbnailImagesCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ThumbnailImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbNailImage : UIImageView!
    @IBOutlet weak var thumbnailName : UILabel!
    @IBOutlet weak var noteButton : UIButton!
    @IBOutlet weak var deleteButton : UIButton!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(noteButton, borderColor: .clear, borderWidth: 10)
        
    }
    
}


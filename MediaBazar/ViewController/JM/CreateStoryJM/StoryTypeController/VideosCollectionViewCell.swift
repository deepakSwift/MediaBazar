//
//  VideosCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class VideosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImage : UIImageView!
    @IBOutlet weak var videoName : UILabel!
    @IBOutlet weak var noteButton : UIButton!
    @IBOutlet weak var deletButton : UIButton!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(noteButton, borderColor: .clear, borderWidth: 10)
        
    }
    
}

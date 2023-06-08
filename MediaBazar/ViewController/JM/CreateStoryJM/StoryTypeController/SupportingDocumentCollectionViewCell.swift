//
//  SupportingDocumentCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SupportingDocumentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var noteButton : UIButton!
    @IBOutlet weak var pdfThumbnailImage : UIImageView!
    @IBOutlet weak var pdfName : UILabel!
    @IBOutlet weak var deletButton : UIButton!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(noteButton, borderColor: .clear, borderWidth: 10)
        
    }

    
}

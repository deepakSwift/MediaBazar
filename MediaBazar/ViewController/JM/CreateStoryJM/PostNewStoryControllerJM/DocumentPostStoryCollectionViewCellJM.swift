//
//  DocumentPostStoryCollectionViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 09/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class DocumentPostStoryCollectionViewCellJM: UICollectionViewCell {
    
    @IBOutlet weak var noteButton : UIButton!
    
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(noteButton, borderColor: .clear, borderWidth: 10)
        
    }

    
}

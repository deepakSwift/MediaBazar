//
//  ImagesCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 20/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var noteButton : UIButton!
    @IBOutlet weak var imageName : UILabel!
    @IBOutlet weak var deleteButton : UIButton!
    override func awakeFromNib() {
        setUpUI()
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithRespectToHeight(noteButton, borderColor: .clear, borderWidth: 10)
        
    }
    
    func setUpButton(){
        
    }
    
    @objc func clickOnNoteButton(){
//        let notePopUpView =
    }
    
}

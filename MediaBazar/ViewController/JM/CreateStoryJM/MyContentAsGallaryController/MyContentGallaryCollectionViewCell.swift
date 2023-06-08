//
//  MyContentGallaryCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 21/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyContentGallaryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentImage : UIImageView!
    @IBOutlet weak var selectedInmage : UIImageView!
    
    override var isSelected: Bool {
      didSet {
        selectedInmage.image = isSelected ? #imageLiteral(resourceName: "Group 184") : #imageLiteral(resourceName: "Group 184-2")
        
        }
  }

}

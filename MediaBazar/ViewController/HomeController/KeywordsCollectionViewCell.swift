//
//  KeywordsCollectionViewCell.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class KeywordsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var keywordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDynamicCellSize()
    }
    
    fileprivate func setupDynamicCellSize() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = UIColor(red: 230, green: 230, blue: 230)
        self.makeRoundCorner(borderColor: .darkGray, borderWidth: 0.5)
    }

}

//
//  EditableBoxCollectionViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EditableBoxCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aoiLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var delegate: AccessCollectionViewCell?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupDynamicCellSize()
        deleteButton.addTarget(self, action: #selector(deleteAOI), for: .touchUpInside)
    }
    
    @objc func deleteAOI() {
        delegate?.deleteSingleCell(self)
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
        aoiLabel.makeRoundCorner(borderColor: UIColor(red: 222, green: 222, blue: 222), borderWidth: 1, cornerRadius: 2)
//        backgroundColor = UIColor(red: 222, green: 222, blue: 222)
//        self.makeRoundCorner(borderColor: nil, borderWidth: 0)
    }
    
}

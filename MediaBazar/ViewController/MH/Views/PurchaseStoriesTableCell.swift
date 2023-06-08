//
//  PurchaseStoriesTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 07/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseStoriesTableCell: UITableViewCell {

    @IBOutlet weak var collectionViewKeyWords: UICollectionView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var labelratings: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDaysCount: UILabel!
    @IBOutlet weak var buttonDownload: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupCollectionView()
    }

    func setupView() {
        
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "KeywordsCollectionViewCell", bundle: nil)
        collectionViewKeyWords.register(nib, forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        self.collectionViewKeyWords.dataSource = self
        self.collectionViewKeyWords.delegate = self
        
        if let flowLayout = collectionViewKeyWords.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}


//-- collectionView--
extension PurchaseStoriesTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as! KeywordsCollectionViewCell
        return cell
    }
    
    
}

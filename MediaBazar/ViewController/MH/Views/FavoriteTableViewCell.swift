//
//  FavoriteTableViewCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewKeyWords: UICollectionView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var labelratings: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelSoldOutTimes: UILabel!
    @IBOutlet weak var soldOutHeadLabel : UILabel!

    var keyWordnames = [String]()
    
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
extension FavoriteTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyWordnames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as! KeywordsCollectionViewCell
        cell.keywordLabel.text = keyWordnames[indexPath.item]
        return cell
    }
    
    
}

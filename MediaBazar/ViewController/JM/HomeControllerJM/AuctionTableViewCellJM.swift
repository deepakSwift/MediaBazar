//
//  AuctionTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AuctionTableViewCellJM: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var journalistImage : UIImageView!
    @IBOutlet weak var categoryName : UILabel!
    @IBOutlet weak var languageName : UILabel!
    @IBOutlet weak var countryName : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descri : UILabel!
    @IBOutlet weak var fileCount : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var timelabel : UILabel!
    @IBOutlet weak var buttonFavorite : UIButton!
    @IBOutlet weak var userRType : UILabel!
    @IBOutlet weak var timeLeftLabel : UILabel!
    @IBOutlet weak var authorName : UILabel!
        
    var keywords = [String]()
//    let tempKeywordArray = ["Media", "Fun", "Family"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupCellUI() {
        containerView.applyShadow()
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: "KeywordsCollectionViewCell", bundle: nil)
        keywordsCollectionView.register(nib, forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        self.keywordsCollectionView.dataSource = self
        self.keywordsCollectionView.delegate = self
        
        if let flowLayout = keywordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
}

extension AuctionTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as? KeywordsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.keywordLabel.text = keywords[indexPath.item]
        return cell
    }
}


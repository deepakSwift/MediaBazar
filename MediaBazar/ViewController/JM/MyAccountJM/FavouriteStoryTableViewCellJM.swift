//
//  FavouriteStoryTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 15/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FavouriteStoryTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var journalistType : UILabel!
    @IBOutlet weak var journalistImage : UIImageView!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var categoryType : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descri : UILabel!
    @IBOutlet weak var fileCountLabel : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var storyTypeLabel : UILabel!
    @IBOutlet weak var buttonFavorite : UIButton!
    @IBOutlet weak var soldoutLabel : UILabel!
    @IBOutlet weak var purchaseLimit : UILabel!
    @IBOutlet weak var purchaseLimitheading : UILabel!
    
    //    let tempKeywordArray = ["Media", "Fun", "Family"]
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
        setupCollectionView()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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

extension FavouriteStoryTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as? KeywordsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.keywordLabel.text = keyword[indexPath.item]
        return cell
    }
}


//
//  MyStoriesTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MyStoriesTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    @IBOutlet weak var languageName : UILabel!

    @IBOutlet weak var priceLAbel : UILabel!
    @IBOutlet weak var descri : UILabel!
    @IBOutlet weak var categoryType : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var buttonType : UIButton!
    
    @IBOutlet weak var soldOutLabel : UILabel!
    @IBOutlet weak var soldOutLabelHeading : UILabel!
    
    @IBOutlet weak var purchaselabel : UILabel!
    @IBOutlet weak var purchaselabelHeading : UILabel!
    @IBOutlet weak var totalAverageReview : UILabel!
    @IBOutlet weak var priceHeading : UILabel!
    
    @IBOutlet weak var starImage : UIImageView!
    @IBOutlet weak var lineLabel : UILabel!
    
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

extension MyStoriesTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

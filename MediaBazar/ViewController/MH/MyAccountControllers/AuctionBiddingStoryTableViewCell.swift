//
//  AuctionBiddingStoryTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AuctionBiddingStoryTableViewCell: UITableViewCell {

        @IBOutlet weak var collectionViewKeyWords: UICollectionView!
        @IBOutlet weak var labelPrice: UILabel!
        @IBOutlet weak var imageViewSetImg: UIImageView!
        @IBOutlet weak var labelTitleName: UILabel!
        @IBOutlet weak var buttonShared: UIButton!
        @IBOutlet weak var labelratings: UILabel!
        @IBOutlet weak var labelSubtitle: UILabel!
        @IBOutlet weak var labelAddress: UILabel!
        
        var keyword = [String]()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCollectionView()
            // Initialization code
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

    extension AuctionBiddingStoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return keyword.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as! KeywordsCollectionViewCell
            cell.keywordLabel.text = keyword[indexPath.row]
            return cell
        }
        
        
    }

//
//  PurchaseStoryDetailTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 20/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseStoryDetailTableCell: UITableViewCell {
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    @IBOutlet weak var thumbnailImage : UIImageView!
    
    @IBOutlet weak var labelPriceRete: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelTechnology: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var storyCategoryLabel : UILabel!
    @IBOutlet weak var labelDetails : UILabel!
    @IBOutlet weak var buttonBuyNow: UIButton!
    
    
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonBuyNow.makeRoundCorner(10)
        buttonBuyNow.makeBorder(1, color: .black)
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    fileprivate func setupCollectionView() {
        //setup CollectionView Xib
        keywordCollectionView.dataSource = self
        keywordCollectionView.delegate = self
        
        keywordCollectionView.register(UINib(nibName: "KeywordsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        if let flowLayout = keywordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
}

extension PurchaseStoryDetailTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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


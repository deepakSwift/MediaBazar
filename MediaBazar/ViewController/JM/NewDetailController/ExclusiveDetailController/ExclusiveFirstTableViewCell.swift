//
//  ExclusiveFirstTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ExclusiveFirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    @IBOutlet weak var buttonName: UIButton!
    @IBOutlet weak var imageViewSetImg: RoundImageView!
    @IBOutlet weak var thumbnailImage : UIImageView!
    
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPriceRete: UILabel!
    @IBOutlet weak var labelSoldOut: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelTechnology: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var soldOutHeadlineLabel : UILabel!
    @IBOutlet weak var storyCategoryLabel : UILabel!
    
    
    @IBOutlet weak var buttonMessage: UIButton!
    @IBOutlet weak var buttonHeart: UIButton!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var buttonBuyNow: UIButton!
    @IBOutlet weak var buttonEdit : UIButton!
    @IBOutlet weak var deleteButton : UIButton!
    
    @IBOutlet weak var fileCount : UILabel!
    
    
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonBuyNow.makeRoundCorner(10)
        buttonBuyNow.makeBorder(2, color: .black)
        
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

extension ExclusiveFirstTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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

//
//  AllHomeTableViewCell.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendAllHomeTableCell {
    func storyId(id: String)
}


class AllHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    
   @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var soldOutCount : UILabel!
    @IBOutlet weak var journalistImage : UIImageView!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var categoryType : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var fileCountLabel : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var buttonFavorite : UIButton!
    @IBOutlet weak var ratingLabel : UILabel!
     @IBOutlet weak var buttonType : UIButton!
    @IBOutlet weak var buttonBuyNow : UIButton!
     @IBOutlet weak var priceTag : UILabel!
    @IBOutlet weak var rattingStar : UIImageView!
    @IBOutlet weak var soldOutLabelTag : UILabel!
    
    @IBOutlet weak var timeLeftlabelTag : UILabel!
    @IBOutlet weak var timeLeftlabel : UILabel!
    
    @IBOutlet weak var authorName : UILabel!
    

    var keyword = [String]()
    var delegate:SendAllHomeTableCell!
    
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

extension AllHomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

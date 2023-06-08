//
//  ExclusiveTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ExclusiveTableViewCellJM: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!

    @IBOutlet weak var journalistImage : UIImageView!
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var fileCount : UILabel!
    @IBOutlet weak var categoryType : UILabel!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descri : UILabel!
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var thumbNailImage : UIImageView!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var buttonFavorite : UIButton!
    @IBOutlet weak var soldOutLabel : UILabel!
    @IBOutlet weak var averageRtting : UILabel!
    @IBOutlet weak var userType : UILabel!
    @IBOutlet weak var authowNAme : UILabel!


    
        var keyword = [String]()

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

extension ExclusiveTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("==========================keyword------\(keyword.count)")
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

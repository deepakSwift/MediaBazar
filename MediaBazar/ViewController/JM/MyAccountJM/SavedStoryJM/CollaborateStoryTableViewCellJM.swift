//
//  CollaborateStoryTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CollaborateStoryTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryName : UILabel!
    @IBOutlet weak var languageName : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descri : UILabel!
    @IBOutlet weak var thumbnamilImage : UIImageView!
    @IBOutlet weak var storyCatButton : UIButton!
    @IBOutlet weak var postButton : UIButton!
    
    
    
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
        postButton.makeBorder(1, color: .black)
        postButton.makeRoundCorner(10)
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

extension CollaborateStoryTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

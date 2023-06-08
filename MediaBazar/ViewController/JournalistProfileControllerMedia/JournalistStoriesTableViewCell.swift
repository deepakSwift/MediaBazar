//
//  JournalistStoriesTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 10/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistStoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var categoryTypeLAbel : UILabel!
    @IBOutlet weak var langTimeStateLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var headlineLabel : UILabel!
    @IBOutlet weak var storyTypeButton : UIButton!
    
    @IBOutlet weak var seeMoreButton : UIButton!
    @IBOutlet weak var containerView : UIView!
    

    
    var keyword = [String]()


    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpUI()
        // Configure the view for the selected state
    }
    
    func setUpUI(){
        containerView.makeBorder(0.5, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))

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

extension JournalistStoriesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

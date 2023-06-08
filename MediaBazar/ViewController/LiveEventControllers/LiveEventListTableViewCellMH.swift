//
//  LiveEventListTableViewCellMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class LiveEventListTableViewCellMH: UITableViewCell {
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var headinglabel : UILabel!
    @IBOutlet weak var timeDateLabel : UILabel!
    @IBOutlet weak var pricelabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var containerView : UIView!
    
    @IBOutlet weak var keywordsCollectionView: UICollectionView!    
    var keyword = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.applyShadow()
        setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

extension LiveEventListTableViewCellMH: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

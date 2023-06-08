//
//  KeyWordTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class KeyWordTableCell: UITableViewCell {

    @IBOutlet weak var collectionViewKeyWord: UICollectionView!
    
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
        //containerView.applyShadow()
    }
    
    fileprivate func setupCollectionView() {
        //setup CollectionView Xib
        collectionViewKeyWord.dataSource = self
        collectionViewKeyWord.delegate = self
        
        collectionViewKeyWord.register(UINib(nibName: "KeywordsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "KeywordsCollectionViewCell")
        
        if let flowLayout = collectionViewKeyWord.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

}

//----CollectionView----
extension KeyWordTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width: 30, height: 30)
//    }
    
    
    
}

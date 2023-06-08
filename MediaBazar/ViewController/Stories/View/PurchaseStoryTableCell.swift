//
//  PurchaseStoryTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseStoryTableCell: UITableViewCell {

    @IBOutlet weak var collectionViewKeyWords: UICollectionView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var imageViewSetImg: UIImageView!
    @IBOutlet weak var labelTitleName: UILabel!
    @IBOutlet weak var buttonShared: UIButton!
    @IBOutlet weak var labelratings: UILabel!
    @IBOutlet weak var lableDaysCount: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var buttonDownload: UIButton!
    @IBOutlet weak var labelAddress: UILabel!
    
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupCollectionView()
        // Initialization code
    }

    func setupView() {
        buttonDownload.makeBorder(1, color: .black)
        buttonDownload.makeRoundCorner(10)
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

extension PurchaseStoryTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyword.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as! KeywordsCollectionViewCell
        cell.keywordLabel.text = keyword[indexPath.row]
        return cell
    }
    
    
}

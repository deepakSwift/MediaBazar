//
//  EventsDetailsTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol AccessEventDetailCell {
    func initiateChat(_ sender: UIButton)
}

class EventsDetailsTableCell: UITableViewCell {
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    @IBOutlet weak var buttonName: UIButton!
    @IBOutlet weak var imageViewSetImg: RoundImageView!
    @IBOutlet weak var thumbnailImage : UIImageView!
    
    @IBOutlet weak var labelProfileName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPriceRete: UILabel!
//    @IBOutlet weak var labelDollar: UILabel!
//    @IBOutlet weak var labelSoldOut: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelTechnology: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var soldOutHeadlineLabel : UILabel!
    @IBOutlet weak var storyCategoryLabel : UILabel!
    @IBOutlet weak var labelDetails : UILabel!
    
    @IBOutlet weak var buttonHeart: UIButton!
    @IBOutlet weak var buttonBuyNow: UIButton!
    @IBOutlet weak var editButton : UIButton!
    @IBOutlet weak var deleteButton : UIButton!
    @IBOutlet weak var profileButton : UIButton!
    
    @IBOutlet weak var biddingView : UIView!
    @IBOutlet weak var biddingPrice : UILabel!
    @IBOutlet weak var timeLeftLabel : UILabel!
    
    
    var delegate: AccessEventDetailCell?
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonBuyNow.makeRoundCorner(10)
        buttonBuyNow.makeBorder(1, color: .black)
        setupCollectionView()
        setupButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    fileprivate func setupButton() {
//        buttonMessage.addTarget(self, action: #selector(chatButtonPressed(_:)), for: .touchUpInside)
    }
    
//    @objc func chatButtonPressed(_ sender: UIButton) {
//        delegate?.initiateChat(sender)
//    }
    
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

extension EventsDetailsTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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


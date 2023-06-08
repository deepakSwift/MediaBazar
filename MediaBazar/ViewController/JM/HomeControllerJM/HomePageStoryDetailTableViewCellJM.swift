//
//  HomePageStoryDetailTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//


//protocol AccessEventDetailCell {
//    func initiateChat(_ sender: UIButton)
//}

class HomePageStoryDetailTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var keywordCollectionView : UICollectionView!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var headlineLabel : UILabel!
    @IBOutlet weak var storyCategoryLabel : UILabel!
    @IBOutlet weak var langTimeStateLabel : UILabel!
    @IBOutlet weak var storyTypeLabel : UILabel!
    @IBOutlet weak var storyTumbnailImage : UIImageView!
    @IBOutlet weak var authorName : UILabel!
    @IBOutlet weak var storyDescription : UILabel!
    @IBOutlet weak var labelPriceRete  : UILabel!
    
    @IBOutlet weak var buttonHeart: UIButton!

    @IBOutlet weak var containerView : UIView!
    
    @IBOutlet weak var reviewCount : UILabel!
    @IBOutlet weak var totalAverageReviewRatting : UILabel!
    @IBOutlet weak var reviewView : UIView!
    
    @IBOutlet weak var profileButton : UIButton!
    
//    @IBOutlet weak var biddingView : UIView!
//    @IBOutlet weak var biddingPrice : UILabel!
//    @IBOutlet weak var timeLeftLabel : UILabel!
    
    var keyword = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
        setupButton()
//        setUpUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    fileprivate func setupButton() {
//        buttonMessage.addTarget(self, action: #selector(chatButtonPressed(_:)), for: .touchUpInside)
    }
    
    fileprivate func setUpUI(){
        containerView.makeBorder(0.5, color: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))

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

extension HomePageStoryDetailTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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


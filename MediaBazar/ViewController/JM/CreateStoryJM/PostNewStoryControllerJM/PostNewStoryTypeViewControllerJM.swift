//
//  PostNewStoryTypeViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PostNewStoryTypeViewControllerJM: UIViewController {
    
    
    @IBOutlet weak var textPostStoryCollectionView : UICollectionView!
    @IBOutlet weak var imagePostStoryCollectionView : UICollectionView!
    @IBOutlet weak var thumbnailPostStoryCollectionView : UICollectionView!
    @IBOutlet weak var videoPostStoryCollectionView : UICollectionView!
    @IBOutlet weak var audioPostStoryCollectionView : UICollectionView!
    @IBOutlet weak var documentPostStoryCollectionView : UICollectionView!
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var postButton : UIButton!
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var textView : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        setupButton()
        setupUI()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        self.textPostStoryCollectionView.dataSource = self
        self.textPostStoryCollectionView.delegate = self
        
        self.imagePostStoryCollectionView.dataSource = self
        self.imagePostStoryCollectionView.delegate = self
        
        self.thumbnailPostStoryCollectionView.dataSource = self
        self.thumbnailPostStoryCollectionView.delegate = self
        
        self.videoPostStoryCollectionView.dataSource = self
        self.videoPostStoryCollectionView.delegate = self
        
        self.audioPostStoryCollectionView.dataSource = self
        self.audioPostStoryCollectionView.delegate = self
        
        self.documentPostStoryCollectionView.dataSource = self
        self.documentPostStoryCollectionView.delegate = self
    }
    
    func setupUI(){
        topView.applyShadow()
        containerView.applyShadow()
        CommonClass.makeViewCircularWithCornerRadius(saveButton, borderColor: .gray, borderWidth: 1, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(postButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension PostNewStoryTypeViewControllerJM : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == textPostStoryCollectionView{
            return 1
        } else if collectionView == imagePostStoryCollectionView{
            return 7
        } else if collectionView == thumbnailPostStoryCollectionView{
            return 1
        } else if collectionView == videoPostStoryCollectionView{
            return 4
        } else if collectionView == audioPostStoryCollectionView{
            return 3
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == textPostStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextPostStoryCollectionViewCellJM", for: indexPath) as! TextPostStoryCollectionViewCellJM
            return cell
        } else if collectionView == imagePostStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePostStoryCollectionViewCellJM", for: indexPath) as! ImagePostStoryCollectionViewCellJM
            return cell
        } else if collectionView == thumbnailPostStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailImagePostStoryCollectionViewCellJM", for: indexPath) as! ThumbnailImagePostStoryCollectionViewCellJM
            return cell
        } else if collectionView == videoPostStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPostStoryCollectionViewCellJM", for: indexPath) as! VideoPostStoryCollectionViewCellJM
            return cell
        } else if collectionView == audioPostStoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioPostStoryCollectionViewCellJM", for: indexPath) as! AudioPostStoryCollectionViewCellJM
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentPostStoryCollectionViewCellJM", for: indexPath) as! DocumentPostStoryCollectionViewCellJM
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.bounds.height
        let cellWidth = collectionViewHeight * (160 / 260)
        return CGSize(width: cellWidth, height: collectionViewHeight)
    }
}





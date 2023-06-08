//
//  MediaHouseCompanyInfoVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CompanyInfoVC: UIViewController {
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFiledZipCode: UITextField!
    @IBOutlet weak var textFieldfrequency: UITextField!
    @IBOutlet weak var textFieldAreaInterest: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFiledCity: UITextField!
    @IBOutlet weak var textFiledCountry: UITextField!
    @IBOutlet weak var textFiledPersonName: UITextField!
    @IBOutlet weak var textFieldAgentType: UITextField!
    @IBOutlet weak var textFieldOrganisation: UITextField!
    @IBOutlet weak var textFiledWebsite: UITextField!
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonTragetAudience: UIButton!
    @IBOutlet weak var buttonAreaOfInterest: UIButton!
    @IBOutlet weak var buttonCountry: UIButton!
    @IBOutlet weak var buttonAgent: UIButton!
    @IBOutlet weak var buttonRegion: UIButton!
    @IBOutlet weak var burronFrequency: UIButton!
    @IBOutlet weak var buttonCity: UIButton!
    @IBOutlet weak var buttonState: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonKeyword: UIButton!
    @IBOutlet weak var buttonLanguage: UIButton!
    
    @IBOutlet weak var collectionViewLanguage: UICollectionView!
    @IBOutlet weak var collectionViewTargetAudience: UICollectionView!
    @IBOutlet weak var collectionViewRegions: UICollectionView!
    @IBOutlet weak var collectionViewKeyWord: UICollectionView!
    
    
    @IBOutlet weak var languageCollectinViewConatiner: UIView!
    @IBOutlet weak var keywordCollectinViewConatiner: UIView!
    @IBOutlet weak var targetAudienceCollectinViewConatiner: UIView!
    @IBOutlet weak var regionCollectinViewConatiner: UIView!
    
    var categoryTypeArray = ["Shared","Exclusive","Auction"]
    let categoryTypePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupCollectionView()
        setupPickerView()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        languageCollectinViewConatiner.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        keywordCollectinViewConatiner.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        regionCollectinViewConatiner.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        targetAudienceCollectinViewConatiner.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        
        languageCollectinViewConatiner.makeRoundCorner(5)
        keywordCollectinViewConatiner.makeRoundCorner(5)
        regionCollectinViewConatiner.makeRoundCorner(5)
        targetAudienceCollectinViewConatiner.makeRoundCorner(5)
        textView.makeBorder(0.5, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        buttonSave.makeRoundCorner(20)
    }
    
    func setupCollectionView(){
        //registered collectionView Xib
        collectionViewLanguage.register(UINib(nibName: "TagsWithCrossBtnCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TagsWithCrossBtnCollectionCell")
        
        collectionViewKeyWord.register(UINib(nibName: "TagsWithCrossBtnCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TagsWithCrossBtnCollectionCell")
        
        collectionViewRegions.register(UINib(nibName: "TagsWithCrossBtnCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TagsWithCrossBtnCollectionCell")
        
        collectionViewTargetAudience.register(UINib(nibName: "TagsWithCrossBtnCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TagsWithCrossBtnCollectionCell")
    }
    
    func setupPickerView(){
        categoryTypePickerView.dataSource = self
        categoryTypePickerView.delegate = self
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(bachButtonPressed), for: .touchUpInside)
        buttonLanguage.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
    }
    
    @objc func bachButtonPressed () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func languageButtonPressed () {
         //self.view.addSubview(categoryTypePickerView)
    }


}

//-----CollectionView

extension CompanyInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsWithCrossBtnCollectionCell", for: indexPath) as! TagsWithCrossBtnCollectionCell
        return cell
    }
    
    
}

//----PickerView----
extension CompanyInfoVC: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryTypeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    }
    
}




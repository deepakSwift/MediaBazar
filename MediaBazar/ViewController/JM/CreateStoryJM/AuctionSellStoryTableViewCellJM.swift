//
//  AuctionSellStoryTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class AuctionSellStoryTableViewCellJM: UITableViewCell {

    @IBOutlet weak var keywordsCollectionView : UICollectionView!
    
    @IBOutlet weak var textView : UIView!
    @IBOutlet weak var keywordsCollection : UIView!
    
    @IBOutlet weak var categoryTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    @IBOutlet weak var languageTextField : UITextField!
    @IBOutlet weak var countryTextField : UITextField!
    @IBOutlet weak var stateTextField : UITextField!
    @IBOutlet weak var cityTextField : UITextField!
    @IBOutlet weak var currencyTextField : UITextField!
    
    let tempKeywordArray = ["Media", "Fun", "Family"]
    
    let categoryPickerView = UIPickerView()
    var categoryArray = ["Entertainment","Entertainment","Entertainment"]
    
    let languagePickerView = UIPickerView()
    var languageArray = ["English","English","English"]
    
    let countryPickerView = UIPickerView()
    var countryArray = ["India","India","India"]
    
    let statePickerView = UIPickerView()
    var stateArray = ["Punjab","Punjab","Punjab"]
    
    let cityPickerView = UIPickerView()
    var cityArray = ["Mohali","Mohali","Mohali"]
    
    let currencyPickerView = UIPickerView()
    var currencyArray = ["U.S Dollar","U.S Dollar","U.S Dollar"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupPickerView()
        setupCollectionView()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(keywordsCollection, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
    }
    
    func setupPickerView(){
        categoryTextField.inputView = categoryPickerView
        categoryTextField.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        
        languageTextField.inputView = languagePickerView
        languageTextField.delegate = self
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        countryTextField.inputView = countryPickerView
        countryTextField.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        
        stateTextField.inputView = statePickerView
        stateTextField.delegate = self
        statePickerView.dataSource = self
        statePickerView.delegate = self
        
        cityTextField.inputView = cityPickerView
        cityTextField.delegate = self
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
        
        currencyTextField.inputView = currencyPickerView
        currencyTextField.delegate = self
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        
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

extension AuctionSellStoryTableViewCellJM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempKeywordArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordsCollectionViewCell", for: indexPath) as? KeywordsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.keywordLabel.text = tempKeywordArray[indexPath.item]
        return cell
    }
    
    
}


extension AuctionSellStoryTableViewCellJM: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPickerView{
            return categoryArray.count
        } else if pickerView == languagePickerView{
            return languageArray.count
        } else if pickerView == countryPickerView {
            return countryArray.count
        } else if pickerView == statePickerView{
            return stateArray.count
        } else if pickerView == cityPickerView{
            return cityArray.count
        } else {
            return currencyArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView{
            return categoryArray[row]
        } else if pickerView == languagePickerView{
            return languageArray[row]
        } else if pickerView == countryPickerView {
            return countryArray[row]
        } else if pickerView == statePickerView{
            return stateArray[row]
        } else if pickerView == cityPickerView{
            return cityArray[row]
        } else {
            return currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == categoryPickerView{
            categoryTextField.text = categoryArray[row]
        } else if pickerView == languagePickerView{
            languageTextField.text = languageArray[row]
        } else if pickerView == countryPickerView {
            countryTextField.text = countryArray[row]
        } else if pickerView == statePickerView{
            stateTextField.text = stateArray[row]
        } else if pickerView == cityPickerView{
            cityTextField.text = cityArray[row]
        } else {
            currencyTextField.text = currencyArray[row]
        }
        
    }
    
}


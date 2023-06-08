//
//  TranslateTranscribeTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class TranslateTranscribeTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var selectServiceTypeTextField : UITextField!
    @IBOutlet weak var fromTextField : UITextField!
    @IBOutlet weak var toTextField : UITextField!
    @IBOutlet weak var fileTypeTextField : UITextField!
    @IBOutlet weak var liveTextField : UITextField!
    
    @IBOutlet weak var liveDataView : UIView!
    @IBOutlet weak var videoDataView : UIView!
    
    @IBOutlet weak var uploadFileButton : UIButton!
    
    //    @IBOutlet var fileTypeHideAndView: NSLayoutConstraint!
    
    
    let selectServicePickerView = UIPickerView()
    var selectServiceArray = ["Translate","Translate","Translate"]
    
    let fromPickerView = UIPickerView()
    var fromArray = ["Latin","Latin","Latin"]
    
    let toPickerView = UIPickerView()
    var toArray = ["English","English","English"]
    
    let fileTypePickerView = UIPickerView()
    var fileTypeArray = ["Live","Video"]
    
    var delegate : DataFromCellToMainController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPickerView()
        handleTap()
        setupUI()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI(){
        liveDataView.isHidden = true
        liveDataView.isHidden = true
        delegate?.updateTable?()
    }
    
    func setupPickerView(){
        selectServiceTypeTextField.inputView = selectServicePickerView
        selectServiceTypeTextField.delegate = self
        selectServicePickerView.dataSource = self
        selectServicePickerView.delegate = self
        
        fromTextField.inputView = fromPickerView
        fromTextField.delegate = self
        fromPickerView.dataSource = self
        fromPickerView.delegate = self
        
        toTextField.inputView = toPickerView
        toTextField.delegate = self
        toPickerView.dataSource = self
        toPickerView.delegate = self
        
        fileTypeTextField.inputView = fileTypePickerView
        fileTypeTextField.delegate = self
        fileTypePickerView.dataSource = self
        fileTypePickerView.delegate = self
        
    }
    
    @objc func handleTap(){
        if fileTypeTextField.text == "Video"{
            //            fileTypeHideAndView.isActive = false
            liveDataView.isHidden = true
            videoDataView.isHidden = false
            self.layoutSubviews()
            delegate?.updateTable?()
            
        } else{
            //            fileTypeHideAndView.isActive = true
            videoDataView.isHidden = true
            liveDataView.isHidden = false
            self.layoutSubviews()
            delegate?.updateTable?()
        }
    }
    
    
}

extension TranslateTranscribeTableViewCellJM: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == selectServicePickerView{
            return selectServiceArray.count
        } else if pickerView == fromPickerView{
            return fromArray.count
        } else if pickerView == toPickerView{
            return toArray.count
        } else {
            return fileTypeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == selectServicePickerView{
            return selectServiceArray[row]
        } else if pickerView == fromPickerView{
            return fromArray[row]
        } else if pickerView == toPickerView{
            return toArray[row]
        } else {
            return fileTypeArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == selectServicePickerView{
            selectServiceTypeTextField.text = selectServiceArray[row]
        } else if pickerView == fromPickerView{
            fromTextField.text = fromArray[row]
        } else if pickerView == toPickerView{
            toTextField.text = toArray[row]
        } else {
            fileTypeTextField.text = fileTypeArray[row]
            handleTap()
        }
        
    }
    
}


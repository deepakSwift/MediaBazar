//
//  TranslateTableViewCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 07/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class TranslateTableViewCell: UITableViewCell {

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
        
        fileTypeTextField.inputView = fileTypePickerView
        fileTypeTextField.delegate = self
        fileTypePickerView.dataSource = self
        fileTypePickerView.delegate = self
        
        fromTextField.delegate = self
        toTextField.delegate = self

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

extension TranslateTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == selectServicePickerView{
            return selectServiceArray.count
        } else {
            return fileTypeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == selectServicePickerView{
            return selectServiceArray[row]
        } else {
            return fileTypeArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == selectServicePickerView{
            selectServiceTypeTextField.text = selectServiceArray[row]
        } else {
            fileTypeTextField.text = fileTypeArray[row]
            handleTap()
        }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == fromTextField {
//            let preLangugeVC = AppStoryboard.PreLogin.viewController(LanguageSearchVC.self)
//            preLangugeVC.delegate = self
//            self.present(preLangugeVC, animated: true, completion: nil)
//        } else if textField == toTextField {
//
//        }
//    }
    
}


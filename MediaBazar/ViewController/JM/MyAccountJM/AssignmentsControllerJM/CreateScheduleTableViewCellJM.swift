//
//  CreateScheduleTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CreateScheduleTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var textView : UIView!
    
    @IBOutlet weak var categoryTypeTextField : UITextField!
    @IBOutlet weak var dateTextField : UITextField!
    
    @IBOutlet weak var sharedView : UIView!
    @IBOutlet weak var exclusiveView : UIView!
    @IBOutlet weak var auctionView : UIView!
    @IBOutlet weak var categoryTypeView : UIView!
    
    @IBOutlet weak var LiveButton : UIButton!
    
    let categoryTypePickerView = UIPickerView()
    var categoryTypeArray = ["Shared","Exclusive","Auction"]
    
    var delegate : DataFromCellToMainController?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setuoPickerView()
        handleTap()
        setupButton()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupButton(){
        LiveButton.addTarget(self, action: #selector(liveButtonPressed), for: .touchUpInside)
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        sharedView.isHidden = true
        exclusiveView.isHidden = true
        auctionView.isHidden = true
        categoryTypeView.isHidden = true
        delegate?.updateTable?()
    }
    
    func setuoPickerView(){
        categoryTypeTextField.inputView = categoryTypePickerView
        categoryTypeTextField.delegate = self
        categoryTypePickerView.dataSource = self
        categoryTypePickerView.delegate = self
    }
    
    @objc func handleTap(){
        if categoryTypeTextField.text == "Shared"{
            sharedView.isHidden = false
            exclusiveView.isHidden = true
            auctionView.isHidden = true
            delegate?.updateTable?()
        } else if categoryTypeTextField.text == "Exclusive"{
            sharedView.isHidden = true
            exclusiveView.isHidden = false
            auctionView.isHidden = true
            delegate?.updateTable?()
        } else if categoryTypeTextField.text == "Auction"{
            sharedView.isHidden = true
            exclusiveView.isHidden = true
            auctionView.isHidden = false
            delegate?.updateTable?()
        }
    }
    
    @objc func liveButtonPressed() {
        LiveButton.isSelected = !LiveButton.isSelected
        if LiveButton.isSelected{
            categoryTypeView.isHidden = false
        } else {
            categoryTypeView.isHidden = true
            sharedView.isHidden = true
            exclusiveView.isHidden = true
            auctionView.isHidden = true
            delegate?.updateTable?()
        }
    }


}

extension CreateScheduleTableViewCellJM: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
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
        categoryTypeTextField.text = categoryTypeArray[row]
        handleTap()
    }
    
}


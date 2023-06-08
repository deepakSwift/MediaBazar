//
//  NewReferenceTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 12/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendCountryData {
    func countryData(phoneCode: String, countryCode: String)
}


class NewReferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textFieldfirstName: UITextField!
    @IBOutlet weak var textFieldMiddleName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFielDesignation: UITextField!
    @IBOutlet weak var textFiledPhoneNumber: UITextField!

 
    @IBOutlet weak var deleteButton : UIButton!
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var countryPickerView: UIView!
    @IBOutlet weak var contryFlagImage : UIImageView!
    @IBOutlet weak var countryNamelabel : UILabel!
    
//   @IBOutlet weak var selectCountryButton: UIButton!
    
    var delegate: SendCountryData!


    override func awakeFromNib() {
        super.awakeFromNib()
                CommonClass.makeViewCircularWithCornerRadius(countryPickerView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }




}

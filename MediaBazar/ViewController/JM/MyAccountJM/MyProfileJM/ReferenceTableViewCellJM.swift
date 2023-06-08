//
//  ReferenceTableViewCellJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ReferenceTableViewCellJM: UITableViewCell {
    
    @IBOutlet weak var firstNameTextfield : UITextField!
    @IBOutlet weak var middleNameTextField : UITextField!
    @IBOutlet weak var lastNameTextField : UITextField!
    @IBOutlet weak var emailAddressTextField : UITextField!
    @IBOutlet weak var designamtionTextField : UITextField!
    @IBOutlet weak var mobileTextField : UITextField!
    
    @IBOutlet weak var mobileTextFieldView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(mobileTextFieldView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)

    }
        
}

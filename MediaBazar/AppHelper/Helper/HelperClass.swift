//
//  HelperClass.swift
//  Interiorsbook
//
//  Created by Saurabh Chandra Bose on 23/07/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import UIKit

// To make the UIImage round in layoutSubviews because as an extension that doesn't work properly.
class RoundImageView: UIImageView {
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}



class RoundImageViewWithShadow: UIImageView {
    
    @IBInspectable var cornerRadiu: CGFloat = 20
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    @IBInspectable var layerOpacity: Float = 1
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiu
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiu)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.opacity = layerOpacity
    }
}


// To make the UIImage round in layoutSubviews because as an extension that doesn't work properly.
class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.size.height/2
    }
}

class AddRoundButton: UIButton {
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        // 3. Setup view from .xib file
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        // 3. Setup view from .xib file
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.layer.borderWidth = 0
//        self.layer.borderColor = UIColor.green.cgColor
        self.layer.cornerRadius = self.frame.size.height/2
    }
}


class TextFieldPadding: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}




// Common protocol is used to transfer data from table view cell to main controller
@objc protocol DataFromCellToMainController {
    func backButtonPressed()
    
    @objc optional func writeAReviewButtonPressed()
    
    @objc optional func viewAll()
    
    @objc optional func viewAllRating()
    
    @objc optional func delete()
    
    @objc optional func edit()
    
    @objc optional func navigateFromCollectionView()
    
    @objc optional func viewProfile()
    
    @objc optional func updateTable()
    
    @objc optional func handleGetImage()
    
    @objc optional func saveButtonPressed(imageURLarray: [URL])
    
    @objc optional func getLocation()
    
    @objc optional func getAreaOfIndustry()
    
    @objc optional func openImagePDFpage(type: String, url: URL)
    
    
    @objc optional func getCountry()
    @objc optional func getState()
    @objc optional func getCity()
    
    @objc optional func clickOnMsgSendButton(message : String)
    @objc optional func addCommentButton()
}

@objc protocol DataToPreviousController {
    @objc optional func locationName(name: String, locationID: String)
    @objc optional func pdfSelected()
    @objc optional func pdfNotSelected()
}

protocol AccessCollectionViewCell {
    func deleteSingleCell<T: UICollectionViewCell>(_ cell: T)
}


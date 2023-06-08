//
//  CardView.swift
//  JKConnect
//
//  Created by Akshit Verma on 01/08/19.
//  Copyright © 2019 Apparrant Technologies. All rights reserved.
//


import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadiu: CGFloat = 1
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
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


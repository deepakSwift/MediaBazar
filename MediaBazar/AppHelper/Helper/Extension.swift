//
// Extension.swift
// Fitropy Admin
//
// Created by Saurabh Chandra Bose on 31/05/19.
// Copyright © 2019 anIdea. All rights reserved.
//

import UIKit
import Foundation
import CommonCrypto

// Take color input as hex value or rgb
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


// Call function inside viewDidLayoutSubviews() to perform correctly
// Apply gradient color on view as multiple parameters
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colours[0].cgColor, colours[1].cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}


// Call function inside viewDidLayoutSubviews() to perform correctly
// yourView.addDashedBorder()
// Add dash round corner border to view

extension UIView {
    func addDashedBorder() {
        let color = UIColor.white.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: frameSize.height/2).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

// Add round corner or add round corner with radius to tha view
extension UIView {
    func makeRoundCorner(borderColor: UIColor?, borderWidth: CGFloat, cornerRadius: CGFloat) {
        if let color = borderColor {
            self.layer.borderColor = color.cgColor
        }
        // if borderColor != nil {
        // self.layer.borderColor = borderColor?.cgColor
        // }
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func makeRoundCorner(borderColor: UIColor?, borderWidth: CGFloat) {
        if let color = borderColor {
            self.layer.borderColor = color.cgColor
        }
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = self.layer.frame.size.height/2
        self.layer.masksToBounds = true
    }
}


// Apply bottom shadow to the view
extension UIView {
    func applyShadow() {
        self.layer.shadowOpacity = 0.3 // opacity, 20%
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2 // HALF of blur
        self.layer.shadowOffset = .zero // Spread x, y
        self.layer.masksToBounds = false
    }
    
    func addBottomBorders() {
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.self.frame.size.height - thickness, width: self.self.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.red.cgColor
        self.layer.addSublayer(bottomBorder)
    }
}

// Apply cornor radius to selected cornor
extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        // self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}

// Apply cornor radius to button
extension UIButton {
    func buttonRoundCorners(borderWidth: CGFloat, borderColor: UIColor, radius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radius
    }
}

let relativeConstant: CGFloat = 0.046


var relativeFontConstant: CGFloat {
    switch UIScreen.main.bounds.width {
    case 320:
        return 15
    case 375:
        return (375 / 320) * 15
    case 414:
        return (414 / 320) * 15
    case 568:
        return (568 / 320) * 15
    default:
        return 1
    }
}



// For converting degreesToRadians and vice versa
extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

public func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}


// Notification and Observer constant
extension Notification.Name {
    static let areaOfIndustry = Notification.Name("areaOfIndustry")
    static let reloadTable = Notification.Name("reloadTable")
    static let editPost = Notification.Name("editPost")
    static let tabBarMiddleButtonSelected = Notification.Name("tabBarMiddleButtonSelected")
    
    static let applyContractorFilter = Notification.Name("applyContractorFilter")
    static let applyLabourFilter = Notification.Name("applyLabourFilter")
    static let applyEquipmentFilter = Notification.Name("applyEquipmentFilter")
    static let applyMaterialFilter = Notification.Name("applyMaterialFilter")
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


//extension UIColor {
// static let greenColor = UIColor(rgb: 0x00FE46)
//}

extension UIViewController {
    
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    private func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
}

extension UIColor {
    static let greenColor = UIColor(rgb: 0x00FE46)
    static let redColor = UIColor(rgb: 0xFF3741)
    static let topViewBottomColor = UIColor(red: 214, green: 214, blue: 214)
    static let textFieldBorderColor = UIColor(rgb: 0xEEEEEE)
}

extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
    // to produce a hex digest of the HMAC (SHA-265) of the string using a secret key
    func hmac(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), key, key.count, self, self.count, &digest)
        let data = Data(bytes: digest)
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
    
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        let days = ((time / 3600) / 24)
        
        print(String(format: "%0.2d:%0.2d:%0.2d:%0.2d.%0.3d",days,hours,minutes,seconds,ms))
        
        if (days >= 1) {
            return "\(days) day ago"
        } else if (hours > 24) {
            return "\(hours) hr ago"
        } else if (minutes >= 1) {
            return "\(minutes) min ago"
        }
        else if (seconds >= 1) {
            return "\(seconds) sec ago"
        } else {
            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        }
        
        // return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}


// For making View Component Round,Border etc
extension UIView {
    func makeRoundCorner(_ radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func makeBorder(_ width:CGFloat,color:UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    func addShadowWithRadius(radius: CGFloat ,cornerRadius: CGFloat ){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = radius
        layer.cornerRadius = cornerRadius
    }
    func setShadowWithColor() {
        layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0 ,height: 3)
        self.layer.shadowRadius = 5
    }
    func setRadius(_ corner : CGFloat){
        layer.cornerRadius = corner
        clipsToBounds = true
    }
    var parentViewController: UIViewController? {
        for responder in sequence(first: self, next: { $0.next }) {
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    func roundCornersOneSide(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func makeRounded() {
        self.layer.cornerRadius = self.frame.size.width/2.0
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func setShaddowWithColor() {
        self.layer.masksToBounds = false
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        self.layer.shadowColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        // self.layer.borderColor = UIColor.init(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0).cgColor
        // self.layer.shadowColor = UIColor.init(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: -0.5 ,height: +5)
        self.layer.shadowRadius = 3
    }
    
    func close(animate: Bool = true, duration: Double = 0.5) {
        if !animate {
            self.alpha = 0.0
            return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }) { (compelete) in
            if compelete {
                self.removeFromSuperview()
            }
        }
    }
    
    class func fromNib<T : UIView>(xibName: String) -> T {
        return Bundle.main.loadNibNamed(xibName, owner: nil, options: nil )![0] as! T
    }
    
    func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
}

//---- ImageViewCornerRadiusWithShadow
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 5
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
    
}

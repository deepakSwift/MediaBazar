//
//  ChatMessageCell_Support.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 20/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ChatMessageCell_Support: UICollectionViewCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.textColor = .white
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let timeLabel: UILabel = {
        let tv = UILabel()
        //        tv.text = "SAMPLE TEXT FOR NOW"
        tv.font = UIFont.systemFont(ofSize: 12)
        tv.backgroundColor = UIColor.clear
        tv.textColor = UIColor.lightGray
        tv.isEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    static let blueColor = UIColor(red: 204.0/255.0, green: 181.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.makeRoundCorner(borderColor: UIColor(rgb: 0x1a1a1a), borderWidth: 1, cornerRadius: 0)
        view.layer.cornerRadius = 8
    
//        view.layer.shadowOffset = 2
        view.addShadow()
//        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let pi = UIImageView()
//        pi.image = UIImage(named: "AmazoneSale")
        pi.layer.cornerRadius = 18
        pi.layer.masksToBounds = true
        pi.contentMode = UIView.ContentMode.scaleAspectFill
        pi.translatesAutoresizingMaskIntoConstraints = false
        return pi
    }()
    
//    let profileImage2: UIImageView = {
//        let pi = UIImageView()
////        pi.image = UIImage(named: "AmazoneSale")
//        pi.layer.cornerRadius = 18
//        pi.layer.masksToBounds = true
//        pi.contentMode = UIView.ContentMode.scaleAspectFill
//        pi.translatesAutoresizingMaskIntoConstraints = false
//        return pi
//    }()
    
    let messageImageView: UIImageView = {
        let miv = UIImageView()
        miv.layer.cornerRadius = 16
        miv.layer.masksToBounds = true
        miv.contentMode = UIView.ContentMode.scaleAspectFill
        miv.backgroundColor = .red
        miv.translatesAutoresizingMaskIntoConstraints = false
        return miv
    }()
    
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleRightAnchor: NSLayoutConstraint?
    var bubbleLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textView)
        addSubview(profileImage)
//        addSubview(profileImage2)
        addSubview(timeLabel)
        
        bubbleView.addSubview(messageImageView)
        
        
        //ios 9 constraints
        //x,y,w,h
        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
//        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: profileImage2.leftAnchor, constant: -8)
        bubbleRightAnchor?.isActive = true
        
        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
//        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8)
        bubbleLeftAnchor?.isActive = false
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        //        bubbleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        messageImageView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor).isActive = true
        messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageImageView.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
        messageImageView.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        //        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //        textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1, constant: -50).isActive = true
        
        //        textView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        //        timeView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -5).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        //        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //        timeView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
//        profileImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
//        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        profileImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        profileImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
//        profileImage2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
//        profileImage2.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        profileImage2.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        profileImage2.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


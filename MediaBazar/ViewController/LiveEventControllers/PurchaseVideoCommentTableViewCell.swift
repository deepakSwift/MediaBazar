//
//  PurchaseVideoCommentTableViewCell.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseVideoCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addCommentButton : UIButton!
    @IBOutlet weak var CommentView : UIView!
    @IBOutlet weak var commentCount : UILabel!
    @IBOutlet weak var messageSendButton : UIButton!
    @IBOutlet weak var messageTextField : UITextField!
    
    var delegate : DataFromCellToMainController?

    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         setupButton()
    
         // Configure the view for the selected state
     }
    
    fileprivate func setupButton() {
        messageSendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    @objc func sendButtonPressed() {
        delegate?.clickOnMsgSendButton?(message: messageTextField.text ?? "")
        
    }
    
}

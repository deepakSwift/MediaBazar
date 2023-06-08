//
//  TranslatedAndTranscribeTableCell.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class TranslatedAndTranscribeTableCell: UITableViewCell {

    @IBOutlet weak var labelServiceType: UILabel!
    @IBOutlet weak var labelfileName: UILabel!
    @IBOutlet weak var labelfileLength: UILabel!
    @IBOutlet weak var labelfileSize: UILabel!
    @IBOutlet weak var labelfileExtension: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelLanguage: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

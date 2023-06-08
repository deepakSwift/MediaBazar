//
//  EnquiryTableViewCellJM2.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class EnquiryTableViewCellJM2: UITableViewCell {

        @IBOutlet weak var memberCollectionView: UICollectionView!
        @IBOutlet weak var viewResultBtn: UIButton!
        
        var baseUrl = "https://apimediaprod.5wh.com/"
        var getData = MediaStroyModel()
            
        override func awakeFromNib() {
            super.awakeFromNib()
            setUpCollectionView()

        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

        }
        func setUpCollectionView(){
            self.memberCollectionView.delegate = self
            self.memberCollectionView.dataSource = self
        }
                
    }

    extension EnquiryTableViewCellJM2: UICollectionViewDataSource, UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return getData.ethicMember.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnquiryCollectionViewCell", for: indexPath) as! EnquiryCollectionViewCell
            cell.memberName.text = "\(getData.ethicMember[indexPath.row].firstName) \(getData.ethicMember[indexPath.row].middleName) \(getData.ethicMember[indexPath.row].lastName)"
            let getProfileUrl = "\(self.baseUrl)\(getData.ethicMember[indexPath.row].profilePic)"
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell.memberImg.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
                    return cell
             }
          
        
            
        }
        
        



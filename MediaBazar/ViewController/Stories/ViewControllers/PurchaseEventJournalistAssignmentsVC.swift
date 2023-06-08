//
//  PurchaseEventJournalistAssignmentsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 07/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchaseEventJournalistAssignmentsVC: UIViewController {
    
    
    @IBOutlet weak var ButtonBack: UIButton!
    @IBOutlet weak var labelProfilename: UILabel!
    @IBOutlet weak var profileSetImg: RoundImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelTimeAddress: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTimeMessage: UILabel!
    @IBOutlet weak var labelboldTitle: UILabel!
    @IBOutlet weak var buttonShareds: UIButton!
    @IBOutlet weak var buttonLive: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
       tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton() {
        ButtonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        buttonLive.addTarget(self, action: #selector(liveEventButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func liveEventButtonPressed() {
        let liveVC = self.storyboard?.instantiateViewController(withIdentifier: "LiveViewController") as! LiveViewController
        self.navigationController?.pushViewController(liveVC, animated: true)
    }
    

}

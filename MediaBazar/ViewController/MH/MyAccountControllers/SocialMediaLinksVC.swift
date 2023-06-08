//
//  SocialMediaLinksVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 03/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SocialMediaLinksVC: UIViewController {
    
    @IBOutlet weak var socialMediaLinkTableView : UITableView!
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var backButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
        
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(bachButtonPressed), for: .touchUpInside)
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
        CommonClass.makeViewCircularWithCornerRadius(saveButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
        
    }
    
    func setupTableView(){
        self.socialMediaLinkTableView.dataSource = self
        self.socialMediaLinkTableView.delegate = self
        socialMediaLinkTableView.rowHeight = UITableView.automaticDimension
        socialMediaLinkTableView.estimatedRowHeight = 1000
        
    }
    
    @objc func bachButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}



extension SocialMediaLinksVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaLinksTableViewCell") as! MediaLinksTableViewCell
        
        return cell
    }
    
    
}


//
//  FreeEarningViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class FreeEarningViewControllerJM: UIViewController {
    
    @IBOutlet weak var freeEarningTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupButton()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView(){
        self.freeEarningTableView.dataSource = self
        self.freeEarningTableView.delegate = self
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension FreeEarningViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreeEarningTableViewCellJM") as! FreeEarningTableViewCellJM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

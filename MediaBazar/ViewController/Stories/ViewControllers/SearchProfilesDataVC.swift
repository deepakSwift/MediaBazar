//
//  SearchProfilesDataVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SearchProfilesDataVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewSearch: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupTableView() {
        //registered XIB
        tableViewSearch.register(UINib(nibName: "SearchProfileTableCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchProfileTableCell")
    }
    
    @objc func viewProfileButtonPressed() {
        //NavigateToProfile
    }
    
    @objc func chatButtonPressed() {
        //NavigateChat
    }
    
    @objc func backButtonPressed() {
       self.navigationController?.popViewController(animated: true)
    }
}

//---TableView ----
extension SearchProfilesDataVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchProfileTableCell", for: indexPath) as! SearchProfileTableCell
        cell.buttonViewProfile.makeRoundCorner(10)
        cell.buttonViewProfile.addTarget(self, action: #selector(viewProfileButtonPressed), for: .touchUpInside)
        cell.buttonChat.addTarget(self, action: #selector(chatButtonPressed), for: .touchUpInside)
        return cell
    }
    
    
}

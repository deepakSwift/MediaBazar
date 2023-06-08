//
//  PurchasedEventsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class PurchasedEventsVC: UIViewController {

    @IBOutlet weak var tableViewPurchaseEvents: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
    }
    
    func setupUI() {
        
    }
    
    func setupButton() {
    
    }
    
    func setupTableView() {
        //registered XIB
        tableViewPurchaseEvents.register(UINib(nibName: "EventsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventsTableViewCell")
    }
}


// -----TableView------

extension PurchasedEventsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "PurchaseEventJournalistAssignmentsVC") as! PurchaseEventJournalistAssignmentsVC
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

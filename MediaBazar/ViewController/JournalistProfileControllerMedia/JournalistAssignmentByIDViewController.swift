//
//  JournalistAssignmentByIDViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 13/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class JournalistAssignmentByIDViewController: UIViewController {
    
    @IBOutlet weak var assignmentTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    
    var assignment = [storyListModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setupButton()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUpTableView(){
        self.assignmentTableView.dataSource = self
        self.assignmentTableView.delegate = self
        self.assignmentTableView.bounces = false
        self.assignmentTableView.alwaysBounceVertical = false
        self.assignmentTableView.rowHeight = UITableView.automaticDimension
        self.assignmentTableView.estimatedRowHeight = 1000
        self.assignmentTableView.reloadData()
        
    }
    
    func setupButton() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension JournalistAssignmentByIDViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalistAssignmentTableViewCell") as! JournalistAssignmentTableViewCell
        
        cell.countLabel.text = "\(indexPath.row + 1)."
        let arrData = assignment[indexPath.row]
        cell.headLineLabel.text = arrData.assignmentHeadline
        cell.brifDescri.text = arrData.assignmentDesc
        cell.dateLabel.text = "\(arrData.date) | \(arrData.time) | \(arrData.country.name)"
        
        var allKeywords = arrData.keywordName
        allKeywords.append("")
        cell.keyword = allKeywords
        cell.keywordsCollectionView.reloadData()
        
        return cell
    }
    
    
}

//
//  FaqViewController.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

enum CellType: String {
    case collapseCell = "collapse"
    case expandCell =  "expand"
}

struct TableCellData {
    var open = Bool()
    var title = String()
    var sectionData = [String]()
}


struct faqTableCellData{
    var open = Bool()
    var title = String()
    var sectionData = String()
}

class FaqViewController: UIViewController {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewFaq: UITableView!
    @IBOutlet weak var buttonBack: UIButton!
    
    var tableViewData = [faqTableCellData]()
    var cellType:CellType = .collapseCell
    
    var getFaqData = [faqModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTableView()
        getFaqQuesAndAns(userType: "journalist")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        
        super.updateViewConstraints()
        //TableView Popular services resize
        self.tableViewHeight?.constant = self.tableViewFaq.contentSize.height
    }
    
    func setupUI(){
        tableViewData = [faqTableCellData(open: false, title: "", sectionData:"")]
        tableViewFaq.tableFooterView = UIView()
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        
        self.tableViewFaq.dataSource = self
        self.tableViewFaq.delegate = self
        
        //registered XIB
        tableViewFaq.register(UINib(nibName: "FaqTitleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FaqTitleTableViewCell")
        
        tableViewFaq.register(UINib(nibName: "FaqSubTitleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FaqSubTitleTableViewCell")
    }
    
    func setupTableViewData() {
        
        for titleData1 in getFaqData.enumerated(){
            var temdata = [String]()
            let questionData = titleData1.element.question
            print("questionData=====\(questionData)")

            let answerData = titleData1.element.answer
            temdata.append(answerData)
            print("temdata=====\(temdata)")
            
            let cell = [faqTableCellData(open: false, title: titleData1.element.question, sectionData: titleData1.element.answer)]
            tableViewData.append(contentsOf: cell)
            self.tableViewFaq.reloadData()
        }

    }

    
    func getFaqQuesAndAns(userType : String){
        CommonClass.showLoader()
        Webservices.sharedInstance.getFaqMediaAndJournalist(userType: userType){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.getFaqData.append(contentsOf: somecategory)
                    self.setupTableViewData()
                    self.tableViewFaq.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    

}


//------TableView drop down ---------
extension FaqViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("SectionCount====================\(tableViewData.count)")
        return tableViewData.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].open == true {
            return tableViewData[section].sectionData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.viewWillLayoutSubviews()
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqTitleTableViewCell", for: indexPath) as! FaqTitleTableViewCell
            cell.labelTitle.text = tableViewData[indexPath.section].title
            //cell.labelSectionData.text = tableViewData[indexPath.section].title
            // tableView AeroButtonChange
            if cellType == .collapseCell {
                cell.buttonMinimize.setTitle("+", for: .normal)
            } else if cellType == .expandCell && tableViewData[indexPath.section].open == true {
                cell.buttonMinimize.setTitle("-", for: .normal)
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FaqSubTitleTableViewCell", for: indexPath) as! FaqSubTitleTableViewCell
            cell.labelSubTitle.text = tableViewData[indexPath.section].sectionData
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableViewData[indexPath.section].open == true {
            cellType = .expandCell
            print("Collapse")
            tableViewData[indexPath.section].open = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
            
            if indexPath.row == 0 {
                //print("Collapse")
            } else if indexPath.row != 0 {
                print("subCategory click")
            }
        } else {
            cellType = .expandCell
            print("expand")
            tableViewData[indexPath.section].open = true
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}



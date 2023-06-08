//
//  PreferedLanguageViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 19/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol languageDelegate {
    func passlanguage(languageName: String, languageId: String)
}


class PreferedLanguageViewController: UIViewController {
    
    @IBOutlet weak var preferredLanguageTableView : UITableView!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    
//    var languageArray = ["Bangla","Filipino","Japane","Japane","Maley","Punjabi","Telegu"]
    var languageList = [LanguageList]()
    
    var delegate: languageDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        getlanguageList()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    func setupUI(){
        topView.applyShadow()
        self.preferredLanguageTableView.dataSource = self
        self.preferredLanguageTableView.delegate = self
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getlanguageList(){
        CommonClass.showLoader()
        Webservice.sharedInstance.languageListData(){(result,response,message) in
        CommonClass.hideLoader()
            print(result)
                if result == 200{
                if let somecategory = response{
                    self.languageList.removeAll()
                    self.languageList.append(contentsOf: somecategory)
                    self.preferredLanguageTableView.reloadData()
                } else{

                }
            }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
    

}

extension PreferedLanguageViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredLanguageTableViewCell", for: indexPath) as! PreferredLanguageTableViewCell

        cell.languagelabel.text = languageList[indexPath.row].languageName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let languageName = languageList[indexPath.row].languageName
        let languageId = languageList[indexPath.row].languageID
       // delegate.passlanguage(languageName: languageName, languageId: languageId)
        delegate?.passlanguage(languageName: languageName, languageId: languageId)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

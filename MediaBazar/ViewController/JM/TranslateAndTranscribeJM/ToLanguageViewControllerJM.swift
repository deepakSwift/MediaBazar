//
//  ToLanguageViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 25/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfToLanguage {
    func languageName(name: String, id: String, langKey: String)
}

class ToLanguageViewControllerJM: UIViewController {
    
    
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfToLanguage!
    var languageData = [LanguageList]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        doInitialSetup()
        // Do any additional setup after loading the view.
    }
    
    func doInitialSetup(){
        //registered XIB
        tableViewCountry.register(UINib(nibName: "CountrySearchTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CountrySearchTableCell")
    }
    
    func apiCall() {
        CommonClass.showLoader()
        getlanguageList()
    }
    
    func setupData() {
        for countryName in languageData {
            Getdata.append(countryName.languageName)
            GetDataId.append(countryName.languageID)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate.languageName(name: "", id: "", langKey: "")
        })
    }
    
    func getlanguageList(){
        CommonClass.showLoader()
        Webservice.sharedInstance.toLanguageListData(){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    //self.languageData.removeAll()
                    self.languageData.append(contentsOf: somecategory)
                    self.setupData()
                    self.tableViewCountry.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


//------ TableView -------

extension ToLanguageViewControllerJM: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return languageData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        cell.labelText.text = languageData[indexPath.row].languageName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            let name = self.languageData[indexPath.row].languageName
            let id = self.languageData[indexPath.row].languageID
            let langKey = self.languageData[indexPath.row].languageKey
            print("========\(name)")
            print("========\(id)")
            self.delegate.languageName(name: name, id: id, langKey: langKey)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}




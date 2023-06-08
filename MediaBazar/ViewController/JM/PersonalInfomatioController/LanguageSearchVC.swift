//
//  LanguageSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 11/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfLanguage {
    func languageName(name: String, id: String, langKey: String)
}

class LanguageSearchVC: UIViewController {

    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfLanguage!
    var languageData = [LanguageList]()
    
    var filteredData = [String]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCall()
        searchBarView.delegate = self
        doInitialSetup()
        // Do any additional setup after loading the view.
    }
    
    func doInitialSetup(){
        //registered XIB
        tableViewCountry.register(UINib(nibName: "CountrySearchTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CountrySearchTableCell")
        
        searchBarView.makeRoundCorner(5)
        searchBarView.makeBorder(1, color: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.910307655))
        if let textfield = searchBarView.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = UIColor.blue
            textfield.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        }
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
            self.self.delegate.languageName(name: "", id: "", langKey: "")
        })
    }
    
    func getlanguageList(){
        CommonClass.showLoader()
        Webservice.sharedInstance.languageListData(){(result,response,message) in
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

extension LanguageSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return languageData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            cell.labelText.text = languageData[indexPath.row].languageName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let name = self.filteredData[indexPath.row]
                
                for cityName in self.languageData {
                    if name == cityName.languageName {
                        let id = cityName.languageID
                        let langKey = cityName.languageKey
                        print("========\(name)")
                        print("========\(id)")
                        self.delegate.languageName(name: name, id: id, langKey: langKey)
                    }
                }
            } else {
                let name = self.languageData[indexPath.row].languageName
                let id = self.languageData[indexPath.row].languageID
                let langKey = self.languageData[indexPath.row].languageKey
                print("========\(name)")
                print("========\(id)")
                self.delegate.languageName(name: name, id: id, langKey: langKey)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension LanguageSearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        flag = true
        self.tableViewCountry.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = Getdata.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        flag = true
        self.tableViewCountry.reloadData()
    }
    
}



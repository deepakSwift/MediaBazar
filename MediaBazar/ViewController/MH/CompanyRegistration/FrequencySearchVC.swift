//
//  FrequencySearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 28/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfFrequency {
    func frequencyName(name: String, id: String )
}

class FrequencySearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewFrequency: UITableView!
    
    var flag = false
    var delegate: SendNameOfFrequency!
    var keywordData = [LanguageList]()
    
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
        tableViewFrequency.register(UINib(nibName: "CountrySearchTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CountrySearchTableCell")
        
        searchBarView.makeRoundCorner(5)
        searchBarView.makeBorder(1, color: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.910307655))
        if let textfield = searchBarView.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = UIColor.blue
            textfield.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        }
    }
    
    func apiCall() {
           CommonClass.showLoader()
           getCategory()
       }
       
       func setupData() {
           for keywordName in keywordData {
               Getdata.append(keywordName.mediahouseFrequencyName)
               GetDataId.append(keywordName.keywordID)
           }
       }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
           self.dismiss(animated: true, completion: {
            self.delegate.frequencyName(name: "", id: "")
           })
       }
       
       func getCategory(){
           CommonClass.showLoader()
           WebService3.sharedInstance.MediaFrequency(){(result,response,message) in
               CommonClass.hideLoader()
               print(result)
               if result == 200{
                   if let somecategory = response{
                       self.keywordData.removeAll()
                       self.keywordData.append(contentsOf: somecategory)
                       self.setupData()
                       self.tableViewFrequency.reloadData()
                       
                   } else{
                       
                   }
               }else{
                   NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
               }
           }
       }
}

//------ TableView -------
extension FrequencySearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return keywordData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            cell.labelText.text = keywordData[indexPath.row].mediahouseFrequencyName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let name = self.filteredData[indexPath.row]

                for keywordName in self.keywordData {
                    if name == keywordName.mediahouseFrequencyName {
                        let id = keywordName.keywordID
                        print("========\(name)")
                        print("========\(id)")
                        self.delegate.frequencyName(name: name, id: id)
                    }
                }
            } else {
                let name = self.keywordData[indexPath.row].mediahouseFrequencyName
                let id = self.keywordData[indexPath.row].keywordID
                print("========\(name)")
                print("========\(id)")
                
                //self.delegate.keywordName(name: name, id: id)
                self.delegate.frequencyName(name: name, id: id)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//----------- SearchBar Delegate --------------
extension FrequencySearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        flag = true
        self.tableViewFrequency.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = Getdata.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        flag = true
        self.tableViewFrequency.reloadData()
    }
    
}


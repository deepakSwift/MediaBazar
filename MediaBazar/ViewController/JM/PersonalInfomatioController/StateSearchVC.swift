//
//  StateSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfState {
    func stateName(name: String, id: String, countyId: String, symobol: String, currencyName: String)
}

class StateSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfState!
    var stateData = [CountryList]()
    
    var filteredData = [String]()
    var getSelectedCountry = ""
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    var countryId = ""
    
    
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
        getStateList(countryId: countryId)
    }
    
    func setupData() {
        for countryName in stateData {
            Getdata.append(countryName.name)
            GetDataId.append(countryName.placeId)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate.stateName(name: "", id: "", countyId: "", symobol: "", currencyName: "")
        })
    }
    
    
    

    func getStateList(countryId: String){
        
        Webservice.sharedInstance.stateListData(countryId: countryId){ (result, response, message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response {
                   self.stateData.append(contentsOf: somecategory)
                    self.setupData()
                    self.tableViewCountry.reloadData()
                }
            } else {
              NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
}


//------ TableView -------

extension StateSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return stateData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            if filteredData[indexPath.row] == self.getSelectedCountry {
                cell.labelText.textColor = .black
            } else {
                cell.labelText.textColor = .lightGray
            }
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            if stateData[indexPath.row].name == self.getSelectedCountry {
                cell.labelText.textColor = .black
            } else {
                cell.labelText.textColor = .lightGray
            }
            cell.labelText.text = stateData[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let name = self.filteredData[indexPath.row]
                
                for cityName in self.stateData {
                    if name == cityName.name {
                        let id = cityName.placeId
                        let countryId = cityName.countryId
                        let symbol = cityName.symbol
                        let currencyName = cityName.currencyName
                        print("========\(name)")
                        print("========\(id)")
                        print("========\(countryId)")
                        print("========\(symbol)")
                        print("========\(currencyName)")
                        self.delegate.stateName(name: name, id: id, countyId: countryId, symobol: symbol, currencyName: currencyName)
                    }
                }
            } else {
                let name = self.stateData[indexPath.row].name
                let id = self.stateData[indexPath.row].placeId
                let countryId = self.stateData[indexPath.row].countryId
                let symbol = self.stateData[indexPath.row].symbol
                let currencyName = self.stateData[indexPath.row].currencyName
                print("========\(name)")
                print("========\(id)")
                print("========\(countryId)")
                print("========\(symbol)")
                print("========\(currencyName)")
               self.delegate.stateName(name: name, id: id, countyId: countryId, symobol: symbol, currencyName: currencyName)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension StateSearchVC: UISearchBarDelegate {
    
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



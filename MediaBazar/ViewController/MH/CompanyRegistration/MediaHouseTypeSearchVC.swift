
//
//  MediaHouseTypeSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//


import UIKit

protocol SendNameOfMediaType {
    func countryName(name: String, id: String)
}

class MediaHouseTypeSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfMediaType!
    var countryData = [CountryList]()
    
    
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
        getMediaTypeList()
    }
    
    func setupData() {
            for countryName in countryData {
                Getdata.append(countryName.mediahouseTypeName)
                GetDataId.append(countryName.mediahouseTypeId)
            }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate.countryName(name: "", id: "")
        })
    }
    
    func getMediaTypeList(){
        WebService3.sharedInstance.MediaType(){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                   // self.countryData.removeAll()
                    self.countryData.append(contentsOf: somecategory)
                    self.setupData()
                    self.tableViewCountry.reloadData()
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

//------ TableView -------
extension MediaHouseTypeSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return countryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            cell.labelText.text = countryData[indexPath.row].mediahouseTypeName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let CountryName = self.filteredData[indexPath.row]
                
                for cityName in self.countryData {
                        if CountryName == cityName.mediahouseTypeName {
                            let countryId = cityName.mediahouseTypeId
                            let sortName = cityName.sortName
                            let phoneCode = cityName.phoneCode
                            let symbol = cityName.symbol
                            let currencyName = cityName.currencyName
                            print("========\(CountryName)")
                            print("========\(countryId)")
                            print("========\(sortName)")
                            print("========\(phoneCode)")
                            print("========\(symbol)")
                            print("========\(currencyName)")
                            //self.delegate.countryName(name: CountryName, id: countryId)
                            self.delegate.countryName(name: CountryName, id: countryId)
                            
                        }
                    }
            } else {
                let CountryName = self.countryData[indexPath.row].mediahouseTypeName
                let countryId = self.countryData[indexPath.row].mediahouseTypeId
                
                let sortName = self.countryData[indexPath.row].sortName
                let phoneCode = self.countryData[indexPath.row].phoneCode
                let symbol = self.countryData[indexPath.row].symbol
                let currencyName = self.countryData[indexPath.row].currencyName
                print("========\(CountryName)")
                print("========\(countryId)")
                print("========\(sortName)")
                print("========\(phoneCode)")
                print("========\(symbol)")
                print("========\(currencyName)")
                self.delegate.countryName(name: CountryName, id: countryId)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension MediaHouseTypeSearchVC: UISearchBarDelegate {
    
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



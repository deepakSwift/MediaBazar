//
//  EmploymentTypeVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 09/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfEmployementType {
    func employementTypeName(name: String)
}

class EmploymentTypeVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfEmployementType!
    var areaOfInterestArea = [String]()
    
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
           getCategory()
       }
       
       func setupData() {
           for countryName in areaOfInterestArea {
               Getdata.append(countryName)
               //GetDataId.append(countryName.keywordID)
           }
       }
       
       @IBAction func buttonActionDismiss(_ sender: Any) {
              self.dismiss(animated: true, completion: {
                self.delegate.employementTypeName(name: "")
              })
          }
          
    func getCategory(){
        
        let arrayCategory = ["Full-Time", "Part-Time"]
        for data in arrayCategory.enumerated() {
            areaOfInterestArea.append(data.element)
        }
        self.tableViewCountry.reloadData()
    }

    
  
}

//------ TableView -------
extension EmploymentTypeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return areaOfInterestArea.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            cell.labelText.text = areaOfInterestArea[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let CountryName = self.filteredData[indexPath.row]
                
                for cityName in self.areaOfInterestArea {
                    if CountryName == cityName {
                        //let countryId = cityName.keywordID
                        print("========\(CountryName)")
                        self.delegate.employementTypeName(name: CountryName)
                    }
                }
            } else {
                let CountryName = self.areaOfInterestArea[indexPath.row]
                //let countryId = self.areaOfInterestArea[indexPath.row].keywordID
                print("========\(CountryName)")
                self.delegate.employementTypeName(name: CountryName)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension EmploymentTypeVC: UISearchBarDelegate {
    
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



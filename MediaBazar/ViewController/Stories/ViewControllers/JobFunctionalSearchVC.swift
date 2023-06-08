//
//  JobFunctionalSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 08/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfFunctionalArea {
    func jobFunctionalName(name: String, id: String)
}

class JobFunctionalSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfFunctionalArea!
    var areaOfInterestArea = [LanguageList]()
    
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
           getCategory()
       }
       
       func setupData() {
           for countryName in areaOfInterestArea {
               Getdata.append(countryName.jobFunctionalAreaName)
               GetDataId.append(countryName.keywordID)
           }
       }
       
       @IBAction func buttonActionDismiss(_ sender: Any) {
              self.dismiss(animated: true, completion: nil)
          }
          
    func getCategory(){
        WebService3.sharedInstance.jobFunctionalListData(){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.areaOfInterestArea.removeAll()
                    self.areaOfInterestArea.append(contentsOf: somecategory)
                    self.setupData()
                    self.tableViewCountry.reloadData()
                    //self.designationPickerView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
   
}

//------ TableView -------
extension JobFunctionalSearchVC: UITableViewDataSource, UITableViewDelegate {
    
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
            cell.labelText.text = areaOfInterestArea[indexPath.row].jobFunctionalAreaName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let CountryName = self.filteredData[indexPath.row]
                
                for cityName in self.areaOfInterestArea {
                    if CountryName == cityName.jobFunctionalAreaName {
                        let countryId = cityName.keywordID
                        print("========\(CountryName)")
                        print("========\(countryId)")
                        self.delegate.jobFunctionalName(name: CountryName, id: countryId)
                    }
                }
            } else {
                let CountryName = self.areaOfInterestArea[indexPath.row].jobFunctionalAreaName
                let countryId = self.areaOfInterestArea[indexPath.row].keywordID
                print("========\(CountryName)")
                print("========\(countryId)")
                self.delegate.jobFunctionalName(name: CountryName, id: countryId)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension JobFunctionalSearchVC: UISearchBarDelegate {
    
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




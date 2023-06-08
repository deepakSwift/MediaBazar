//
//  CustomCitySearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 30/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendCountryName {
    func countryName(name: [String], id: [String], sortName: [String], phoneCode: [String], currencyName: [String], symbol: [String])
}

class CustomCountySearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOkay: UIButton!
    
    var flag = false
    var delegate: SendCountryName!
    var countryData = [CountryList]()
    
    var filteredData = [String]()
    var Getdata = [String]()
    var GetDataId = [String]()

    var countryNameData = [String]()
    var countryIdData = [String]()
    var sortNameData = [String]()
    var phoneCodeData = [String]()
    var symbolData = [String]()
    var currencyNameData = [String]()
    
    var selectedTarget = [String]()
    let limit = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.isHidden = true
        apiCall()
        searchBarView.delegate = self
        doInitialSetup()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func doInitialSetup(){
        //registered XIB
        tableViewCountry.register(UINib(nibName: "CustomKeywordTableCell", bundle: Bundle.main), forCellReuseIdentifier: "CustomKeywordTableCell")
        
        searchBarView.makeRoundCorner(5)
        searchBarView.makeBorder(1, color: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.910307655))
        if let textfield = searchBarView.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = UIColor.blue
            textfield.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
        }
    }
    
    func apiCall() {
        CommonClass.showLoader()
        getCountryList()
    }
    
    func setupData() {
            for countryName in countryData {
                Getdata.append(countryName.name)
                GetDataId.append(countryName.placeId)
            }
    }
    
    func setupUI() {
        buttonOkay.addTarget(self, action: #selector(onClickOkayButton), for: .touchUpInside)
        buttonCancel.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
    }
    
    @objc func onClickOkayButton() {

        self.dismiss(animated: true) {
            self.delegate.countryName(name: self.countryNameData, id: self.countryIdData, sortName: self.sortNameData, phoneCode: self.phoneCodeData, currencyName: self.symbolData, symbol: self.currencyNameData)
        }
    }
    
    @objc func onClickCancelButton() {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCountryList(){
        Webservice.sharedInstance.countryListData(){(result,response,message) in
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
extension CustomCountySearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return countryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomKeywordTableCell", for: indexPath) as! CustomKeywordTableCell
        
        if flag == true {
            cell.labelName.text = filteredData[indexPath.row]
        } else {
            cell.labelName.text = countryData[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true) {
            
            if self.flag == true {
                let CountryName = self.filteredData[indexPath.row]
                
                for cityName in self.countryData {
                        if CountryName == cityName.name {
                            let countryId = cityName.placeId
                            let sortName = cityName.sortName
                            let phoneCode = cityName.phoneCode
                            let symbol = cityName.symbol
                            let currencyName = cityName.currencyName
                          
//                            self.countryNameData.append(CountryName)
//                            self.countryIdData.append(countryId)
//                            self.sortNameData.append(sortName)
//                            self.phoneCodeData.append(phoneCode)
//                            self.symbolData.append(symbol)
//                            self.currencyNameData.append(currencyName)
                            
                            if countryNameData.count <= 8{
                                self.countryNameData.append(CountryName)
                                self.countryIdData.append(countryId)
                                self.sortNameData.append(sortName)
                                self.phoneCodeData.append(phoneCode)
                                self.symbolData.append(symbol)
                                self.currencyNameData.append(currencyName)
                            }else {
                                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You can select only 9 target audience")
                            }
                            print("========\(countryNameData)")
                            print("========\(countryIdData)")
                            print("========\(sortNameData)")
                            print("========\(phoneCodeData)")
                            print("========\(symbolData)")
                            print("========\(currencyNameData)")
                            //self.delegate.countryName(name: CountryName, id: countryId)
                            //self.delegate.countryName(name: CountryName, id: countryId, sortName: sortName, phoneCode: phoneCode, currencyName: currencyName, symbol: symbol)
                        }
                    }
            } else {
                let CountryName = self.countryData[indexPath.row].name
                let countryId = self.countryData[indexPath.row].placeId
                let sortName = self.countryData[indexPath.row].sortName
                let phoneCode = self.countryData[indexPath.row].phoneCode
                let symbol = self.countryData[indexPath.row].symbol
                let currencyName = self.countryData[indexPath.row].currencyName
               
//                self.countryNameData.append(CountryName)
//                self.countryIdData.append(countryId)
//                self.sortNameData.append(sortName)
//                self.phoneCodeData.append(phoneCode)
//                self.symbolData.append(symbol)
//                self.currencyNameData.append(currencyName)
                
                if countryNameData.count <= 8{
                    self.countryNameData.append(CountryName)
                    self.countryIdData.append(countryId)
                    self.sortNameData.append(sortName)
                    self.phoneCodeData.append(phoneCode)
                    self.symbolData.append(symbol)
                    self.currencyNameData.append(currencyName)
                }else {
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You can select only 9 target audience")
                }
                print("========\(countryNameData)")
                print("========\(countryIdData)")
                print("========\(sortNameData)")
                print("========\(phoneCodeData)")
                print("========\(symbolData)")
                print("========\(currencyNameData)")
                //self.delegate.countryName(name: CountryName, id: countryId, sortName: sortName, phoneCode: phoneCode, currencyName: currencyName, symbol: symbol)
            
            }
        
//        if let sr = tableView.indexPathsForSelectedRows {
//                   print("didDeselectRowAtIndexPath selected rows:\(sr)")
//               }
        //}
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let CountryName = self.countryData[indexPath.row].name
        let countryId = self.countryData[indexPath.row].placeId
        let sortName = self.countryData[indexPath.row].sortName
        let phoneCode = self.countryData[indexPath.row].phoneCode
        let symbol = self.countryData[indexPath.row].symbol
        let currencyName = self.countryData[indexPath.row].currencyName
        
        countryNameData.removeAll(where: { $0 == CountryName })
        countryIdData.removeAll(where: { $0 == countryId })
        sortNameData.removeAll(where: { $0 == sortName })
        phoneCodeData.removeAll(where: { $0 == phoneCode })
        symbolData.removeAll(where: { $0 == symbol })
        currencyNameData.removeAll(where: { $0 == currencyName })
        
        print("========\(countryNameData)")
        print("========\(countryIdData)")
        print("========\(sortNameData)")
        print("========\(phoneCodeData)")
        print("========\(symbolData)")
        print("========\(currencyNameData)")
        
        if let sr = tableView.indexPathsForSelectedRows {
                  print("didDeselectRowAtIndexPath selected rows:\(sr)")
              }
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            func shouldSelect() -> Bool {
                for item in selectedTarget {
                    if item == countryData[indexPath.row].name {
                        return true
                    }
                }
                //                locationArray[indexPath.row].location
                return false
            }
//            if shouldSelect() {
//                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
//            }
    }
    
//    private func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//
//        if let sr = tableView.indexPathsForSelectedRows {
//            if sr.count == limit {
//                let alertController = UIAlertController(title: "Oops", message:
//                    "You are limited to 9 selections", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
//                }))
//                self.present(alertController, animated: true, completion: nil)
//
//                return nil
//            }
//        }
//
//        return indexPath
//    }

    
}


//----------- SearchBar Delegate --------------
extension CustomCountySearchVC: UISearchBarDelegate {
    
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



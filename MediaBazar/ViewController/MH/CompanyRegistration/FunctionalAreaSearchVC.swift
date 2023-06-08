//
//  FunctionalAreaSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 09/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendFunctionaAreaName {
    func functionalAreaName(name: [String], id: [String])
}

class FunctionalAreaSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOkay: UIButton!
    
    var flag = false
    var delegate: SendFunctionaAreaName!
    var countryData = [LanguageList]()
    
    var filteredData = [String]()
    var Getdata = [String]()
    var GetDataId = [String]()

    var countryNameData = [String]()
    var countryIdData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                Getdata.append(countryName.jobFunctionalAreaName)
                GetDataId.append(countryName.keywordID)
            }
    }
    
    func setupUI() {
        buttonOkay.addTarget(self, action: #selector(onClickOkayButton), for: .touchUpInside)
        buttonCancel.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
    }
    
    @objc func onClickOkayButton() {

        self.dismiss(animated: true) {
            self.delegate.functionalAreaName(name: self.countryNameData, id: self.countryIdData)
        }
    }
    
    @objc func onClickCancelButton() {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCountryList(){
        WebService3.sharedInstance.jobFunctionalListData(){(result,response,message) in
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
extension FunctionalAreaSearchVC: UITableViewDataSource, UITableViewDelegate {
    
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
            cell.labelName.text = countryData[indexPath.row].jobFunctionalAreaName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true) {
            
            if self.flag == true {
                let CountryName = self.filteredData[indexPath.row]
                
                for cityName in self.countryData {
                        if CountryName == cityName.jobFunctionalAreaName {
                            let countryId = cityName.keywordID
                          
                            self.countryNameData.append(CountryName)
                            self.countryIdData.append(countryId)
                            print("========\(countryNameData)")
                            print("========\(countryIdData)")
                            //self.delegate.countryName(name: CountryName, id: countryId)
                            //self.delegate.countryName(name: CountryName, id: countryId, sortName: sortName, phoneCode: phoneCode, currencyName: currencyName, symbol: symbol)
                        }
                    }
            } else {
                let CountryName = self.countryData[indexPath.row].jobFunctionalAreaName
                let countryId = self.countryData[indexPath.row].keywordID
               
                self.countryNameData.append(CountryName)
                self.countryIdData.append(countryId)
                print("========\(countryNameData)")
                print("========\(countryIdData)")
                //self.delegate.countryName(name: CountryName, id: countryId, sortName: sortName, phoneCode: phoneCode, currencyName: currencyName, symbol: symbol)
            }
        //}
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let CountryName = self.countryData[indexPath.row].jobFunctionalAreaName
        let countryId = self.countryData[indexPath.row].keywordID
        
        countryNameData.removeAll(where: { $0 == CountryName })
        countryIdData.removeAll(where: { $0 == countryId })
    
        print("========\(countryNameData)")
        print("========\(countryIdData)")
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//----------- SearchBar Delegate --------------
extension FunctionalAreaSearchVC: UISearchBarDelegate {
    
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



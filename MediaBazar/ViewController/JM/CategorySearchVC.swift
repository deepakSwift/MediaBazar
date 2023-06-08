//
//  CategorySearchVC.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 13/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendNameOfCategory {
    func CategoryName(text: String, id: String)
}


class CategorySearchVC: UIViewController {
    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    var flag = false
    var delegate: SendNameOfCategory!
    var categoryData = [LanguageList]()
    
    var filteredData = [String]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.delegate = self
        doInitialSetup()
        getCategory()
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
    
    func setupData() {
        for categoryName in categoryData {
            Getdata.append(categoryName.categoryText)
            GetDataId.append(categoryName.categoryID)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.delegate.CategoryName(text: "", id: "")
        })
    }
    
        func getCategory(){
            CommonClass.showLoader()
            Webservice.sharedInstance.categoryListData(){(result,response,message) in
                CommonClass.hideLoader()
                print(result)
                if result == 200{
                    if let somecategory = response{
                        self.categoryData.removeAll()
                        self.categoryData.append(contentsOf: somecategory)
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

extension CategorySearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return categoryData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySearchTableCell", for: indexPath) as! CountrySearchTableCell
        
        if flag == true {
            cell.labelText.text = filteredData[indexPath.row]
        } else {
            cell.labelText.text = categoryData[indexPath.row].categoryText
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            if self.flag == true {
                let name = self.filteredData[indexPath.row]
                
                for categoryName in self.categoryData {
                    if name == categoryName.categoryText {
                        let id = categoryName.categoryID
                        print("========\(name)")
                        print("========\(id)")
                        self.delegate.CategoryName(text: name, id: id)
                    }
                }
            } else {
                let text = self.categoryData[indexPath.row].categoryText
                let id = self.categoryData[indexPath.row].categoryID
                print("========\(text)")
                print("========\(id)")
                self.delegate.CategoryName(text: text, id: id)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------

extension CategorySearchVC: UISearchBarDelegate {
    
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


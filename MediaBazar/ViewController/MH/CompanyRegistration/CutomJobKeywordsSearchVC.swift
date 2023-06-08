//
//  CutomJobKeywordsSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 09/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendJobKeywordName {
    func keywordName(name: [String])
}

class CutomJobKeywordsSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var textFieldAddItem: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOkay: UIButton!
    
    var flag = false
    var dataFlag = false                //flag for add keyword add data
    var delegate: SendJobKeywordName!
    var keywordData = [LanguageList]()
    
    var filteredData = [String]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    var keywordsNameData = [String]()
    var keywordsNameData2 = [String]()
    
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
        buttonAdd.makeRounded()
    }
    
    func setupUI() {
        buttonOkay.addTarget(self, action: #selector(onClickOkayButton), for: .touchUpInside)
         buttonCancel.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
        buttonAdd.addTarget(self, action: #selector(onClickAddButton), for: .touchUpInside)
    }
    
    @objc func onClickOkayButton() {
        self.dismiss(animated: true) {
            
            self.delegate.keywordName(name: self.keywordsNameData)
            
            if self.flag == true {
                self.delegate.keywordName(name: self.keywordsNameData)
            } else if self.flag == false {

            } else {
                self.delegate.keywordName(name: self.keywordsNameData)
            }
        }
    }
    
    @objc func onClickCancelButton() {
         self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickAddButton() {
        keywordsNameData.removeAll()
        if textFieldAddItem.text == "" {
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the keyword.")
        } else {
            if flag == true {
                filteredData.append(textFieldAddItem.text!)
                tableViewCountry.reloadData()
                textFieldAddItem.text = ""
            } else {
                self.dataFlag = true
                keywordsNameData2.append(textFieldAddItem.text!)
                tableViewCountry.reloadData()
                textFieldAddItem.text = ""
            }
        }
    }
    
    func apiCall() {
        CommonClass.showLoader()
        getCategory()
    }
    
    func setupData() {
        for keywordName in keywordData {
            Getdata.append(keywordName.jobKeywordName)
            GetDataId.append(keywordName.keywordID)
        }
        for data in keywordData.enumerated() {
            keywordsNameData2.append(data.element.jobKeywordName)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }
       
       func getCategory(){
           CommonClass.showLoader()
           Webservice.sharedInstance.jobKeywordData(){(result,response,message) in
               CommonClass.hideLoader()
               print(result)
               if result == 200{
                   if let somecategory = response{
                       self.keywordData.removeAll()
                       self.keywordData.append(contentsOf: somecategory)
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
extension CutomJobKeywordsSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else if dataFlag == true {
            return keywordsNameData2.count
        }else {
            return keywordData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomKeywordTableCell", for: indexPath) as! CustomKeywordTableCell
        
        if flag == true {
            cell.labelName.text = filteredData[indexPath.row]
        } else if dataFlag == true {
            cell.labelName.text = keywordsNameData2[indexPath.row]
        }else {
            cell.labelName.text = keywordData[indexPath.row].jobKeywordName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.dismiss(animated: true) {
            
            if self.flag == true {
                let name = self.filteredData[indexPath.row]
                
                for keywordName in self.filteredData {
                    if name == keywordName {
                        let id = keywordName
                        print("========\(name)")
                        print("========\(id)")
                        self.keywordsNameData.append(name)
                        //self.delegate.keywordName(name: self.keywordsNameData)
                    }
                }
            } else if dataFlag == true {
                let name = self.keywordsNameData2[indexPath.row]
                for keywordName in self.keywordsNameData2 {
                    if name == keywordName {
                        let id = keywordName
                        print("========\(name)")
                        print("========\(id)")
                        self.keywordsNameData.append(name)
                        //self.delegate.keywordName(name: self.keywordsNameData)
                    }
                }
            } else {
                let name = self.keywordData[indexPath.row].jobKeywordName
                let id = self.keywordData[indexPath.row].keywordID
                print("========\(name)")
                print("========\(id)")
                self.keywordsNameData.append(self.keywordData[indexPath.row].jobKeywordName)
                //self.delegate.keywordName(name: self.keywordsNameData)
            }
        //}
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        keywordsNameData.append(keywordData[indexPath.row].keywordName)
//        print(keywordsNameData)
//    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let name = keywordData[indexPath.row].jobKeywordName
        keywordsNameData.removeAll(where: { $0 == name })
        print(keywordsNameData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------
extension CutomJobKeywordsSearchVC: UISearchBarDelegate {
    
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



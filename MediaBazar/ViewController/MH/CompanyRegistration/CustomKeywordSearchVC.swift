//
//  CustomKeywordSearchVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendKeywordName {
    func keywordName(name: [String])
}

class CustomKeywordSearchVC: UIViewController {

    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var textFieldAddItem: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOkay: UIButton!
    
    var flag = false
    var dataFlag = false                //flag for add keyword add data
    var delegate: SendKeywordName!
    var keywordData = [LanguageList]()
    var getKeywordsData = [String]()
    
    var filteredData = [String]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    var selectedKeywords = [String]()
    
    var keywordsNameData = [String]()
    var keywordsNameData2 = [String]()
    
    var isAddkeywordData = false
    var savedKeywordsArray = UserDefaults.standard.stringArray(forKey: "keywordArray") ?? [String]()
    
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
                UserDefaults.standard.set(self.keywordsNameData, forKey: "keywordArray")
                
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
                UserDefaults.standard.set(self.keywordsNameData2, forKey: "keywordArray")
                self.isAddkeywordData = true
            }
        }
    }
    
    func apiCall() {
        CommonClass.showLoader()
        getCategory()
    }
    
    func setupData() {
        for keywordName in getKeywordsData {
            Getdata.append(keywordName)
            GetDataId.append(keywordName)
        }
        for data in getKeywordsData.enumerated() {
            keywordsNameData2.append(data.element)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }
       
       func getCategory(){
           CommonClass.showLoader()
           Webservice.sharedInstance.keywordData(){(result,response,message) in
               CommonClass.hideLoader()
               print(result)
               if result == 200{
                   if let somecategory = response{
                       self.keywordData.removeAll()
                       self.keywordData.append(contentsOf: somecategory)
                    //self.keywordData.append(self.savedKeywordsArray)
                    
                    
                    for data in self.keywordData.enumerated() {
                        self.getKeywordsData.append(data.element.keywordName)
                    }
                    
                    
                    if self.savedKeywordsArray.count != 0 {
                        self.getKeywordsData.removeAll()
                        self.getKeywordsData.append(contentsOf: self.savedKeywordsArray)
                    }
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
extension CustomKeywordSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else if dataFlag == true {
            return keywordsNameData2.count
        }else {
            return getKeywordsData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomKeywordTableCell", for: indexPath) as! CustomKeywordTableCell
        
        if flag == true {
            cell.labelName.text = filteredData[indexPath.row]
        } else if dataFlag == true {
            cell.labelName.text = keywordsNameData2[indexPath.row]
        }else {
            cell.labelName.text = getKeywordsData[indexPath.row]
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
                let name = self.getKeywordsData[indexPath.row]
                print("========\(name)")
                self.keywordsNameData.append(self.getKeywordsData[indexPath.row])
                //self.delegate.keywordName(name: self.keywordsNameData)
            }
        //}
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        keywordsNameData.append(keywordData[indexPath.row].keywordName)
//        print(keywordsNameData)
//    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let name = getKeywordsData[indexPath.row]
        keywordsNameData.removeAll(where: { $0 == name })
        print(keywordsNameData)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            func shouldSelect() -> Bool {
                for item in selectedKeywords {
                    if item == getKeywordsData[indexPath.row] {
                        return true
                    }
                }
                return false
            }
            if shouldSelect() {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//----------- SearchBar Delegate --------------
extension CustomKeywordSearchVC: UISearchBarDelegate {
    
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



//
//  CustomTargetAudienceViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 21/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol SendAOIName {
    func keywordName(name: [String], id: [String])
}


class CustomAOIViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableViewCountry: UITableView!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonOkay: UIButton!
    
    var flag = false
    var delegate: SendAOIName!
    var areaOfInterestArea = [LanguageList]()
    
    var filteredData = [String]()
    
    var Getdata = [String]()
    var GetDataId = [String]()
    
    var aoiNameData = [String]()
    var aoiIdData = [String]()
    
    var getAlreddySelectedArray = [String]()
    var getElementArray = [String]()
    var outputArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        searchBarView.isHidden = true
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
    
    func setupUI() {
        buttonOkay.addTarget(self, action: #selector(onClickOkayButton), for: .touchUpInside)
        buttonCancel.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
    }
    
    @objc func onClickOkayButton() {
        self.dismiss(animated: true) {
            self.delegate.keywordName(name: self.aoiNameData, id: self.aoiIdData)
            
        }
    }
    
    @objc func onClickCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func apiCall() {
        CommonClass.showLoader()
        getCategory()
    }
    
    func setupData() {
        for keywordName in areaOfInterestArea {
            Getdata.append(keywordName.categoryText)
            GetDataId.append(keywordName.categoryID)
        }
    }
    
    @IBAction func buttonActionDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getCategory(){
        Webservice.sharedInstance.categoryListData(){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.areaOfInterestArea.removeAll()
                    self.areaOfInterestArea.append(contentsOf: somecategory)
                    
                    //                    for data in self.areaOfInterestArea.enumerated() {
                    //                        self.getElementArray.append(data.element.categoryText)
                    //                    }
                    //                    let fruitsSet = Set(self.getElementArray)
                    //                    let vegSet = Set(self.getAlreddySelectedArray)
                    //                    self.outputArray = Array(fruitsSet.intersection(vegSet))
                    
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
extension CustomAOIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true {
            return filteredData.count
        } else {
            return areaOfInterestArea.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomKeywordTableCell", for: indexPath) as! CustomKeywordTableCell
        
        if flag == true {
            cell.labelName.text = filteredData[indexPath.row]
        } else {
            
            for data in outputArray.enumerated() {
                if areaOfInterestArea[indexPath.row].categoryText == data.element {
                    cell.setSelected(true, animated: true)
                    cell.isSelected = true
                    cell.uiImageCheck.image = #imageLiteral(resourceName: "Group 184")
                    print("=======8888888======")
                }
            }
            
            cell.labelName.text = areaOfInterestArea[indexPath.row].categoryText
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
                    //                    self.aoiNameData.append(name)
                    //                    self.aoiIdData.append(id)
                    if aoiNameData.count <= 8{
                        self.aoiNameData.append(name)
                        self.aoiIdData.append(id)
                    }else {
                        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You can select only 9 area of interest")
                    }
                    //self.delegate.keywordName(name: self.keywordsNameData)
                }
            }
        }  else {
            let name = self.areaOfInterestArea[indexPath.row].categoryText
            let id = self.areaOfInterestArea[indexPath.row].categoryID
            print("========\(name)")
            print("========\(id)")
            //            self.aoiNameData.append(self.areaOfInterestArea[indexPath.row].categoryText)
            //            self.aoiIdData.append(self.areaOfInterestArea[indexPath.row].categoryID)
            
            if aoiNameData.count <= 8{
                self.aoiNameData.append(self.areaOfInterestArea[indexPath.row].categoryText)
                self.aoiIdData.append(self.areaOfInterestArea[indexPath.row].categoryID)
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "You can select only 9 area of interest")
            }
            
            //self.delegate.keywordName(name: self.keywordsNameData)
        }
        //}
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        keywordsNameData.append(keywordData[indexPath.row].keywordName)
    //        print(keywordsNameData)
    //    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let name = areaOfInterestArea[indexPath.row].categoryText
        aoiNameData.removeAll(where: { $0 == name })
        print(aoiNameData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        func shouldSelect() -> Bool {
            for item in getAlreddySelectedArray {
                if item == areaOfInterestArea[indexPath.row].categoryText {
                    return true
                }
            }
            //                locationArray[indexPath.row].location
            return false
        }
        if shouldSelect() {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    
}

//----------- SearchBar Delegate --------------
extension CustomAOIViewController: UISearchBarDelegate {
    
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


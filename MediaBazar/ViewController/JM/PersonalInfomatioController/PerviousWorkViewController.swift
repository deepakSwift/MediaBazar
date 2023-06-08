////
////  PerviousWorkViewController.swift
////  MediaBazar
////
////  Created by Abhinav Saini on 23/12/19.
////  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
////
//
//import UIKit
//
//
//
//class PerviousWorkViewController: UIViewController {
//
//    @IBOutlet weak var buttonBack: UIButton!
//    @IBOutlet weak var perviousWorkTableView : UITableView!
//    @IBOutlet weak var continueButton : UIButton!
//    @IBOutlet weak var addMoreButton : UIButton!
//
//
//    var count = 1
//    var countArray = [1]
//    var journalistId = ""
//    var privoiusWorkArray = PreviousModel()
//    var textFieldValidationFlag = false
//
//    var titleArray = [String]()
//    var titllrLink = [String]()
//
//    var perviusWorkArray = [String]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupButton()
//    }
//
//    func setupButton(){
//        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
//        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
//        addMoreButton.addTarget(self, action: #selector(addMoreWork(sender:)), for: .touchUpInside)
//
//    }
//
//    func setupUI(){
//        self.perviousWorkTableView.dataSource = self
//        self.perviousWorkTableView.delegate = self
//        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
//    }
//
//
////    func scrollToBottom() {
////        DispatchQueue.main.async {
////            let indexPath = IndexPath(row: self.referenceTableView.numberOfRows(inSection: self.referenceTableView.numberOfSections-1) - 1, section: self.referenceTableView.numberOfSections - 1)
////            self.referenceTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
////        }
////    }
//
//
//    @objc func onClickContinueButton(){
////          self.scrollToBottom()
//        var getNoOfCell = perviousWorkTableView.numberOfRows(inSection: 0)
//        var finalString = ""
//        var allField = false
//        var pervoiusWork = [String]()
//        print("getNoOfCell====\(getNoOfCell)")
//        for item in 0..<getNoOfCell{
//            print("cell\(item)")
//            guard let cell = perviousWorkTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? PerviousTableViewCell else { print("cell not found"); return }
//
//            func isValidate()-> Bool {
//
//                if cell.textFieldTitle.text == "" {
//                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the title.")
//                    return false
//                }
//                else if cell.textFieldLink.text == ""{
//                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid link.")
//                    return false
//                }
//
//                else if !(cell.textFieldLink.text?.isValidURL())!  {
//                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the the link.")
//                    return false
//                }
//
//                return true
//            }
//
//            print(isValidate())
//            if isValidate(){
//                allField = true
//                self.titleArray.append(cell.textFieldTitle.text!)
//                self.titllrLink.append(cell.textFieldLink.text!)
//
//                var count = item
//                //            for data in titleArray.enumerated() {             //---For multiple selection
//
//                var dict = Dictionary<String,String>()
//                dict.updateValue(titleArray[count], forKey: "title")
//                dict.updateValue(titllrLink[count], forKey: "link")
//                count += 1
//                let doubleQ = "\""
//                var text = "{"
//                let dictCount = dict.keys.count
//                for (index, element) in dict.enumerated(){
//                    let key = doubleQ+element.key+doubleQ
//                    let value = doubleQ+element.value+doubleQ
//                    text = text+key+":"+value
//                    text = text+((index == dictCount-1) ? "":",")
//                }
//                text = text+"}"
//
//                //        return text
//                print("======================\(text)")
//                pervoiusWork.append(text)
//
//                //            }
//
//                var textNew = "["
//                for index in 0..<pervoiusWork.count {
//                    let item = pervoiusWork[index]
//                    textNew += item
//                    textNew += (index == pervoiusWork.count-1) ? "" : ","
//                }
//                textNew = textNew+"]"
//                finalString = textNew
//                print("-------------------textNew\(textNew)")
//            }else{
//                allField = false
//            }
//        }
//
//        if allField{
//            print("finalString============\(finalString)")
//          getpreviousWork(previousWorks: finalString , journalistId: journalistId, stepCount: "4")
//        }
//
//
//    }
//
//    @objc func pressedBackButton(){
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    //----ApiCall-------
//    func getpreviousWork(previousWorks:String, journalistId: String, stepCount: String){
//        CommonClass.showLoader()
//        Webservice.sharedInstance.previousWorkData(previousWorks: previousWorks, journalistId: journalistId, stepCount: stepCount){(result,response,message) in
//            CommonClass.hideLoader()
//            print(result)
//
//            if result == 200 {
//                if let someCategory = response {
//                    self.privoiusWorkArray = someCategory
//                    self.perviousWorkTableView.reloadData()
//                    let socialMediaVC = AppStoryboard.PreLogin.viewController(SocialMediaLinksViewController.self)
//                    socialMediaVC.journalistId = journalistId
//                    self.navigationController?.pushViewController(socialMediaVC, animated: true)
//                }
//
//            }else {
//                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
//            }
//        }
//    }
//
//}
//
//extension PerviousWorkViewController: UITableViewDataSource,UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("====cell count====\(count)")
//        return countArray.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PerviousTableViewCell") as! PerviousTableViewCell
//
//        //        if indexPath.row == 0 {
//        //            cell.buttonDelete.isHidden = true
//        //        }
//        cell.buttonDelete.tag = indexPath.row
//        cell.buttonDelete.addTarget(self, action: #selector(onclickDeleteButton(sender:)), for: .touchUpInside)
//
//        if indexPath.row < self.titleArray.count{
//        cell.textFieldTitle.text = self.titleArray[indexPath.row]
//        }else {
//            cell.textFieldTitle.text = ""
//        }
//
//        if indexPath.row < self.titllrLink.count{
//        cell.textFieldLink.text = self.titllrLink[indexPath.row]
//        }else {
//            cell.textFieldLink.text = ""
//        }
//
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 260
//    }
//
//    @objc func addMoreWork(sender: UIButton) {
//
//        var getNoOfCell = perviousWorkTableView.numberOfRows(inSection: 0)
//              var finalString = ""
//              var allField = false
//              var pervoiusWork = [String]()
//              print("getNoOfCell====\(getNoOfCell)")
//              for item in 0..<getNoOfCell{
//                  print("cell\(item)")
//                  guard let cell = perviousWorkTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? PerviousTableViewCell else { print("cell not found"); return }
//
//                  func isValidate()-> Bool {
//
//                      if cell.textFieldTitle.text == "" {
//                          NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above pervious work.")
//                          return false
//                      }
//                      else if cell.textFieldLink.text == ""{
//                          NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above pervious work.")
//                          return false
//                      }
//
//                      else if !(cell.textFieldLink.text?.isValidURL())!  {
//                          NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above pervious work.")
//                          return false
//                      }
//
//                      return true
//                  }
//
//                  print(isValidate())
//                  if isValidate(){
//                    allField = true
//
////                    self.titleArray.append(cell.textFieldTitle.text!)
////                    self.titllrLink.append(cell.textFieldLink.text!)
////
////
////                    self.countArray.append(1)
////                    self.perviousWorkTableView.reloadData()
//
//                  }else{
//                      allField = false
//                  }
//              }
//
//              if allField{
//
//                  let index = sender.tag
//                  print("===========addMoreIndex===========\(index)")
//                  countArray.append(1)
//                  perviousWorkTableView.reloadData()
//              }
//
//
//
//
////
////        let index = sender.tag
////        print("===========addMoreIndex===========\(index)")
////        countArray.append(1)
////        perviousWorkTableView.reloadData()
//    }
//
//    @objc func onclickDeleteButton(sender: UIButton) {
//        // create the alert
//        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this previous work", preferredStyle: UIAlertController.Style.alert)
//
//        // add the actions (buttons)
//        alert.addAction(UIAlertAction(title: "DELETE", style: UIAlertAction.Style.destructive, handler: { ACTION in
//            let index = sender.tag
//            self.countArray.remove(at: index)
//            self.perviousWorkTableView.reloadData()
//        }))
//        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//
//        //        let index = sender.tag
//        //        print("==========DeleteButtonIndex=========\(index)")
//        //        countArray.remove(at: index)
//        //        //        let indexPaths = IndexPath(item: index, section: 0)
//        //        //        perviousWorkTableView.deleteRows(at: [indexPaths], with: .fade)
//        //        perviousWorkTableView.reloadData()
//    }
//}
//
//
//




//  PerviousWorkViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 23/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit



class PerviousWorkViewController: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var perviousWorkTableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var addMoreButton : UIButton!
    
    
    var count = 1
    var countArray = [1]
    var journalistId = ""
    var privoiusWorkArray = PreviousModel()
    var textFieldValidationFlag = false
    
    var titleArray = [String]()
    var titllrLink = [String]()
    
    var perviusWorkArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
    }
    
    func setupButton(){
        continueButton.addTarget(self, action: #selector(onClickContinueButton), for: .touchUpInside)
        buttonBack.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        addMoreButton.addTarget(self, action: #selector(addMoreWork(sender:)), for: .touchUpInside)
        
    }
    
    func setupUI(){
        self.perviousWorkTableView.dataSource = self
        self.perviousWorkTableView.delegate = self
        CommonClass.makeViewCircularWithCornerRadius(continueButton, borderColor: .clear, borderWidth: 0, cornerRadius: 20)
    }
    
    @objc func onClickContinueButton(){
        
        var getNoOfCell = self.perviousWorkTableView.numberOfRows(inSection: 0)
        var lastIndex = getNoOfCell - 1
        var finalString = ""
        var allField = false
        var pervoiusWork = [String]()
        print("getNoOfCell====\(getNoOfCell)")
        for item in 0..<getNoOfCell{
            print("cell\(item)")
            guard let cell = self.perviousWorkTableView.cellForRow(at: IndexPath(row: lastIndex, section: 0)) as? PerviousTableViewCell else { print("cell not found"); return }
            
            func isValidate()-> Bool {
                if cell.textFieldTitle.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the title.")
                    return false
                }
                else if cell.textFieldLink.text == ""{
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the valid link.")
                    return false
                }
                    
                else if !(cell.textFieldLink.text?.isValidURL())!  {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the the link.")
                    return false
                }
                
                return true
            }
            // print(isValidate())
            if isValidate() {
                allField = true
                if item == lastIndex {
                    self.titleArray.append(cell.textFieldTitle.text!)
                    self.titllrLink.append(cell.textFieldLink.text!)
                }
                
                
                var count = item
                // for data in titleArray.enumerated() { //---For multiple selection
                
                var dict = Dictionary<String,String>()
                
                dict.updateValue(titleArray[count], forKey: "title")
                dict.updateValue(titllrLink[count], forKey: "link")
                count += 1
                let doubleQ = "\""
                var text = "{"
                let dictCount = dict.keys.count
                for (index, element) in dict.enumerated(){
                    let key = doubleQ+element.key+doubleQ
                    let value = doubleQ+element.value+doubleQ
                    text = text+key+":"+value
                    text = text+((index == dictCount-1) ? "":",")
                }
                text = text+"}"
                
                //        return text
                print("======================\(text)")
                pervoiusWork.append(text)
                
                //            }
                
                var textNew = "["
                for index in 0..<pervoiusWork.count {
                    let item = pervoiusWork[index]
                    textNew += item
                    textNew += (index == pervoiusWork.count-1) ? "" : ","
                }
                textNew = textNew+"]"
                finalString = textNew
                print("-------------------textNew\(textNew)")
                
            }else {
                allField = false
                // validateAddButton = false
            }
        }
        
        if allField {
            print("finalString============\(finalString)")
            if getNoOfCell >= 3{
//            if finalString.count == 2{
                getpreviousWork(previousWorks: finalString , journalistId: journalistId, stepCount: "4")
            }else {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "Minimum three previous work is required")
            }
//            getpreviousWork(previousWorks: finalString , journalistId: journalistId, stepCount: "4")
        }
        
        
        
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.perviousWorkTableView.numberOfRows(inSection: self.perviousWorkTableView.numberOfSections-1) - 1, section: self.perviousWorkTableView.numberOfSections - 1)
            self.perviousWorkTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //----ApiCall-------
    func getpreviousWork(previousWorks:String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.previousWorkData(previousWorks: previousWorks, journalistId: journalistId, stepCount: stepCount){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            
            if result == 200 {
                if let someCategory = response {
                    self.privoiusWorkArray = someCategory
                    self.perviousWorkTableView.reloadData()
                    let socialMediaVC = AppStoryboard.PreLogin.viewController(SocialMediaLinksViewController.self)
                    socialMediaVC.journalistId = journalistId
                    self.navigationController?.pushViewController(socialMediaVC, animated: true)
                }
                
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}


extension PerviousWorkViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("====cell count====\(count)")
        return countArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerviousTableViewCell") as! PerviousTableViewCell
        
        if indexPath.row == 0 {
            cell.buttonDelete.isHidden = true
        }else {
            cell.buttonDelete.isHidden = false
        }
        cell.buttonDelete.tag = indexPath.row
        cell.buttonDelete.addTarget(self, action: #selector(onclickDeleteButton(sender:)), for: .touchUpInside)
        
        if indexPath.row < self.titleArray.count{
            cell.textFieldTitle.text = self.titleArray[indexPath.row]
        }else{
            cell.textFieldTitle.text = ""
        }
        
        if indexPath.row < self.titllrLink.count{
            cell.textFieldLink.text = self.titllrLink[indexPath.row]
        }else {
            cell.textFieldLink.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    @objc func addMoreWork(sender: UIButton) {
        
        
        var numOfCell = self.perviousWorkTableView.numberOfRows(inSection: 0)
        var lastIndex = numOfCell - 1
        var allField = false
        
        print("numOfCell ==== \(numOfCell)")
        
        guard let cell = self.perviousWorkTableView.cellForRow(at: IndexPath(row: lastIndex, section: 0)) as? PerviousTableViewCell else { print("cell not found"); return }
        
        func isValidate()-> Bool {
            if cell.textFieldTitle.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above pervious work.")
                return false
            }
            else if cell.textFieldLink.text == "" {
                NKToastHelper.sharedInstance.showErrorAlert(self, message: "First fill the above pervious work.")
                return false
            }
            
            return true
        }
        
        // print(isValidate())
        
        if isValidate() {
            allField = true
            if let nameA = self.titleArray.last, let nameC = cell.textFieldTitle.text, nameA == nameC,
                let middleA = self.titllrLink.last, let middleC = cell.textFieldLink.text, middleA == middleC{
                
                self.countArray.append(1)
                self.perviousWorkTableView.reloadData()
                
                return
            }
            
            self.titleArray.append(cell.textFieldTitle.text!)
            self.titllrLink.append(cell.textFieldLink.text!)
            
            
            self.countArray.append(1)
            self.perviousWorkTableView.reloadData()
        } else {
            allField = false
        }
        //        let index = sender.tag
        //        print("===========addMoreIndex===========\(index)")
        //        countArray.append(1)
        //        perviousWorkTableView.reloadData()
    }
    
    @objc func onclickDeleteButton(sender: UIButton) {
        let index = sender.tag
        print("==========DeleteButtonIndex=========\(index)")
        // countArray.remove(at: index)
        // referenceTableView.reloadData()
        
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this previous work", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "DELETE", style: UIAlertAction.Style.destructive, handler: { ACTION in
            let index = sender.tag
            self.countArray.remove(at: index)
            
            if index < self.titleArray.count{
                self.titleArray.remove(at: index)
            }
            
            if index < self.titllrLink.count{
                self.titllrLink.remove(at: index)
            }
            
            self.perviousWorkTableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}



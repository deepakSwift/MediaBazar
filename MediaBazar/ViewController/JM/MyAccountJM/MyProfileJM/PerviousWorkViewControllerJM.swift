//
//  PerviousWorkViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 30/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


class PerviousWorkViewControllerJM: UIViewController {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var perviousWorkTableView : UITableView!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var addMoreButton : UIButton!

    
    var count = 1
    var countArray = [1]
    var journalistId = ""
//    var privoiusWorkArray = PreviousModel()
    var privoiusWorkArray = profileModal()
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
        
        var getNoOfCell = perviousWorkTableView.numberOfRows(inSection: 0)
        var finalString = ""
        var pervoiusWork = [String]()
        print("getNoOfCell====\(getNoOfCell)")
        for item in 0..<getNoOfCell{
            print("cell\(item)")
            guard let cell = perviousWorkTableView.cellForRow(at: IndexPath(row: item, section: 0)) as? PerviousTableViewCell else { print("cell not found"); return }
            
            func isValidate()-> Bool {
                
                if cell.textFieldTitle.text == "" {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the title.")
                    return false
                }
                else if !(cell.textFieldLink.text?.isValidURL())!  {
                    NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter the the link.")
                    return false
                }

                return true
            }
            
            self.titleArray.append(cell.textFieldTitle.text!)
            self.titllrLink.append(cell.textFieldLink.text!)
            
            var count = item
//            for data in titleArray.enumerated() {             //---For multiple selection
                
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

        
        }
        
        
//        if isValidate() {
        print("finalString============\(finalString)")
        getpreviousWork(previousWorks: finalString , journalistId: privoiusWorkArray.id, stepCount: "4")
//        }
  

        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //----ApiCall-------
    func getpreviousWork(previousWorks:String, journalistId: String, stepCount: String){
        CommonClass.showLoader()
        Webservice.sharedInstance.updatePreviousWorkData(previousWorks: previousWorks, journalistId: journalistId, stepCount: stepCount){(result,response,message) in
            CommonClass.hideLoader()
            print(result)
            
            if result == 200 {
                if let someCategory = response {
                    self.privoiusWorkArray = someCategory
                    self.perviousWorkTableView.reloadData()
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else {
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
}

extension PerviousWorkViewControllerJM: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("====cell count====\(count)")
        return privoiusWorkArray.previousWorks.count
//        return countArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerviousTableViewCell") as! PerviousTableViewCell
        
//        cell.buttonDelete.tag = indexPath.row
        cell.buttonDelete.addTarget(self, action: #selector(onclickDeleteButton(sender:)), for: .touchUpInside)
        
        let arrdata = privoiusWorkArray.previousWorks[indexPath.row]
        cell.textFieldTitle.text = arrdata.title
        cell.textFieldLink.text = arrdata.link
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    @objc func addMoreWork(sender: UIButton) {
        let index = sender.tag
        print("===========addMoreIndex===========\(index)")
//        countArray.append(1)
        let tempModal = categoryTypeModal()
        privoiusWorkArray.previousWorks.append(tempModal)
        perviousWorkTableView.reloadData()
    }
    
    @objc func onclickDeleteButton(sender: UIButton) {
        let index = sender.tag
        print("==========DeleteButtonIndex=========\(index)")
        privoiusWorkArray.previousWorks.remove(at: index)
//        countArray.remove(at: index)
        //        let indexPaths = IndexPath(item: index, section: 0)
        //        perviousWorkTableView.deleteRows(at: [indexPaths], with: .fade)
        perviousWorkTableView.reloadData()
    }
}


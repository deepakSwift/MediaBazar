//
//  RegistrationPlanViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 24/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class RegistrationPlanViewController: UIViewController {
    
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var plansTableView : UITableView!
    
    var registrationPlan = [registrationFeePlansListModal]()
    var journalistID = ""
    var amount = ""
    
    var jourTokenByRegister = ""
    var jourTokenFlowSet = ""
    var newUserSignUp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupUI()
        setupButton()
        apiCall()

    }
    
    func setUpTableView(){
        plansTableView.dataSource = self
        plansTableView.delegate = self
        plansTableView.bounces = false
        plansTableView.alwaysBounceVertical = false
        plansTableView.rowHeight = UITableView.automaticDimension
        plansTableView.estimatedRowHeight = 1000

    }
    
    func apiCall(){
        getRegistrationPlansList()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)

    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickBuyButton(sender : UIButton){
        let paytmMethodVC = AppStoryboard.Journalist.viewController(PayNowViewControllerJM.self)
        let price = registrationPlan[sender.tag].price
        paytmMethodVC.amount = price
        paytmMethodVC.journalistId = journalistID
        paytmMethodVC.forRegistrationFee = "registrationFee"
        paytmMethodVC.jourTokenByRegister = jourTokenByRegister
        paytmMethodVC.jourTokenFlowSet = "flowSetByApproved"
        paytmMethodVC.newUserSignUp = "membershipPlan"
        self.navigationController?.pushViewController(paytmMethodVC, animated: true)
    }
    
    func getRegistrationPlansList(){
        CommonClass.showLoader()
        Webservices.sharedInstance.getRegistrationFeePlansListing(){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                if let somecategory = response{
                    self.registrationPlan.append(contentsOf: somecategory)
                    self.plansTableView.reloadData()
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

extension RegistrationPlanViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrationPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationFeePlansListTableViewCell") as! RegistrationFeePlansListTableViewCell
        let arrdata = registrationPlan[indexPath.row]
        cell.namelabel.text = arrdata.name
        cell.priceLabel.text = arrdata.price
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget(self, action: #selector(onClickBuyButton(sender:)), for: .touchUpInside)
        return cell
    }
    
    
}

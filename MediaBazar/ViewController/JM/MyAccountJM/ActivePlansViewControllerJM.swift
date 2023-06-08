//
//  ActivePlansViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ActivePlansViewControllerJM: UIViewController {
    
    @IBOutlet weak var plansTAbleView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var plans = paymentsModal()
    var upgradePrice = ""
    var planPrice = ""
    var currentUserLogin : User!
    var purchaseNewMembership = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpTableView()
        setUpUI()
        setUpButton()
        setUpData()
        self.currentUserLogin = User.loadSavedUser()
        getPlansList(header: currentUserLogin.token)
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.plansTAbleView.dataSource = self
        self.plansTAbleView.delegate = self
    }
    
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
    }
    
    func setUpData(){
        
        for upgradePrice in plans.activePlans.enumerated(){
            let data = upgradePrice.element.membershipId.membershipPrice
            self.planPrice = data
            print("planPrice====\(planPrice)")
        }
    
        for price in plans.allPlan.enumerated(){
            let data = price.element.membershipPrice
            self.planPrice = data
            print("planPrice====\(planPrice)")
            
        }
        
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnUpgradeButton(sender : UIButton){
        let memberShipId = plans.activePlans[sender.tag].membershipId.id
        print("memberShipId======\(memberShipId)")
        let paymentPlanSVC = AppStoryboard.Journalist.viewController(PaymentsModeViewControllerJM.self)
        paymentPlanSVC.memberShipID = memberShipId
        paymentPlanSVC.price = upgradePrice
        self.navigationController?.pushViewController(paymentPlanSVC, animated: true)
        
    }
    
    @objc func clickOnBuyButton(sender : UIButton){
        let memberShipId = plans.allPlan[sender.tag].id
        print("memberShipId======\(memberShipId)")
        let paymentPlanSVC = AppStoryboard.Journalist.viewController(PaymentsModeViewControllerJM.self)
        paymentPlanSVC.memberShipID = memberShipId
        paymentPlanSVC.price = planPrice
        self.navigationController?.pushViewController(paymentPlanSVC, animated: true)
    }
    
        func getPlansList(header : String){
            Webservices.sharedInstance.plansList(Header: header){(result,message,response) in
                print(result)
                if result == 200{
                    if let somecategory = response{
                        self.plans = somecategory
                        self.plansTAbleView.reloadData()
    //                    self.calculateTime()
                        self.setUpData()
                        print("\(somecategory)")
                    } else{
                        
                    }
                }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
    
    
}

extension ActivePlansViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
//            if plans.activePlans.count == 0{
//                return 0
//            }else {
////                return 1
//                return plans.activePlans.count
//            }
            return plans.activePlans.count

        } else {
            return plans.allPlan.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentPlanTableViewCellJM") as! CurrentPlanTableViewCellJM
//            if plans.activePlans.count == 0{
//
//            } else {
////                let aardata = plans.activePlans[0]
//                let aardata = plans.activePlans[indexPath.row]
//                cell.memberShipName.text = aardata.membershipId.membershipName
//                cell.memberShipPrice.text = "$\(aardata.membershipId.membershipPrice)"
//                cell.memberShipDuration.text = aardata.membershipId.membershipDuration
//                cell.memberShipExpireData.text = "Expires on\(aardata.expiryTime.prefix(10))"
//                cell.upgrateButton.tag = indexPath.row
//                cell.upgrateButton.addTarget(self, action: #selector(clickOnUpgradeButton(sender:)), for: .touchDown)
//            }
            
            let aardata = plans.activePlans[indexPath.row]
            cell.memberShipName.text = aardata.membershipId.membershipName
            cell.memberShipPrice.text = "$\(aardata.membershipId.membershipPrice)"
            cell.memberShipDuration.text = aardata.membershipId.membershipDuration
            cell.memberShipExpireData.text = "Expires on\(aardata.expiryTime.prefix(10))"
            cell.upgrateButton.tag = indexPath.row
            cell.upgrateButton.addTarget(self, action: #selector(clickOnUpgradeButton(sender:)), for: .touchDown)

            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveMemberShipPlanTableViewCell") as! ActiveMemberShipPlanTableViewCell
            let arrdata = plans.allPlan[indexPath.row]
            cell.membershipNAme.text = arrdata.membershipName
            cell.memberShipDiscri.text = "\(arrdata.membershipDuration) Plan"
            cell.memberShipPrice.text = "$\(arrdata.membershipPrice)"
            cell.memberShipDuration.text = arrdata.membershipDuration
            cell.buyButton.tag = indexPath.row
            cell.buyButton.addTarget(self, action: #selector(clickOnBuyButton(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
}

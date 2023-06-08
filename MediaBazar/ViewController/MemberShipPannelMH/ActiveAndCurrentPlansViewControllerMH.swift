//
//  ActiveAndCurrentPlansViewControllerMH.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 29/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ActiveAndCurrentPlansViewControllerMH: UIViewController {
    
    @IBOutlet weak var plansTAbleView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var plans = paymentsModal()
    var upgradePrice = ""
    var planPrice = ""
    var currentUserLogin : User!
    var planExpiryDate = ""
    var planCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpTableView()
        setUpUI()
        setUpButton()
        setUpData()
        self.currentUserLogin = User.loadSavedUser()
        getMemberPlansList(header: currentUserLogin.mediahouseToken)
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.plansTAbleView.dataSource = self
        self.plansTAbleView.delegate = self
    }
    
    func calculateTimeDurationBetweenDate() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let formatedStartDate = dateFormatter.date(from: planExpiryDate)
        let currentDate = Date()
        let dayCount = Set<Calendar.Component>([.day])
        let hourCount = Set<Calendar.Component>([.hour])
        let monthCount = Set<Calendar.Component>([.month])
        let differenceOfDay = Calendar.current.dateComponents(dayCount, from: currentDate, to: formatedStartDate!)
        let differenceOfTimes = Calendar.current.dateComponents(hourCount, from: currentDate, to: formatedStartDate!)
        let differenceOfMonth = Calendar.current.dateComponents(monthCount, from: currentDate, to: formatedStartDate!)
        
        print(differenceOfTimes.hour!)
        print(differenceOfDay.day!)
        print(differenceOfMonth.month!)
        
        if differenceOfMonth.month ?? 0 <= 3 {
            print(differenceOfMonth.month!)
            planCount = 1
        } else {
            print(differenceOfMonth.month!)
            planCount = 0
        }
        
        self.plansTAbleView.reloadData()
        
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
        }
        
        for price in plans.allPlan.enumerated(){
            let data = price.element.membershipPrice
            self.planPrice = data
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
        paymentPlanSVC.paymentMediaMembership = "mediaMembershipPayment"
        self.navigationController?.pushViewController(paymentPlanSVC, animated: true)
        
    }
    
    @objc func clickOnBuyButton(sender : UIButton){
        let memberShipId = plans.allPlan[sender.tag].id
        print("memberShipId======\(memberShipId)")
        let paymentPlanSVC = AppStoryboard.Journalist.viewController(PaymentsModeViewControllerJM.self)
        paymentPlanSVC.memberShipID = memberShipId
        paymentPlanSVC.price = planPrice
        paymentPlanSVC.paymentMediaMembership = "mediaMembershipPayment"
        self.navigationController?.pushViewController(paymentPlanSVC, animated: true)
    }
    
    func getMemberPlansList(header : String){
        Webservices.sharedInstance.getMediaMemberPlansList(Header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.plans = somecategory
                    self.planExpiryDate = self.plans.activePlans[0].expiryTime
                    //self.plansTAbleView.reloadData()
                    self.setUpData()
                    self.calculateTimeDurationBetweenDate()
                    print("\(somecategory)")
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}

extension ActiveAndCurrentPlansViewControllerMH : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
         
            return plans.activePlans.count
            
        } else {
            return planCount
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
            self.planExpiryDate = aardata.expiryTime
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

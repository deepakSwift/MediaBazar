//
//  MembershipPlanViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 28/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class MembershipPlanViewControllerJM: UIViewController {
    
    @IBOutlet weak var memberShipTbleView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    
    var plansList = paymentsModal()
    var currentUserLogin : User!
    var planPrice = ""
    
    var signUpToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpUI()
        setUpButton()
        setUpTableView()
        self.currentUserLogin = User.loadSavedUser()
//        getPlansList(header: currentUserLogin.token)
        getPlansList(header: currentUserLogin.token)
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        self.memberShipTbleView.dataSource = self
        self.memberShipTbleView.delegate = self
    }
    
    func setUpUI(){
        topView.applyShadow()
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(clickOnBackButtton), for: .touchUpInside)
    }
    
    func setUpData(){
        for price in plansList.allPlan.enumerated(){
            let data = price.element.membershipPrice
            self.planPrice = data
            print("planPrice====\(planPrice)")
        }
    }
    
    @objc func clickOnBackButtton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickOnBuyButton(sender: UIButton){
        let memberShipId = plansList.allPlan[sender.tag].id
        print("memberShipId======\(memberShipId)")
        if plansList.activePlans.count == 0{
            let paymentPlanSVC = AppStoryboard.Journalist.viewController(PaymentsModeViewControllerJM.self)
            paymentPlanSVC.memberShipID = memberShipId
            paymentPlanSVC.price = planPrice
            paymentPlanSVC.signupToken = signUpToken
            self.navigationController?.pushViewController(paymentPlanSVC, animated: true)
        }else {
            let activePlansVC = AppStoryboard.Journalist.viewController(ActivePlansViewControllerJM.self)
            activePlansVC.plans =  plansList
            self.navigationController?.pushViewController(activePlansVC, animated: true)
        }
    }
    
    func getPlansList(header : String){
        Webservices.sharedInstance.plansList(Header: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.plansList = somecategory
                    self.memberShipTbleView.reloadData()
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


extension MembershipPlanViewControllerJM : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plansList.allPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipPlanTableViewCellJM") as! MembershipPlanTableViewCellJM
        let arrdata = plansList.allPlan[indexPath.row]
        cell.memberShipName.text = arrdata.membershipName
        cell.memberShipDiscri.text = "\(arrdata.membershipDuration) Plan"
        cell.memberShipPrice.text = "USD\(arrdata.membershipPrice)/"
        cell.memberShipDuration.text = arrdata.membershipDuration
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget(self, action: #selector(clickOnBuyButton), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
}

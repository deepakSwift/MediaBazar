//
//  ColloborationGroupDetailControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 08/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ColloborationGroupDetailControllerJM: UIViewController {
    
    @IBOutlet weak var groupDetailTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var buttonView : UIView!
    
    @IBOutlet weak var groupImage : UIImageView!
    @IBOutlet weak var groupName : UILabel!
    @IBOutlet weak var createLabel : UILabel!
    @IBOutlet weak var dateUilabel : UILabel!
    
    @IBOutlet weak var confirmButton : UIButton!
    @IBOutlet weak var removeButton : UIButton!
    @IBOutlet weak var exitGroupButton : UIButton!
    
    
    
    var groupDetail = storyListModal()
    var time = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currentUserLogin : User!
    var hideButtonView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupButton()
        setupTableView()
        setupData()
        self.currentUserLogin = User.loadSavedUser()
        
    }
    
    func setupUI(){
        topView.applyShadow()
        removeButton.makeRoundCorner(20)
        confirmButton.makeRoundCorner(20)
        if hideButtonView == "hideView"{
            buttonView.isHidden = true
        }else {
            buttonView.isHidden = false
        }
    }
    
    func setupData(){
        self.groupName.text = groupDetail.collaborationGroupName
        self.createLabel.text = ("\(groupDetail.userId.firstName) \(groupDetail.userId.lastName)")
        self.dateUilabel.text = ("\(groupDetail.updatedAt.prefix(9)) | \(time)")
        
        let getProfileUrl = "\(self.baseUrl)\(groupDetail.collaborationGroupProfile)"
        let url = NSURL(string: getProfileUrl)
        self.groupImage.sd_setImage(with: url! as URL)
        
        
    }
    
    func setupTableView(){
        self.groupDetailTableView.dataSource = self
        self.groupDetailTableView.delegate = self
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(pressedConfirmButton(sender:)), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(pressedRemoveButton), for: .touchUpInside)
        exitGroupButton.addTarget(self, action: #selector(pressedExitGroupButton), for: .touchUpInside)
        
    }
    
    @objc func pressedBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressedConfirmButton(sender : UIButton){
   
        requestAcceptReject(groupID: groupDetail.id, status: "1", header: currentUserLogin.token)
    }
    
    @objc func pressedRemoveButton(){
        let collobartionVC = AppStoryboard.Journalist.viewController(CollaborationViewControllerJM.self)
                requestAcceptReject(groupID: groupDetail.id, status: "0", header: currentUserLogin.token)
        self.navigationController?.pushViewController(collobartionVC, animated: true)
    }
    
    @objc func pressedExitGroupButton(){
        leaveGroup(groupID: groupDetail.id, header: currentUserLogin.token)
    }
    
    func requestAcceptReject(groupID : String, status: String, header: String){
        Webservices.sharedInstance.requestAcceptRejectGroup(groupID: groupID, status: status, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                self.groupDetailTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    
    func leaveGroup(groupID: String, header: String){
        Webservices.sharedInstance.leaveGroup(groupID: groupID, header: header){(result,message,response) in
            CommonClass.hideLoader()
            print(result)
            if result == 200 {
                self.groupDetailTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
}


extension ColloborationGroupDetailControllerJM : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupDetail.members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColloborationGroupDetailTableViewCellJM") as! ColloborationGroupDetailTableViewCellJM
        let arrdata = groupDetail.members[indexPath.row]
        cell.memberNameLabel.text = ("\(arrdata.journalistId.firstName) \(arrdata.journalistId.lastName)")
        let getProfileUrl = "\(self.baseUrl)\(arrdata.journalistId.profilePic)"
        let url = NSURL(string: getProfileUrl)
        cell.memberImage.sd_setImage(with: url! as URL)
        if arrdata.type == "invited"{
            cell.typeButton.setTitle(arrdata.type, for: .normal)
            cell.typeButton.tintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.typeButton.makeBorder(1, color: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))
        }else {
            cell.typeButton.setTitle(arrdata.type, for: .normal)
            cell.typeButton.tintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.typeButton.makeBorder(1, color: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

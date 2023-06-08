//
// LiveVideoShowViewController.swift
// MediaBazar
//
// Created by Abhinav Saini on 28/05/20.
// Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class LiveVideoShowViewController: UIViewController, BambuserPlayerDelegate, DataFromCellToMainController {
    
    
    @IBOutlet weak var commentTableView : UITableView!
    @IBOutlet weak var backButton : UIButton!
    
    var bambuserPlayer: BambuserPlayer
    var playButton: UIButton
    var pauseButton: UIButton
    var rewindButton: UIButton
    
    var assignmentVideoID = ""
    var assignmentHeadline = ""
    var commentList = EventListModel()
    var currentUserLogin : User!
    var commentCount = ""
    var baseUrl = "https://apimediaprod.5wh.com/"
    var msgText = ""
    
    
    // let ticks = Date().ticks
    
    required init?(coder aDecoder: NSCoder) {
        bambuserPlayer = BambuserPlayer()
        playButton = UIButton(type: UIButton.ButtonType.system)
        pauseButton = UIButton(type: UIButton.ButtonType.system)
        rewindButton = UIButton(type: UIButton.ButtonType.system)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
        
        bambuserPlayer.delegate = self
        bambuserPlayer.applicationId = "Q0iV21kBnJLUFgoxn5Vncw"
        
        bambuserPlayer.playVideo(getURL(broadcastId: "cdd2d5da-672a-4ff7-8be9-c126b84449d5"))
        // bambuserPlayer.playVideo(getURL(broadcastId: <#T##String#>))
        // bambuserPlayer.playVideo("https://cdn.bambuser.net/broadcasts/ec968ec1-2fd9-f8f3-4f0a-d8e19dccd739?da_signature_method=HMAC-SHA256&da_id=432cebc3-4fde-5cbb-e82f-88b013140ebe&da_timestamp=1456740399&da_static=1&da_ttl=0&da_signature=8e0f9b98397c53e58f9d06d362e1de3cb6b69494e5d0e441307dfc9f854a2479")
        //
        // bambuserPlayer.playVideo("https://cdn.bambuser.net/broadcasts/cdd2d5da-672a-4ff7-8be9-c126b84449d5?da_signature_method=HMAC-SHA256&da_id=1028798a-b3c0-36ed-521d-bccb1e99c1ec&da_timestamp=1456740399&da_static=1&da_ttl=0&da_signature=6609dfb6c199eb7004cba3e02ce594906cd2e69b99da9ca817b0f8beef14605c")
        
        
        
        self.view.addSubview(bambuserPlayer)
        playButton.setTitle("Play", for: UIControl.State.normal)
        playButton.addTarget(bambuserPlayer, action: #selector(BambuserPlayer.playVideo as (BambuserPlayer) -> () -> Void), for: UIControl.Event.touchUpInside)
        self.view.addSubview(playButton)
        pauseButton.setTitle("Pause", for: UIControl.State.normal)
        pauseButton.addTarget(bambuserPlayer, action: #selector(BambuserPlayer.pauseVideo as (BambuserPlayer) -> () -> Void), for: UIControl.Event.touchUpInside)
        self.view.addSubview(pauseButton)
        rewindButton.setTitle("Rewind", for: UIControl.State.normal)
        rewindButton.addTarget(self, action: #selector(LiveVideoShowViewController.rewind), for: UIControl.Event.touchUpInside)
        self.view.addSubview(rewindButton)
        
        //=============
        
        setUpButton()
        setupTableView()
        self.currentUserLogin = User.loadSavedUser()
        apiCall()
        
    }
    
    func getURL(broadcastId: String) -> String {
        let broadcastID = broadcastId
        let daID = "1028798a-b3c0-36ed-521d-bccb1e99c1ec"
        let timeStamp = Int(Date().timeIntervalSince1970)
        let daSignatureMethod = "HMAC-SHA256"
        let da_secret_key = "71f546ed8b855bff9ec63588d025e89d82a7c47c"
        let uri = "https://cdn.bambuser.net/broadcasts/\(broadcastID)?da_signature_method=\(daSignatureMethod)&da_id=\(daID)&da_timestamp=\(timeStamp)&da_static=1&da_ttl=0"
        print("uri --- \(uri)")
        let stringToSign = "GET " + uri
        let signature = stringToSign.hmac(key: da_secret_key)
        print("signature --- \(signature)")
        let finalURI = uri + "&da_signature=" + signature
        print("finalURI --- \(finalURI)")
        return finalURI
    }
    
    @objc func rewind() {
        bambuserPlayer.seek(to: 0.0);
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarOffset = self.topLayoutGuide.length
        bambuserPlayer.frame = CGRect(x: 0, y: 120 + statusBarOffset, width: self.view.bounds.size.width, height: 200)
        playButton.frame = CGRect(x: 20, y: 140 + statusBarOffset, width: 100, height: 40)
        pauseButton.frame = CGRect(x: 20, y: 160 + statusBarOffset, width: 100, height: 40)
        rewindButton.frame = CGRect(x: 20, y: 180 + statusBarOffset, width: 100, height: 40)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playbackStatusChanged(_ status: BambuserPlayerState) {
        switch status {
        case kBambuserPlayerStatePlaying:
            playButton.isEnabled = false
            pauseButton.isEnabled = true
            break
            
        case kBambuserPlayerStatePaused:
            playButton.isEnabled = true
            pauseButton.isEnabled = false
            break
            
        case kBambuserPlayerStateStopped:
            playButton.isEnabled = true
            pauseButton.isEnabled = false
            break
            
        case kBambuserPlayerStateError:
            NSLog("Failed to load video for %@", bambuserPlayer.resourceUri);
            break
            
        default:
            break
        }
    }
    
    func apiCall(){
        getVideoComment(assignmentID: assignmentVideoID, header: currentUserLogin.mediahouseToken)
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    func setupTableView() {
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        self.commentTableView.bounces = false
        self.commentTableView.alwaysBounceVertical = false
        self.commentTableView.rowHeight = UITableView.automaticDimension
        self.commentTableView.estimatedRowHeight = 1000
        self.commentTableView.reloadData()
        
    }
    
    // @objc func onClickAddButton(sender: UIButton) {
    // sender.isSelected = !sender.isSelected
    // if sender.isSelected == true {
    // checkButtonFlag = true
    // } else {
    // checkButtonFlag = false
    // }
    // }
    
    func backButtonPressed() {
    }
    
    func clickOnMsgSendButton(message: String) {
        if message == ""{
            NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter message")
        }else {
            addComent(assignmentID: assignmentVideoID, message: message, header: currentUserLogin.mediahouseToken)
        }
    }
    
    // func clickOnMsgSendButton() {
    //
    // guard let cell = commentTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? PurchaseVideoCommentTableViewCell else { print("cell not found"); return }
    //
    // guard let msg = cell.messageTextField.text, msg != "" else {
    // NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter message")
    // return
    // }
    //
    // addComent(assignmentID: assignmentVideoID, message: msg, header: currentUserLogin.mediahouseToken)
    //
    // }
    
    
    
    // @objc func onClickSendButton(){
    // if let cell = commentTableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? PurchaseVideoCommentTableViewCell {
    //
    // func isValidate()-> Bool {
    // if cell.messageTextField.text == "" {
    // NKToastHelper.sharedInstance.showErrorAlert(self, message: "Please enter message .")
    // return false
    // }
    // return true
    // }
    //
    // if isValidate() {
    // addComent(assignmentID: assignmentVideoID, message: cell.messageTextField.text!, header: currentUserLogin.mediahouseToken)
    // }
    //
    // }
    
    
    // }
    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getVideoComment(assignmentID : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.getCommentVideoList(assignmentID: assignmentID, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                if let somecategory = response{
                    self.commentList = somecategory
                    self.commentCount = "\(self.commentList.total)"
                    self.commentTableView.reloadData()
                } else{
                    
                }
            }else{
                self.commentTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    func addComent(assignmentID : String,message : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.addCommentVidep(assignmentID: assignmentID, message: message, header: header){(result,message,response) in
            print(result)
            CommonClass.hideLoader()
            if result == 200{
                self.commentTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                self.commentTableView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    
    
    
}

extension LiveVideoShowViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 1
        }else if section == 2{
            return 1
        }else {
            return commentList.docs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseliveVideoDetailTableViewCell") as! PurchaseliveVideoDetailTableViewCell
            cell.headlineLabel.text = assignmentHeadline
            return cell
        } else if indexPath.row == 1{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "PurchaseVideoCommentTableViewCell") as! PurchaseVideoCommentTableViewCell
            cell1.delegate = self
            cell1.commentCount.text = "Comment(\(commentCount))"
            return cell1
        }else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "GetPurchaseVideoCommentTableViewCell") as! GetPurchaseVideoCommentTableViewCell
            let arrdata = commentList.docs[indexPath.row]
            
            let getProfileUrl = "\(self.baseUrl)\(arrdata.mediahouseId.logo)"
            if let profileUrls = NSURL(string: (getProfileUrl)) {
                cell2.profileImage.sd_setImage(with: profileUrls as URL, placeholderImage: #imageLiteral(resourceName: "user"))
            }
            cell2.namelabel.text = "\(arrdata.mediahouseId.firstName) \(arrdata.mediahouseId.middleName) \(arrdata.mediahouseId.lastName)"
            cell2.messageLabel.text = arrdata.message
            cell2.dateLabel.text = String(arrdata.createdAt.prefix(10))
            return cell2
        }
    }
    
    
}

//extension Date {
//var ticks: UInt64 {
//return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
//}
//}

//extension Date {
// static var currentTimeStamp: Int64{
// return Int64(Date().timeIntervalSince1970 * 1000)
// }
//}






//
// LiveViewControllerJM.swift
// MediaBazar
//
// Created by Abhinav Saini on 10/01/20.
// Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit


class LiveViewControllerJM: UIViewController, BambuserViewDelegate {
    
    @IBOutlet weak var backButton : UIButton!
    
    var currentUserLogin : User!
    var bambuserView : BambuserView
    var broadcastButton : UIButton
    var assignmentId = ""
    
    required init?(coder aDecoder: NSCoder) {
        bambuserView = BambuserView(preparePreset: kSessionPresetAuto)
        broadcastButton = UIButton(type: UIButton.ButtonType.system)
        super.init(coder: aDecoder)
        bambuserView.delegate = self
        bambuserView.applicationId = "Q0iV21kBnJLUFgoxn5Vncw"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupButton()
        // Do any additional setup after loading the view, typically from a nib.
        bambuserView.orientation = UIApplication.shared.statusBarOrientation
        self.view.addSubview(bambuserView.view)
        bambuserView.startCapture()
        
        broadcastButton.addTarget(self, action: #selector(LiveViewControllerJM.broadcast), for: UIControl.Event.touchUpInside)
        broadcastButton.setTitle("Broadcast", for: UIControl.State.normal)
        self.view.addSubview(broadcastButton)
        
        self.view.addSubview(backButton)
        
        self.currentUserLogin = User.loadSavedUser()

    }
    
    override func viewWillLayoutSubviews() {
        var statusBarOffset : CGFloat = 0.0
        statusBarOffset = CGFloat(self.topLayoutGuide.length)
        bambuserView.previewFrame = CGRect(x: 0.0, y: 0.0 + statusBarOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.height - statusBarOffset)
        broadcastButton.frame = CGRect(x: 270.0, y: 15.0 + statusBarOffset, width: 100.0, height: 50.0);
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func broadcast() {
        NSLog("Starting broadcast")
        broadcastButton.setTitle("Connecting", for: UIControl.State.normal)
        broadcastButton.removeTarget(nil, action: nil, for: UIControl.Event.touchUpInside)
        broadcastButton.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
        bambuserView.startBroadcasting()
    }
    
    func broadcastStarted() {
        NSLog("Received broadcastStarted signal")
        broadcastButton.setTitle("Stop", for: UIControl.State.normal)
        broadcastButton.removeTarget(nil, action: nil, for: UIControl.Event.touchUpInside)
        broadcastButton.addTarget(bambuserView, action: #selector(bambuserView.stopBroadcasting), for: UIControl.Event.touchUpInside)
    }
    
    func broadcastStopped() {
        NSLog("Received broadcastStopped signal")
        broadcastButton.setTitle("Broadcast", for: UIControl.State.normal)
        broadcastButton.removeTarget(nil, action: nil, for: UIControl.Event.touchUpInside)
        broadcastButton.addTarget(self, action: #selector(LiveViewControllerJM.broadcast), for: UIControl.Event.touchUpInside)
    }
    
    func broadcastIdReceived(_ broadcastId: String!) {
        print("broadcast ID Received --- \(broadcastId)")
    }
    
    //     for start live video
    func startLiveVideo(assignmentID: String, header: String){
        CommonClass.showLoader()
        Webservices.sharedInstance.liveVideoStart(assignmentID: assignmentID, header: header){(result,message,response) in
            print(result)
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }

    
}

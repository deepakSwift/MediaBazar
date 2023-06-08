//
//  ChatViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ChatViewControllerJM: UIViewController {
    @IBOutlet weak var buttonUnderlineView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var individualChatButton: UIButton!
    @IBOutlet weak var groupChatButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    var selectedButton: UIButton?
    var unselectedButtonFont = UIFont(name: "PlayfairDisplay-Regular", size: 25)
    var selectedButtonFont = UIFont(name: "PlayfairDisplay-Bold", size: 27)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupUI()
        setupScrollView()
        setupButton()
        setInitialButton(buttonPressed: individualChatButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitialButton(buttonPressed: selectedButton)
    }
    
    fileprivate func setupScrollView() {
        // to stop auto scrolling to first view contoller on searching
        self.scrollView.isScrollEnabled = false
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        
        let firstVC = storyboard? .instantiateViewController(withIdentifier: "IndividualChatViewControllerJM")
        self.addChild(firstVC!)
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "GroupChatViewControllerJM")
        self.addChild(secondVC!)
        
        self.perform(#selector(LoadScollView), with: nil, afterDelay: 0.5)
    }
    
    fileprivate func setupButton() {
        individualChatButton.addTarget(self, action: #selector(individualChatButtonPressed), for: .touchUpInside)
        groupChatButton.addTarget(self, action: #selector(groupChatButtonPressed), for: .touchUpInside)
        notificationButton.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
    }
    
    @objc func individualChatButtonPressed() {
        selectedButton = individualChatButton
        setInitialButton(buttonPressed: individualChatButton)
        self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.individualChatButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func groupChatButtonPressed() {
        selectedButton = groupChatButton
        setInitialButton(buttonPressed: groupChatButton)
        self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.groupChatButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func notificationButtonPressed() {
        let notificationVC = AppStoryboard.MediaHouse.viewController(NotificationController.self)
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func setInitialButton(buttonPressed: UIButton?) {
        buttonPressed?.titleLabel?.font = selectedButtonFont
        if buttonPressed == individualChatButton {
            groupChatButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.individualChatButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else {
            individualChatButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.groupChatButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        }
    }
}

extension ChatViewControllerJM: UIScrollViewDelegate {
    @objc func LoadScollView() {
        for i in 0 ..< self.children.count {
            self.loadScrollViewWithPage(i)
        }
        scrollView.delegate = self
    }
    
    func loadScrollViewWithPage(_ page: Int) {
        if page < 0 {
            return
        }
        if page >= self.children.count {
            return
        }
        var firstVC: IndividualChatViewControllerJM
        var secondVC: GroupChatViewControllerJM
        
        var frame: CGRect = scrollView.frame
        switch page {
        case 0:
            firstVC = self.children[page] as! IndividualChatViewControllerJM
            firstVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            firstVC.view.frame = frame
            scrollView.addSubview(firstVC.view!)
            firstVC.view.setNeedsLayout()
            firstVC.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            firstVC.view.setNeedsLayout()
            firstVC.view.layoutIfNeeded()
            
        case 1:
            secondVC = self.children[page] as! GroupChatViewControllerJM
            secondVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            secondVC.view.frame = frame
            scrollView.addSubview(secondVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            secondVC.view.setNeedsLayout()
            secondVC.view.layoutIfNeeded()
            
        default:
            break
        }
    }
    
    func raceTo(_ destination: CGPoint, withSnapBack: Bool, delegate: AnyObject?, callbackmethod : (()->Void)?) {
        
        var stopPoint: CGPoint = destination
        if withSnapBack {
            let diffx = destination.x - buttonUnderlineView.frame.origin.x
            let diffy = destination.y - buttonUnderlineView.frame.origin.y
            if diffx < 0 {
                stopPoint.x -= 10.0
            }
            else if diffx > 0 {
                stopPoint.x += 10.0
            }
            
            if diffy < 0 {
                stopPoint.y -= 10.0
            }
            else if diffy > 0 {
                stopPoint.y += 10.0
            }
        }
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.0)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
        buttonUnderlineView.frame = CGRect(x:stopPoint.x, y:stopPoint.y, width: buttonUnderlineView.frame.size.width,height: buttonUnderlineView.frame.size.height)
        UIView.commitAnimations()
        let firstDelay = 0.0
        let startTime = firstDelay * Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: .now() + startTime) {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.0)
            UIView.setAnimationCurve(UIView.AnimationCurve.linear)
            self.buttonUnderlineView.frame = CGRect(x:destination.x, y:destination.y,width: self.buttonUnderlineView.frame.size.width, height: self.buttonUnderlineView.frame.size.height)
            UIView.commitAnimations()
        }
    }
    
    
    func raceScrollTo(_ destination: CGPoint, withSnapBack: Bool, delegate: AnyObject?, callback method:(()->Void)?) {
        var stopPoint = destination
        var isleft: Bool = false
        if withSnapBack {
            let diffx = destination.x - scrollView.contentOffset.x
            if diffx < 0 {
                isleft = true
                stopPoint.x -= 10
            }
            else if diffx > 0 {
                isleft = false
                stopPoint.x += 10
            }
        }
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.0)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
        
        if isleft {
            scrollView.contentOffset = CGPoint(x:destination.x - 5, y:destination.y)
        }
        else {
            scrollView.contentOffset = CGPoint(x:destination.x + 5, y:destination.y)
        }
        
        UIView.commitAnimations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {() -> Void in
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.0)
            UIView.setAnimationCurve(UIView.AnimationCurve.linear)
            if isleft {
                self.scrollView.contentOffset = CGPoint(x:destination.x + 5, y:destination.y)
            }
            else {
                self.scrollView.contentOffset = CGPoint(x:destination.x - 5,y: destination.y)
            }
            UIView.commitAnimations()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0){() -> Void in
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.0)
                UIView.setAnimationCurve(.easeInOut)
                self.scrollView.contentOffset = CGPoint(x:destination.x, y:destination.y)
                UIView.commitAnimations()
            }
        }
    }
}




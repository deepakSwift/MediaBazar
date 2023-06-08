//
//  CollaborationViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 02/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CollaborationViewControllerJM: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var buttonUnderlineView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var addedButton: UIButton!
    @IBOutlet weak var newRequestButton: UIButton!
    @IBOutlet weak var backButton : UIButton!

    
    var selectedButton: UIButton?
    var unselectedButtonFont = UIFont(name: "Lato-Regular", size: 16)
    var selectedButtonFont = UIFont(name: "Lato-Bold", size: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupUI()
        setupScrollView()
        setupButton()
        setInitialButton(buttonPressed: inviteButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setInitialButton(buttonPressed: selectedButton)
    }
    
    fileprivate func setupUI() {
        topView.applyShadow()
    }
    
    fileprivate func setupScrollView() {
        // to stop auto scrolling to first view contoller on searching
        self.scrollView.isScrollEnabled = false
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        
        let firstVC = storyboard? .instantiateViewController(withIdentifier: "InviteCollaborationViewControllerJM")
        self.addChild(firstVC!)
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "AddedCollaborationViewControllerJM")
        self.addChild(secondVC!)
        let thiredVC = storyboard?.instantiateViewController(withIdentifier: "NewRequestCollaborationControllerJM")
        self.addChild(thiredVC!)
        
        self.perform(#selector(LoadScollView), with: nil, afterDelay: 0.5)
    }
    
    fileprivate func setupButton() {
        inviteButton.addTarget(self, action: #selector(inviteButtonPressed), for: .touchUpInside)
        addedButton.addTarget(self, action: #selector(addedButtonPressed), for: .touchUpInside)
        newRequestButton.addTarget(self, action: #selector(newRequestButtonPressed), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func inviteButtonPressed() {
        selectedButton = inviteButton
        setInitialButton(buttonPressed: inviteButton)
        self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.inviteButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func addedButtonPressed() {
        selectedButton = addedButton
        setInitialButton(buttonPressed: addedButton)
        self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.addedButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func newRequestButtonPressed() {
        selectedButton = newRequestButton
        setInitialButton(buttonPressed: newRequestButton)
        self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.newRequestButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func backButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setInitialButton(buttonPressed: UIButton?) {
        buttonPressed?.titleLabel?.font = selectedButtonFont
        if buttonPressed == inviteButton {
            addedButton.titleLabel?.font = unselectedButtonFont
            newRequestButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.inviteButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == addedButton {
            inviteButton.titleLabel?.font = unselectedButtonFont
            newRequestButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.addedButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == newRequestButton {
            inviteButton.titleLabel?.font = unselectedButtonFont
            addedButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.newRequestButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        }
    }
}

extension CollaborationViewControllerJM: UIScrollViewDelegate {
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
        var firstVC: InviteCollaborationViewControllerJM
        var secondVC: AddedCollaborationViewControllerJM
        var thirdVC: NewRequestCollaborationControllerJM
        
        var frame: CGRect = scrollView.frame
        switch page {
        case 0:
            firstVC = self.children[page] as! InviteCollaborationViewControllerJM
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
            secondVC = self.children[page] as! AddedCollaborationViewControllerJM
            secondVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            secondVC.view.frame = frame
            scrollView.addSubview(secondVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            secondVC.view.setNeedsLayout()
            secondVC.view.layoutIfNeeded()
            
        case 2:
            thirdVC = self.children[page] as! NewRequestCollaborationControllerJM
            thirdVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            thirdVC.view.frame = frame
            scrollView.addSubview(thirdVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            thirdVC.view.setNeedsLayout()
            thirdVC.view.layoutIfNeeded()

            
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



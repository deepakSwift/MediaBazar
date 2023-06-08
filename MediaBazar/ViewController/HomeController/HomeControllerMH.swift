//
//  HomeControllerMH.swift
//  MediaBazar
//
//  Created by Saurabh Chandra Bose on 18/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class HomeControllerMH: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var buttonUnderlineView: UIView!
    
    @IBOutlet weak var liveEventButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var exclusiveButton: UIButton!
    @IBOutlet weak var sharedButton: UIButton!
    @IBOutlet weak var freeButton: UIButton!
    @IBOutlet weak var auctionButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    
    var selectedButton: UIButton?
    var unselectedButtonFont = UIFont(name: "Lato-Regular", size: 14)
    var selectedButtonFont = UIFont(name: "Lato-Regular", size: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupScrollView()
        setupButton()
        setInitialButton(buttonPressed: allButton)
        //searchBar.delegate = self
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
        
        let firstVC = storyboard? .instantiateViewController(withIdentifier: "AllHomeControllerMH")
        self.addChild(firstVC!)
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "ExclusiveHomeControllerMH")
        self.addChild(secondVC!)
        let thiredVC = storyboard?.instantiateViewController(withIdentifier: "SharedHomeControllerMH")
        self.addChild(thiredVC!)
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FreeHomeControllerMH")
        self.addChild(fourthVC!)
        let fifthVC = storyboard?.instantiateViewController(withIdentifier: "AuctionHomeControllerMH")
        self.addChild(fifthVC!)
        
        self.perform(#selector(LoadScollView), with: nil, afterDelay: 0.5)
    }
    
    fileprivate func setupButton() {
        allButton.addTarget(self, action: #selector(allButtonPressed), for: .touchUpInside)
        exclusiveButton.addTarget(self, action: #selector(exclusiveButtonPressed), for: .touchUpInside)
        sharedButton.addTarget(self, action: #selector(sharedButtonPressed), for: .touchUpInside)
        freeButton.addTarget(self, action: #selector(freeButtonPressed), for: .touchUpInside)
        auctionButton.addTarget(self, action: #selector(auctionButtonPressed), for: .touchUpInside)
        notificationButton.addTarget(self, action: #selector(notificationButtonPressed), for: .touchUpInside)
        liveEventButton.addTarget(self, action: #selector(liveEventButtonPressed), for: .touchUpInside)
    }
    
    @objc func allButtonPressed() {
        selectedButton = allButton
        setInitialButton(buttonPressed: allButton)
        self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.allButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func exclusiveButtonPressed() {
        selectedButton = exclusiveButton
        setInitialButton(buttonPressed: exclusiveButton)
        self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.exclusiveButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func sharedButtonPressed() {
        selectedButton = sharedButton
        setInitialButton(buttonPressed: sharedButton)
        self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.sharedButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func freeButtonPressed() {
        selectedButton = freeButton
        setInitialButton(buttonPressed: freeButton)
        self.raceScrollTo(CGPoint(x: 3 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.freeButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func auctionButtonPressed() {
        selectedButton = auctionButton
        setInitialButton(buttonPressed: auctionButton)
        self.raceScrollTo(CGPoint(x: 4 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.auctionButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func notificationButtonPressed() {
        let notificationVC = AppStoryboard.MediaHouse.viewController(NotificationController.self)
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @objc func liveEventButtonPressed() {
//        NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Coming soon...")
        let liveEventCommonVC = AppStoryboard.MediaHouse.viewController(LiveEventCommonViewControllerMH.self)
        navigationController?.pushViewController(liveEventCommonVC, animated: true)
    }
    
    func setInitialButton(buttonPressed: UIButton?) {
        buttonPressed?.titleLabel?.font = selectedButtonFont
        if buttonPressed == allButton {
            allButton.setTitleColor(.black, for: .normal)
            exclusiveButton.setTitleColor(.gray, for: .normal)
            sharedButton.setTitleColor(.gray, for: .normal)
            freeButton.setTitleColor(.gray, for: .normal)
            auctionButton.setTitleColor(.gray, for: .normal)
            
            exclusiveButton.titleLabel?.font = unselectedButtonFont
            sharedButton.titleLabel?.font = unselectedButtonFont
            freeButton.titleLabel?.font = unselectedButtonFont
            auctionButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.allButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == exclusiveButton {
            allButton.setTitleColor(.gray, for: .normal)
            exclusiveButton.setTitleColor(.black, for: .normal)
            sharedButton.setTitleColor(.gray, for: .normal)
            freeButton.setTitleColor(.gray, for: .normal)
            auctionButton.setTitleColor(.gray, for: .normal)
            
            allButton.titleLabel?.font = unselectedButtonFont
            sharedButton.titleLabel?.font = unselectedButtonFont
            freeButton.titleLabel?.font = unselectedButtonFont
            auctionButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.exclusiveButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == sharedButton {
            allButton.setTitleColor(.gray, for: .normal)
            exclusiveButton.setTitleColor(.gray, for: .normal)
            sharedButton.setTitleColor(.black, for: .normal)
            freeButton.setTitleColor(.gray, for: .normal)
            auctionButton.setTitleColor(.gray, for: .normal)

            
            allButton.titleLabel?.font = unselectedButtonFont
            exclusiveButton.titleLabel?.font = unselectedButtonFont
            freeButton.titleLabel?.font = unselectedButtonFont
            auctionButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.sharedButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == freeButton {
            allButton.setTitleColor(.gray, for: .normal)
            exclusiveButton.setTitleColor(.gray, for: .normal)
            sharedButton.setTitleColor(.gray, for: .normal)
            freeButton.setTitleColor(.black, for: .normal)
            auctionButton.setTitleColor(.gray, for: .normal)
            
            allButton.titleLabel?.font = unselectedButtonFont
            exclusiveButton.titleLabel?.font = unselectedButtonFont
            sharedButton.titleLabel?.font = unselectedButtonFont
            auctionButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 3 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.freeButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == auctionButton {
            allButton.setTitleColor(.gray, for: .normal)
            exclusiveButton.setTitleColor(.gray, for: .normal)
            sharedButton.setTitleColor(.gray, for: .normal)
            freeButton.setTitleColor(.gray, for: .normal)
            auctionButton.setTitleColor(.black, for: .normal)

            
            allButton.titleLabel?.font = unselectedButtonFont
            exclusiveButton.titleLabel?.font = unselectedButtonFont
            sharedButton.titleLabel?.font = unselectedButtonFont
            freeButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 4 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.auctionButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        }
    }
}

extension HomeControllerMH: UIScrollViewDelegate {
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
        var firstVC: AllHomeControllerMH
        var secondVC: ExclusiveHomeControllerMH
        var thirdVC: SharedHomeControllerMH
        var fourthVC: FreeHomeControllerMH
        var fifthVC: AuctionHomeControllerMH
        
        
        var frame: CGRect = scrollView.frame
        switch page {
        case 0:
            firstVC = self.children[page] as! AllHomeControllerMH
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
            secondVC = self.children[page] as! ExclusiveHomeControllerMH
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
            thirdVC = self.children[page] as! SharedHomeControllerMH
            thirdVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            thirdVC.view.frame = frame
            scrollView.addSubview(thirdVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            thirdVC.view.setNeedsLayout()
            thirdVC.view.layoutIfNeeded()
            
        case 3:
            fourthVC = self.children[page] as! FreeHomeControllerMH
            fourthVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            fourthVC.view.frame = frame
            scrollView.addSubview(fourthVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            fourthVC.view.setNeedsLayout()
            fourthVC.view.layoutIfNeeded()
            
        case 4:
            fifthVC = self.children[page] as! AuctionHomeControllerMH
            fifthVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            fifthVC.view.frame = frame
            scrollView.addSubview(fifthVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            fifthVC.view.setNeedsLayout()
            fifthVC.view.layoutIfNeeded()
            
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



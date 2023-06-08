//
//  CoomonLiveEventsVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 25/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class CoomonLiveEventsVC: UIViewController {

    
    @IBOutlet weak var buttonPurchaseEvents: UIButton!
    @IBOutlet weak var buttonNewEvents: UIButton!
    @IBOutlet weak var buttonFilter: UIButton!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moveView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        //setup Tab Functionaity
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.toggleRateButton(button: buttonNewEvents)
        
        let NewEventsVc = storyboard?.instantiateViewController(withIdentifier: "NewEventsVC")
        self.addChild(NewEventsVc!)
        
        let PurchasedEventsVc = storyboard?.instantiateViewController(withIdentifier: "PurchasedEventsVC")
        self.addChild(PurchasedEventsVc!)
        
        self.perform(#selector(LoadScollView), with: nil, afterDelay: 0.5)
    }
    
    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension CoomonLiveEventsVC: UIScrollViewDelegate {
    
    func toggleRateButton(button:UIButton){
        if button == buttonNewEvents {
            buttonNewEvents.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
           buttonPurchaseEvents.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
            
        } else {
            buttonNewEvents.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: .normal)
            buttonPurchaseEvents.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func buttonActionNewEvents(_ sender: UIButton) {
        self.toggleRateButton(button: buttonNewEvents )
        self.raceScrollTo(CGPoint(x:0,y:0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x:self.buttonNewEvents.frame.origin.x,y: moveView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
 
    }
    
    @IBAction func buttonActionPurchaseEvents(_ sender: UIButton) {
        self.toggleRateButton(button: buttonPurchaseEvents)
        self.raceScrollTo(CGPoint(x:1*self.view.frame.size.width,y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x:self.buttonPurchaseEvents.frame.origin.x,y: moveView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    
    
    @objc func LoadScollView() {
        //        scrollView.delegate = nil
        // scrollView.contentSize = CGSize(width:kScreenWidth * 2, height:scrollView.frame.size.height)
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
        
        var firstVC : NewEventsVC
        var secondVC : PurchasedEventsVC
        
        var frame: CGRect = scrollView.frame
        switch page {
        case 0:
            firstVC = self.children[page] as! NewEventsVC
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
            
            secondVC = self.children[page] as! PurchasedEventsVC
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
    
    //move view indicator
    
    func raceTo(_ destination: CGPoint, withSnapBack: Bool, delegate: AnyObject?, callbackmethod : (()->Void)?) {
        var stopPoint: CGPoint = destination
        if withSnapBack {
            let diffx = destination.x - moveView.frame.origin.x
            let diffy = destination.y - moveView.frame.origin.y
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
        UIView.setAnimationDuration(0.2)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
        moveView.frame = CGRect(x:stopPoint.x, y:stopPoint.y, width: moveView.frame.size.width,height: moveView.frame.size.height)
        UIView.commitAnimations()
        let firstDelay = 0.1
        let startTime = firstDelay * Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: .now() + startTime) {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.1)
            UIView.setAnimationCurve(UIView.AnimationCurve.linear)
            self.moveView.frame = CGRect(x:destination.x, y:destination.y,width: self.moveView.frame.size.width, height: self.moveView.frame.size.height)
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
        UIView.setAnimationDuration(0.3)
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
            UIView.setAnimationDuration(0.1)
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
                UIView.setAnimationDuration(0.1)
                UIView.setAnimationCurve(.easeInOut)
                self.scrollView.contentOffset = CGPoint(x:destination.x, y:destination.y)
                UIView.commitAnimations()
            }
        }
    }
}

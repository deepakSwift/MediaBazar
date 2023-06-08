//
//  SellStoryViewControllerJM.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 26/12/19.
//  Copyright © 2019 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class SellStoryViewControllerJM: UIViewController {
    
    
    @IBOutlet weak var buttonUnderlineView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var categoryArray = [LanguageList]()
    var storyArray = [LanguageList]()
    
    @IBOutlet weak var exclusiveStoryButton: UIButton!
    @IBOutlet weak var sharedStoryButton: UIButton!
    @IBOutlet weak var freeStoryButton: UIButton!
    @IBOutlet weak var auctionStoryButton: UIButton!
    
    var selectedButton: UIButton?
    var unselectedButtonFont = UIFont(name: "Lato-Regular", size: 16)
    var selectedButtonFont = UIFont(name: "Lato-Bold", size: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//                self.tabBarController?.tabBar.isHidden = true
        setupScrollView()
        setupButton()
        setInitialButton(buttonPressed: exclusiveStoryButton)
        getCategory()
        getStoryKeyword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        setInitialButton(buttonPressed: selectedButton)
    }
    
    
    fileprivate func setupScrollView() {
        // to stop auto scrolling to first view contoller on searching
        self.scrollView.isScrollEnabled = false
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        
        let firstVC = storyboard? .instantiateViewController(withIdentifier: "ExclusiveSellStoryControllerJM")
        self.addChild(firstVC!)
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SharedSellStoryControllerJM")
        self.addChild(secondVC!)
        let thiredVC = storyboard?.instantiateViewController(withIdentifier: "FreeSellStoryControllerJM")
        self.addChild(thiredVC!)
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "AuctionSellStoryControllerJM")
        self.addChild(fourthVC!)
        
        self.perform(#selector(LoadScollView), with: nil, afterDelay: 0.5)
    }
    
    fileprivate func setupButton() {
        exclusiveStoryButton.addTarget(self, action: #selector(allButtonPressed), for: .touchUpInside)
        sharedStoryButton.addTarget(self, action: #selector(exclusiveButtonPressed), for: .touchUpInside)
        freeStoryButton.addTarget(self, action: #selector(sharedButtonPressed), for: .touchUpInside)
        auctionStoryButton.addTarget(self, action: #selector(freeButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func allButtonPressed() {
        selectedButton = exclusiveStoryButton
        setInitialButton(buttonPressed: exclusiveStoryButton)
        self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.exclusiveStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func exclusiveButtonPressed() {
        selectedButton = sharedStoryButton
        setInitialButton(buttonPressed: sharedStoryButton)
        self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.sharedStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func sharedButtonPressed() {
        selectedButton = freeStoryButton
        setInitialButton(buttonPressed: freeStoryButton)
        self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.freeStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    @objc func freeButtonPressed() {
        selectedButton = auctionStoryButton
        setInitialButton(buttonPressed: auctionStoryButton)
        self.raceScrollTo(CGPoint(x: 3 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
        self.raceTo(CGPoint(x: self.auctionStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
    }
    
    func setInitialButton(buttonPressed: UIButton?) {
        buttonPressed?.titleLabel?.font = selectedButtonFont
        if buttonPressed == exclusiveStoryButton {
            sharedStoryButton.titleLabel?.font = unselectedButtonFont
            freeStoryButton.titleLabel?.font = unselectedButtonFont
            auctionStoryButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 0, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.exclusiveStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == sharedStoryButton {
            exclusiveStoryButton.titleLabel?.font = unselectedButtonFont
            freeStoryButton.titleLabel?.font = unselectedButtonFont
            auctionStoryButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 1 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.sharedStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == freeStoryButton {
            exclusiveStoryButton.titleLabel?.font = unselectedButtonFont
            sharedStoryButton.titleLabel?.font = unselectedButtonFont
            auctionStoryButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 2 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.freeStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        } else if buttonPressed == auctionStoryButton {
            exclusiveStoryButton.titleLabel?.font = unselectedButtonFont
            sharedStoryButton.titleLabel?.font = unselectedButtonFont
            freeStoryButton.titleLabel?.font = unselectedButtonFont
            self.raceScrollTo(CGPoint(x: 3 * self.view.frame.size.width, y: 0), withSnapBack: false, delegate: nil, callback: nil)
            self.raceTo(CGPoint(x: self.auctionStoryButton.frame.origin.x, y: buttonUnderlineView.frame.origin.y), withSnapBack: false, delegate: nil, callbackmethod: nil)
        }
    }
    func getCategory(){
        Webservice.sharedInstance.categoryListData(){(result,response,message) in
            
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.categoryArray.removeAll()
                    self.categoryArray.append(contentsOf: somecategory)
                    //self.designationPickerView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    func getStoryKeyword(){
        Webservice.sharedInstance.keywordData(){(result,response,message) in
            
            print(result)
            if result == 200{
                if let somecategory = response{
                    self.storyArray.removeAll()
                    self.storyArray.append(contentsOf: somecategory)
                    //self.designationPickerView.reloadData()
                } else{
                    
                }
            }else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}

extension SellStoryViewControllerJM: UIScrollViewDelegate {
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
        var firstVC: ExclusiveSellStoryControllerJM
        var secondVC: SharedSellStoryControllerJM
        var thirdVC: FreeSellStoryControllerJM
        var fourthVC: AuctionSellStoryControllerJM
        
        
        var frame: CGRect = scrollView.frame
        switch page {
        case 0:
            firstVC = self.children[page] as! ExclusiveSellStoryControllerJM
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
            secondVC = self.children[page] as! SharedSellStoryControllerJM
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
            thirdVC = self.children[page] as! FreeSellStoryControllerJM
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
            fourthVC = self.children[page] as! AuctionSellStoryControllerJM
            fourthVC.viewWillAppear(true)
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0
            fourthVC.view.frame = frame
            scrollView.addSubview(fourthVC.view!)
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            fourthVC.view.setNeedsLayout()
            fourthVC.view.layoutIfNeeded()
            
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




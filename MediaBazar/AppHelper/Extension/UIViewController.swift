//
//  UIViewControllerExtension.swift
//  MyLaundryApp
//
//  Created by TecOrb on 15/12/16.
//  Copyright © 2016 Nakul Sharma. All rights reserved.
//

import UIKit

extension UINavigationController {
    func pop(_ animated: Bool) {
        _ = self.popViewController(animated: animated)
    }

    func popToRoot(_ animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}

extension UIViewController {

    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard : AppStoryboard) -> Self {
        return appStoryboard.viewController(self)
    }
}


enum AppStoryboard : String {

    case PreLogin, MediaHouse, Journalist, Stories

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewController<T : UIViewController>(_ viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

//
//  FindAJobDetailViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 31/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import Toast
/*============== SHOW MESSAGE ==================*/
enum ToastPosition {
    case top,center,bottom
}
enum warningMessage : String{
    case title = "Important Message"
    case updateVersion = "You are using a version of Carting Kidzs that\'s no longer supported. Please upgrade your app to the newest app version to use Carting Kidzs. Thanks!"
    case sessionExpired = "Your session has expired, Please login again"
    case cardDeclined = "The card was declined. Please reenter the payment details"
    case enterCVV = "Please enter the CVV"
    case enterValidCVV = "Please enter a valid CVV"
    case cardHolderName = "Please enter the card holder's name"
    case expMonth = "Please enter the exp. month"
    case expYear = "Please enter the exp. year"
    case validExpMonth = "Please enter a valid exp. month"
    case validExpYear = "Please enter a valid exp. year"
    case validCardNumber = "Please enter a valid card number"
    case cardNumber = "Please enter the card number"
}

class NKToastHelper {
    let duration : TimeInterval = 1.5
    static let sharedInstance = NKToastHelper()
    fileprivate init() {}

    func showToastWithViewController(_ viewController: UIViewController?,message: String, position:ToastPosition,completionBlock:@escaping () -> Void){
        var toastPosition : String!
        var toastShowingVC :UIViewController!

        if let vc = viewController{
            toastShowingVC = vc
        }else{
            toastShowingVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        }
        switch position {
        case .top:
            toastPosition = CSToastPositionTop
        case .center :
            toastPosition = CSToastPositionCenter
        case .bottom:
            toastPosition = CSToastPositionBottom
        }
        toastShowingVC.view.makeToast(message, duration: duration, position: toastPosition)
        completionBlock()
    }

    func showSuccessAlert(_ viewController: UIViewController?, message: String,completionBlock :(() -> Void)? = nil){
        self.showAlertWithViewController(viewController, title: warningMessage.title, message: message) {
            completionBlock?()
        }
    }

    func showAlert(_ viewController: UIViewController?,title:warningMessage, message: String,completionBlock :(() -> Void)? = nil){
        self.showAlertWithViewController(viewController, title: title, message: message) {
            completionBlock?()
        }
    }

    func showErrorAlert(_ viewController: UIViewController?, message: String, completionBlock :(() -> Void)? = nil){
        self.showAlertWithViewController(viewController, title: warningMessage.title, message: message) {
            completionBlock?()
        }
    }


    //complitionBlock : ((_ done: Bool) ->Void)? = nil
    private func showAlertWithViewController(_ viewController: UIViewController?, title: warningMessage, message: String,completionBlock :(() -> Void)? = nil){
        var toastShowingVC :UIViewController!

        if let vc = viewController{
            toastShowingVC = vc
        }else{
            toastShowingVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        }
        let alert = UIAlertController(title: title.rawValue, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel) { (action) in
            guard let handler = completionBlock else{
                alert.dismiss(animated: false, completion: nil)
                return
            }
            handler()
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okayAction)
        toastShowingVC.present(alert, animated: true, completion: nil)
    }



    func showErrorToast(message:String,completionBlock:@escaping () -> Void){

    }

}

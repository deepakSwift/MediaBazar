//
//  ContentRenameUploadViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 19/06/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

//import UIKit
//
//class ContentRenameUploadViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


import UIKit

//protocol sendContentName{
//    func documentNote(note: String)
//}

class ContentRenameUploadViewController: UIViewController {
    
    
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var crossButton : UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    
//    var note = ""
//    var showNote = ""
//    var delegate : sendDocumentNote!
    var textType = ""
    
    var currentUserLogin : User!
    var contentID = ""
    var contentName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpButton()
        self.currentUserLogin = User.loadSavedUser()
        print("contentID====\(contentID)")
        print("contentName====\(contentName)")
        self.textView.text = contentName
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 1)


    }
    
    func setUpButton(){
        crossButton.addTarget(self, action: #selector(clickOnCrossButon), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(clickOnsunbmitButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cliCkOnCancelButton), for: .touchUpInside)
    }
    
    @objc func clickOnCrossButon(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cliCkOnCancelButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickOnsunbmitButton(){
//        if showNote == "note"{
//            self.dismiss(animated: true, completion: nil)
//        } else {
//            self.dismiss(animated: true, completion: {
//                self.delegate.documentNote(note: self.textView.text)
//            })
//        }
        rename(contentID: contentID, fileName: textView.text!, header: currentUserLogin.token )
        
    }
    
    func rename(contentID : String, fileName : String, header : String){
        Webservices.sharedInstance.renameUploadContent(contentID: contentID, fileName: fileName, header: header){
            (result,message,response) in
            if result == 200{
                print("===================\(response)")
                self.dismiss(animated: true, completion: nil)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


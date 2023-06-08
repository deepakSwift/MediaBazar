//
//  SupportingDocuNoteViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 18/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol sendDocumentNote{
    func documentNote(note: String)
}

class SupportingDocuNoteViewController: UIViewController {
    
    
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var crossButton : UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    
    var note = ""
    var showNote = ""
    var delegate : sendDocumentNote!
    var textType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpButton()
        self.textView.text = note
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
        if showNote == "note"{
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: {
                self.delegate.documentNote(note: self.textView.text)
            })
        }
        
        
    }
    
}

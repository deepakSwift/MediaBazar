//
//  ThumbImageNoteViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 15/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol sendThumbImageNote{
    func thumbImageNote(note: String)
}


class ThumbImageNoteViewController: UIViewController {
    
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var submitButton : UIButton!
    @IBOutlet weak var crossButton : UIButton!
    @IBOutlet weak var cancelButton : UIButton!
    
    var note = ""
    var showNote = ""
    var delegate : sendThumbImageNote!
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
                self.delegate.thumbImageNote(note: self.textView.text)
            })
        }
        
        
    }
    
}

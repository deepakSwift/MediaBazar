//
//  ConvertedFIleViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 27/05/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

class ConvertedFIleViewController: UIViewController {
    
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var convertedLabel : UILabel!
    
    var fileText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        convertedLabel.text = fileText
        // Do any additional setup after loading the view.
    }
    
    func setUpButton(){
        backButton.addTarget(self, action: #selector(onClickBackButton), for: .touchUpInside)
    }
    
    @objc func onClickBackButton(){
        self.navigationController?.popViewController(animated: true)
    }

}

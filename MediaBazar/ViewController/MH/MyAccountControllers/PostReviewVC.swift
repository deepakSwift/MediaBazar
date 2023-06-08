//
//  PostReviewVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 27/04/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import Cosmos

class PostReviewVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var keywordsCollectionView: UICollectionView!
    @IBOutlet weak var journalistName : UILabel!
    @IBOutlet weak var soldOutCount : UILabel!
    @IBOutlet weak var journalistImage : UIImageView!
    @IBOutlet weak var languageLabel : UILabel!
    @IBOutlet weak var categoryType : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var fileCountLabel : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    @IBOutlet weak var buttonFavorite : UIButton!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var buttonType : UIButton!
    @IBOutlet weak var buttonBuyNow : UIButton!
    @IBOutlet weak var buttonBack : UIButton!
     @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonSubmit : UIButton!
    
    @IBOutlet weak var spellingGrammerCosmosView: CosmosView!
    @IBOutlet weak var consistencyClarityCosmosView: CosmosView!
    @IBOutlet weak var fairObjectiveCosmosView: CosmosView!
    @IBOutlet weak var obseenitiesCosmosView: CosmosView!
    @IBOutlet weak var plagiarismCosmosView: CosmosView!
    
    var baseUrl = "https://apimediaprod.5wh.com/"
    var currenUserLogin : User!
    var storyId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        CommonClass.makeViewCircularWithCornerRadius(textView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 5)
        CommonClass.makeViewCircularWithCornerRadius(containerView, borderColor: .lightGray, borderWidth: 0.5, cornerRadius: 0)
        buttonSubmit.makeRoundCorner(20)
        buttonSubmit.addTarget(self, action: #selector(onClickSubmitButton), for: .touchUpInside)
        
        spellingGrammerCosmosView.rating = 0.0
        consistencyClarityCosmosView.rating = 0.0
        fairObjectiveCosmosView.rating = 0.0
        obseenitiesCosmosView.rating = 0.0
        plagiarismCosmosView.rating = 0.0
    }

    func setupButton() {
        buttonBack.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onClickSubmitButton() {
        
        if textView.text == "" {
            NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: "Please enter the comments.")
        } else {
            let spellRating = Int(spellingGrammerCosmosView.rating)
            let consistencyRating = Int(consistencyClarityCosmosView.rating)
            let fairObjectiveRating = Int(fairObjectiveCosmosView.rating)
            let obseenitiesRating = Int(obseenitiesCosmosView.rating)
            let plagiarismRating = Int(plagiarismCosmosView.rating)
            
             postStoryReview(storyId: self.storyId, comment: textView.text!, plagiarism: "\(plagiarismRating)", obscenities: "\(obseenitiesRating)", fairObjective: "\(fairObjectiveRating)", consistency: "\(consistencyRating)", spellingAndGrammar: "\(spellRating)", header: currenUserLogin.mediahouseToken)
        }
    }
    
    func  postStoryReview(storyId: String, comment: String, plagiarism: String, obscenities: String, fairObjective: String, consistency: String, spellingAndGrammar: String ,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.postReview(storyId: storyId, comment: comment, plagiarism: plagiarism, obscenities: obscenities, fairObjective: fairObjective, consistency: consistency, spellingAndGrammar: spellingAndGrammar, header: header) { (result,message,response) in
            
            CommonClass.hideLoader()
            if result == 200{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
        
    }
    

}

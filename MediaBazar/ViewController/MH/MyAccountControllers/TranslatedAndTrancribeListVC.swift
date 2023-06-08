//
//  TranslatedAndTrancribeVC.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/01/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit
import AVFoundation

class TranslatedAndTrancribeListVC: UIViewController {

    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var tableViewTranslated: UITableView!
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var getTranslateData = [TranslateListDetailsModel]()
    var storyTimeArray = [String]()
    var currenUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currenUserLogin = User.loadSavedUser()
        setupUI()
        setupButton()
        setupTableView()
        apiCall()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupButton(){
        buttonBack.addTarget(self, action: #selector(clickOnBackButton), for: .touchUpInside)
    }
    
    func setupTableView() {
        //registered XIB
        tableViewTranslated.register(UINib(nibName: "TranslatedAndTranscribeTableCell", bundle: Bundle.main), forCellReuseIdentifier: "TranslatedAndTranscribeTableCell")
        tableViewTranslated.register(UINib(nibName: "TranslatedAndTranscribeTextTableCell", bundle: Bundle.main), forCellReuseIdentifier: "TranslatedAndTranscribeTextTableCell")
    }
    
    @objc func clickOnBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func calculateTime() {
        var tempTimeArray = [String]()
        for data in getTranslateData.enumerated() {
            let tempData = data.element.createdAt
            tempTimeArray.append(tempData)
        }
        for data1 in tempTimeArray.enumerated() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let formatedStartDate = dateFormatter.date(from: data1.element)
            let currentDate = Date()
            let dayCount = Set<Calendar.Component>([.day])
            let hourCount = Set<Calendar.Component>([.hour])
            let differenceOfDay = Calendar.current.dateComponents(dayCount, from: formatedStartDate!, to: currentDate)
            let differenceOfTimes = Calendar.current.dateComponents(hourCount, from: formatedStartDate!, to: currentDate)
            if differenceOfDay.day == 0 {
                storyTimeArray.append("\(differenceOfTimes.hour!) hr ago")
            } else {
                storyTimeArray.append("\(differenceOfDay.day!) day ago")
            }
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func apiCall() {
        getTranslateList(page: "0", header: currenUserLogin.mediahouseToken)
    }
    
    //-----getList-------
    func getTranslateList(page : String,header: String) {
        CommonClass.showLoader()
        WebService3.sharedInstance.translateList(page: page, header: header){(result,message,response) in
                print(result)
               CommonClass.hideLoader()
                if result == 200{
                    if let somecategory = response{
                        self.scrollPage = true
                        self.getTranslateData.append(contentsOf: somecategory.docs)
                        self.tableViewTranslated.reloadData()
                        self.calculateTime()

                        self.page = somecategory.page
                        self.totalPages = somecategory.pages
                        if self.page == self.totalPages{
                            self.scrollPage = false
                        }else {
                            self.scrollPage = true
                        }
                        print("page=====\(self.page)")
                        print("\(somecategory)")

                    } else{

                    }
                }else{
                    NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
                }
            }
        }
    
    //-------DeleteTranslate-------
    func deleteTranslate(translateId: String, header: String) {
        //CommonClass.showLoader()
        WebService3.sharedInstance.deleteTranslate(translateId: translateId, header: header) { (result,message,response) in
            CommonClass.hideLoader()
            if result == 200{
                self.apiCall()
            }else{
                self.tableViewTranslated.reloadData()
                self.apiCall()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
}


//--------- TableView----
extension TranslatedAndTrancribeListVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTranslateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TranslatedAndTranscribeTableCell", for: indexPath) as! TranslatedAndTranscribeTableCell
        let data = getTranslateData[indexPath.row]
        cell.labelServiceType.text = data.serviceType
        cell.labelfileName.text = data.originalFile
        cell.labelfileExtension.text = "Type: \(data.fileType)"
        cell.labelLanguage.text = "to \(data.toLanguage)"
        cell.labelTime.text = storyTimeArray[indexPath.row]
        
        if data.fileType == "video" {
            let getUrl = "\(self.baseUrl)\(data.originalFile)"
            let url = URL(string: getUrl)
            if let thumbnailImage = getThumbnailImage(forUrl: url!) {
                cell.imageViewThumbnail.image = thumbnailImage
            }
            cell.labelfileLength.text = "Duration: \(data.fileSize) min"
        } else if data.fileType == "audio"  {
            cell.imageViewThumbnail.image = #imageLiteral(resourceName: "images-2")
        } else {
            cell.imageViewThumbnail.image = #imageLiteral(resourceName: "Documents")
            cell.labelfileLength.text = "Words: \(data.fileSize)"
        }
        
        if data.serviceType == "transcribe"{
            cell.labelLanguage.isHidden = true
            cell.labelServiceType.text = "Transcribe"
        }else {
            cell.labelLanguage.isHidden = false
            cell.labelServiceType.text = "Translate"
        }

        cell.buttonDelete.tag = indexPath.row
        cell.buttonDelete.addTarget(self, action: #selector(buttonDeleteAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let convertVC = AppStoryboard.Journalist.viewController(ConvertedFIleViewController.self)
        convertVC.fileText = getTranslateData[indexPath.row].convertedFile
        self.navigationController?.pushViewController(convertVC, animated: true)
    }
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         
            if !scrollPage { return }
            if (getTranslateData.count - 3) == indexPath.row {
                print(indexPath.row)
                page += 1
                print("Page***** --- \(page)")

                getTranslateList(page: "\(page)", header: currenUserLogin.mediahouseToken)
            }
        }

    
    @objc func buttonDeleteAction(sender: UIButton){
        let id = getTranslateData[sender.tag].translateId
        deleteTranslate(translateId: id, header: currenUserLogin.mediahouseToken)
    }
}




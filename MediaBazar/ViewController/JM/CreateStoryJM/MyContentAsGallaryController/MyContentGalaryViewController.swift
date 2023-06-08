//
//  MyContentGalaryViewController.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 21/07/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import UIKit

protocol selectMultipleContentMedia {
    func selectedData(image: [URL])
}

class MyContentGalaryViewController: UIViewController {
    
    
    @IBOutlet weak var contentCollectionView : UICollectionView!
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var topView : UIView!
    @IBOutlet weak var okButton : UIButton!
    
    var currentUserLogin : User!
    var baseUrl = "https://apimediaprod.5wh.com/"
    
    var page = 0
    var totalPages = 0
    var scrollPage = true
    var uploadedContentData = [storyListModal]()
    var delegate: selectMultipleContentMedia!
    var selectedData = [URL]()
    let document = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        setUpCollectionView()
        setupButton()
        setupUI()
        self.currentUserLogin = User.loadSavedUser()
        getContentData(page: "0", header: currentUserLogin.token)
        
    }
    
    func setUpCollectionView(){
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.delegate = self
        self.contentCollectionView.allowsMultipleSelection = true
        
    }
    
    func setupUI(){
        topView.applyShadow()
    }
    
    func setupButton(){
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(onClickOkayButton), for: .touchUpInside)
    }
    
    @objc func backButtonPressed(){
        //            self.navigationController?.popViewController(animated: true)
        self.navigationController?.pop(true)
    }
    
    @objc func onClickOkayButton() {
        //        self.dismiss(animated: true) {
        self.navigationController?.pop(true)
        self.delegate.selectedData(image: selectedData)
        
        
        //        }
    }
    
    
    
    
    func getContentData(page : String,header : String){
        Webservices.sharedInstance.getupdoadContentData(page: page, storyHeader: header){(result,message,response) in
            print(result)
            if result == 200{
                if let somecategory = response{
                    //                    self.contentData = somecategory
                    //                    self.contentCollectionView.reloadData()
                    self.scrollPage = true
                    self.uploadedContentData.append(contentsOf: somecategory.docs)
                    self.contentCollectionView.reloadData()
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
    
    
    
    
    
    
    func postContentData(mycontnt: [Data], header: String){
        Webservices.sharedInstance.postupdoadContentData(upload: mycontnt, header: header){
            (result,message,response) in
            if result == 200{
                print("===================\(response)")
                self.contentCollectionView.reloadData()
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            } else{
                NKToastHelper.sharedInstance.showAlert(self, title: warningMessage.title, message: message)
            }
        }
    }
    
    func saveImage(pickedImage: UIImage) -> URL? {
        let imageURL = document.appendingPathComponent("\(Date().timeIntervalSince1970).png", isDirectory: true)
        do {
            try pickedImage.pngData()?.write(to: imageURL)
            print("Added successfully")
            return imageURL
        } catch {
            print("Not added")
        }
        return nil
    }
    
}


extension MyContentGalaryViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return contentData.docs.count
        return uploadedContentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyContentGallaryCollectionViewCell", for: indexPath) as! MyContentGallaryCollectionViewCell
        let arrdata = uploadedContentData[indexPath.item]
        //            cell.contentName.text = arrdata.myContent.contentOriginalName
        
        let ext = arrdata.myContent.contentDuplicateName.fileExtension()
        print("ext======\(ext)")
        
        if ext == "mp3" {
            cell.contentImage.image = #imageLiteral(resourceName: "images-2")
        } else if ext == "jpg" {
            let getContentUrl = "\(self.baseUrl)\(arrdata.myContent.contentDuplicateName)"
            let strWithNoSpace = getContentUrl.replacingOccurrences(of: " ", with: "%20")
            let url = NSURL(string: strWithNoSpace)
            cell.contentImage.sd_setImage(with: url! as URL)
        }else if ext == "png"{
            //            cell.contentImage.image = #imageLiteral(resourceName: "images2")
            let getPngFile = "\(self.baseUrl)\(arrdata.myContent.contentDuplicateName)"
            let strWithNoSpace = getPngFile.replacingOccurrences(of: " ", with: "%20")
            print("strWithNoSpace===========\(strWithNoSpace)")
            let url = NSURL(string: strWithNoSpace)
            cell.contentImage.sd_setImage(with: url! as URL)
        } else if ext == "pdf"{
            cell.contentImage.image = #imageLiteral(resourceName: "Documents")
        } else {
            cell.contentImage.image = #imageLiteral(resourceName: "images-1")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = contentCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? MyContentGallaryCollectionViewCell else { print("cell not found"); return }
        self.selectedData.append(saveImage(pickedImage: cell.contentImage.image!)!)
        
        if cell.isSelected == true{
            cell.selectedInmage.image = #imageLiteral(resourceName: "Group 184")
        }else {
            cell.selectedInmage.image = #imageLiteral(resourceName: "Group 184-2")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let name = uploadedContentData[indexPath.item].myContent.contentDuplicateName
        //        selectedData.removeAll(where: { $0 == name })
        print(selectedData)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !scrollPage { return }
        if (uploadedContentData.count - 3) == indexPath.row {
            print(indexPath.row)
            page += 1
            print("Page***** --- \(page)")
            getContentData(page: "\(page)", header: currentUserLogin.token)
        }
    }
    
}


extension MyContentGalaryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let cellWidth = (width - 20) / 2 // compute your cell width
        return CGSize(width: cellWidth, height: cellWidth)
        
    }
    
}

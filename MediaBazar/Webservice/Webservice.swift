//
//  Webservice.swift
//  MediaBazar
//
//  Created by Abhinav Saini on 14/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Webservices: NSObject {
    
    
    static let sharedInstance = Webservices()
    
    func blogFormFill(headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordId: String,description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        
        
        let head = ["authtoken": header]
        
        Alamofire.request(api.blogFormFill.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func blogFormFill2(uploadTexts: [Data], textNote: String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote: String, supportingDocs: [Data], docNote: String, uploadAudio: String, audioNote: String, blogId: String, uploadThumbnails: [Data], thumbnailNote: String, typeStatus: String, status: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(textNote, forKey: "textNote")
        params.updateValue(imageNote, forKey: "imageNote")
        params.updateValue(videoNote, forKey: "videoNote")
        params.updateValue(docNote, forKey: "docNote")
        //=========== set audio Static
        params.updateValue(uploadAudio, forKey: "uploadAudios")
        params.updateValue(audioNote, forKey: "audioNote")
        params.updateValue(blogId, forKey: "blogId")
        params.updateValue(thumbnailNote, forKey: "thumbnaleNote")
        params.updateValue(typeStatus, forKey: "typeStatus")
        params.updateValue(status, forKey: "status")
        
        let head = ["authtoken":header]
        
        let url = api.blogFormFill.url()
        
        
        print("===================\(params)")
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            for imageData in uploadImages {
                MultipartFormData.append(imageData, withName: "uploadImages", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for pdfData in uploadTexts {
                MultipartFormData.append(pdfData, withName: "uploadTexts", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for supportingDocs in supportingDocs {
                MultipartFormData.append(supportingDocs, withName: "supportingDocs", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for thumbnailImages in uploadThumbnails {
                MultipartFormData.append(thumbnailImages, withName: "uploadThumbnails", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for videos in uploadVideos {
                MultipartFormData.append(videos, withName: "uploadVideos", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
            }
            
            
            for (key, value) in params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: url, method: .put, headers: head, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ , _ ):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(" story json is:\n\(json)")
                            let parser = storyParsar(json: json)
                            
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        } else {
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                        
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    
    func updateblogFormFill(storyId: String,headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordId: String,description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "storyId")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        print("params========\(params)")
        let head = ["authtoken": header]
        
        Alamofire.request(api.editBlogFormFill.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            print(response)
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func exclusiveSellStrotyForm(headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordId: String, storyCategory: String, currency: String, price: String, description: String, typeStatus: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(price, forKey: "price")
        params.updateValue(typeStatus, forKey: "typeStatus")
        
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.sellStoryForm.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func updateSellStrotyForm(storyID:String,headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordName: String, storyCategory: String, currency: String, price: String, description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordName, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(price, forKey: "price")
        
        print("params======\(params)")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.updateSellStoryForm.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func sharedSellStrotyForm(headLine: String, categoryId: String, languageCode: String, purchasePrice: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordId: String, storyCategory: String, currency: String, price: String, description: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(purchasePrice, forKey: "purchasingLimit")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(price, forKey: "price")
        
        let head = ["authtoken": header]
        
        Alamofire.request(api.sellStoryForm.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func updateSharedSellStrotyForm(storyID:String,headLine: String,purchaseLimit: String ,categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordName: String, storyCategory: String, currency: String, price: String, description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(purchaseLimit, forKey: "purchasingLimit")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordName, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(price, forKey: "price")
        
        print("params======\(params)")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.updateSellStoryForm.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func freeSellStrotyForm(headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordId: String, storyCategory: String, description: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        
        let head = ["authtoken": header]
        
        Alamofire.request(api.sellStoryForm.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func updateFreeSellStrotyForm(storyID:String,headLine: String ,categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String, keyWordName: String, storyCategory: String,description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordName, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        
        print("params======\(params)")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.updateSellStoryForm.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func auctionSellStrotyForm(headLine: String, categoryId: String, languageCode: String,country: String, state:String,city:String,date: String, stepCount: String,auctionDuartion: String ,keyWordId: String, storyCategory: String, currency: String, biddingPrice: String, description: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(auctionDuartion, forKey: "auctionDuration")
        params.updateValue(biddingPrice, forKey: "auctionBiddingPrice")
        
        let head = ["authtoken":header]
        
        
        Alamofire.request(api.sellStoryForm.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.login.url())")
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func updateAuctionSellStrotyForm(storyID:String,headLine: String, categoryId: String, languageCode: String, country: String, state:String,city:String,date: String, stepCount: String,auctionDuartion: String, keyWordName: String, storyCategory: String, currency: String, biddingPrice: String, description: String, header: String,  completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(headLine, forKey: "headLine")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(languageCode, forKey: "langCode")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(date, forKey: "date")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(keyWordName, forKey: "keywordName")
        params.updateValue(description, forKey: "briefDescription")
        params.updateValue(storyCategory, forKey: "storyCategory")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(auctionDuartion, forKey: "auctionDuration")
        params.updateValue(biddingPrice, forKey: "auctionBiddingPrice")
        print("params======\(params)")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.updateSellStoryForm.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" login json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func sellFormFill2(uploadTexts: [Data], textNote: String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote: String, supportingDocs: [Data], docNote: String, uploadAudio: String, audioNote: String, storyId: String, uploadThumbnails: [Data], thumbnailNote: String, typeStatus: String, status: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(textNote, forKey: "textNote")
        params.updateValue(imageNote, forKey: "imageNote")
        params.updateValue(videoNote, forKey: "videoNote")
        params.updateValue(docNote, forKey: "docNote")
        //=========== set audio Static
        params.updateValue(uploadAudio, forKey: "uploadAudios")
        params.updateValue(audioNote, forKey: "audioNote")
        params.updateValue(storyId, forKey: "storyId")
        params.updateValue(thumbnailNote, forKey: "thumbnaleNote")
        params.updateValue(typeStatus, forKey: "typeStatus")
        params.updateValue(status, forKey: "status")
        
        let head = ["authtoken":header]
        
        let url = api.sellStoryForm.url()
        
        
        print("===================\(params)")
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            for imageData in uploadImages {
                MultipartFormData.append(imageData, withName: "uploadImages", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for pdfData in uploadTexts {
                MultipartFormData.append(pdfData, withName: "uploadTexts", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for supportingDocs in supportingDocs {
                MultipartFormData.append(supportingDocs, withName: "supportingDocs", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for thumbnailImages in uploadThumbnails {
                MultipartFormData.append(thumbnailImages, withName: "uploadThumbnails", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for videos in uploadVideos {
                MultipartFormData.append(videos, withName: "uploadVideos", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
            }
            
            
            for (key, value) in params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: url, method: .put, headers: head, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ , _ ):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(" story json is:\n\(json)")
                            let parser = storyParsar(json: json)
                            
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        } else {
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                        
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    func sellFormFill2CollobrationWithGroup(uploadTexts: [Data], textNote: String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote: String, supportingDocs: [Data], docNote: String, uploadAudio: String, audioNote: String, storyId: String, uploadThumbnails: [Data], thumbnailNote: String, typeStatus: String, status: String, collaborationGroupId :String, memberIDs : String, collaboratedStatus : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(textNote, forKey: "textNote")
        params.updateValue(imageNote, forKey: "imageNote")
        params.updateValue(videoNote, forKey: "videoNote")
        params.updateValue(docNote, forKey: "docNote")
        //=========== set audio Static
        params.updateValue(uploadAudio, forKey: "uploadAudios")
        params.updateValue(audioNote, forKey: "audioNote")
        params.updateValue(storyId, forKey: "storyId")
        params.updateValue(thumbnailNote, forKey: "thumbnaleNote")
        params.updateValue(typeStatus, forKey: "typeStatus")
        params.updateValue(status, forKey: "status")
        params.updateValue(collaborationGroupId, forKey: "collaborationGroupId")
        params.updateValue(memberIDs, forKey: "members")
        params.updateValue(collaboratedStatus, forKey: "collaboratedStatus")
        
        let head = ["authtoken":header]
        
        let url = api.sellStoryForm.url()
        
        
        print("===================\(params)")
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            for imageData in uploadImages {
                MultipartFormData.append(imageData, withName: "uploadImages", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for pdfData in uploadTexts {
                MultipartFormData.append(pdfData, withName: "uploadTexts", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for supportingDocs in supportingDocs {
                MultipartFormData.append(supportingDocs, withName: "supportingDocs", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for thumbnailImages in uploadThumbnails {
                MultipartFormData.append(thumbnailImages, withName: "uploadThumbnails", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for videos in uploadVideos {
                MultipartFormData.append(videos, withName: "uploadVideos", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
            }
            
            
            for (key, value) in params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: url, method: .put, headers: head, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ , _ ):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(" story json is:\n\(json)")
                            let parser = storyParsar(json: json)
                            
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        } else {
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                        
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    func updateSecondFormStory(storyID : String,uploadTexts: [Data], textNote: String, uploadImages: [Data], imageNote: String, uploadVideos: [Data], videoNote: String, supportingDocs: [Data], docNote: String, uploadAudio: String, audioNote: String,uploadThumbnails: [Data], thumbnailNote: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(textNote, forKey: "textNote")
        params.updateValue(imageNote, forKey: "imageNote")
        params.updateValue(videoNote, forKey: "videoNote")
        params.updateValue(docNote, forKey: "docNote")
        //=========== set audio Static
        params.updateValue(uploadAudio, forKey: "uploadAudios")
        params.updateValue(audioNote, forKey: "audioNote")
        params.updateValue(thumbnailNote, forKey: "thumbnaleNote")
        
        
        let head = ["authtoken":header]
        
        let url = api.updateSecondFormStory.url()
        
        
        print("===================\(params)")
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            for imageData in uploadImages {
                MultipartFormData.append(imageData, withName: "uploadImages", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for pdfData in uploadTexts {
                MultipartFormData.append(pdfData, withName: "uploadTexts", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for supportingDocs in supportingDocs {
                MultipartFormData.append(supportingDocs, withName: "supportingDocs", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for thumbnailImages in uploadThumbnails {
                MultipartFormData.append(thumbnailImages, withName: "uploadThumbnails", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for videos in uploadVideos {
                MultipartFormData.append(videos, withName: "uploadVideos", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
            }
            
            
            for (key, value) in params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: url, method: .put, headers: head, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ , _ ):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(" story json is:\n\(json)")
                            let parser = storyParsar(json: json)
                            
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        } else {
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                        
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    func deleteFileByStoryID(storyID: String,fieldID : String,storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(("\(api.deleteStoryFileByID.url())/\(storyID)/\(fieldID)"),method: .delete,headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    
    
    func getStoryList(page : String,key: String,storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(page, forKey: "page")
        
        //        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTc0NmM4MzFkNTRmYTRiNTliZTUwODEiLCJpYXQiOjE1ODUxMjM3NzR9.wPGWHa9osbXPd9rrTa39gkPNcwSEn7vxebVnTRf-sM8"]
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getUserStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func getFilterStory(page : String,key: String,storyHeader: String,categoryID : String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(categoryID, forKey: "categoryId")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getFilterStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func AddFavoriteStroy(storyId: String, storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: AddTofavoriteModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "storyId")
        print("========\(params)")
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.addJournalistFavList.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("=========\(api.favouriteStory.url())")
                    print(" Favorite Story json is:\n\(json)")
                    let parser = AddfavStoryParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    //    func getMyStoryList(completionBlock: @escaping (_ success: Int, _ message: String, _ data: [storyListModal]?) -> Void){
    //        var params = Dictionary<String,String>()
    //        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
    //
    //        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTczMmE2YzUwZThiNjZhNjBmNWY5NWUiLCJpYXQiOjE1ODQ2ODIxOTF9.B20bQCc_CNS2LxlTVJvO86YIHYE98MqeqBn3YIMjSzM"]
    //
    //        Alamofire.request(api.getMyStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
    //            switch response.result{
    //            case.success:
    //                if let value = response.result.value {
    //                    let json = JSON(value)
    //                    print(" cList json is:\n\(json)")
    //                    let parser = storyListParsar(json: json)
    //                    //                    if parser.responseCode == 200 {
    //                    //                        parser.result.saveUserJSON(json)
    //                    //                    }
    //                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
    //                }else{
    //                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
    //                }
    //
    //            case .failure(let error):
    //                completionBlock(0,error.localizedDescription,nil)
    //            }
    //        }
    //    }
    //
    
    func getMyStoryList(page : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMyStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getMyStoryFilterStory(page :String,storyHeader: String,categoryID : String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(categoryID, forKey: "categoryId")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getMyStoryFilterList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func getMySaveStoryList(header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMySaveStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func getMySaveStoryFilterStory(storyHeader: String,categoryID : String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(categoryID, forKey: "categoryId")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getMyFilterSaveStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchSavedStoryList(searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchSavedStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //    func profilePic(header: String,profileImageUrl: [Data], completionBlock: @escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
    //
    //        let params = Dictionary<String, String>()
    //        let url = "http://3.84.159.2:8094/api/user/profilePic"
    //        print("========\(url)")
    //        print("========\(params)")
    //
    //        let head = ["authtoken": header]
    //
    //
    //        Alamofire.upload(
    //            multipartFormData: { (MultipartFormData) in
    //                for imageData in profileImageUrl {
    //                    MultipartFormData.append(imageData, withName: "profilePic", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
    //                }
    //
    //
    //        },to: url,method:.put,headers: head,encodingCompletion: { encodingResult in
    //            switch encodingResult {
    //            case .success(let upload, _, _):
    //                upload.responseJSON { response in
    //
    //                    switch response.result {
    //                    case .success:
    //                        if let value = response.result.value {
    //                            let json = JSON(value)
    //                            print("\(json)")
    //                            let parser = profileParsar(json: json)
    //
    //                            if parser.responseCode == 200 {
    //                                //                                parser.result.saveUserJSON(json)
    //                            }
    //
    //                            completionBlock(parser.responseCode,parser.result,parser.responseMessage)
    //
    //                        }else{
    //                            completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
    //                        }
    //                    case .failure(let error):
    //                        completionBlock(0,nil,error.localizedDescription)
    //                    }
    //                }
    //            case .failure(let encodingError):
    //                print(encodingError)
    //            }
    //        })
    //    }
    
    
    
    
    func updateProfilePic(header: String,profileImageUrl: UIImage?, completionBlock: @escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
        
        let params = Dictionary<String, String>()
        let url = api.updateProfilePic.url()
        print("========\(url)")
        print("========\(params)")
        
        let head = ["authtoken": header]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "profilePic", fileName: "profilePic", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
                    }
                }
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.put,headers: head,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = profileParsar(json: json)
                            if parser.responseCode == 200 {
                                //                                parser.result.saveUserJSON(json)
                            }
                            completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                        }else{
                            completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
                        }
                    case .failure(let error):
                        completionBlock(0,nil,error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    
    func updatePofileVideo(header: String,profileVideo: Data?, completionBlock: @escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
        
        let params = Dictionary<String, String>()
        let url = api.updateProfileVideo.url()
        print("========\(url)")
        print("========\(params)")
        
        let head = ["authtoken":header]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pvideo = profileVideo {
                    multipartFormData.append(pvideo, withName: "shortVideo", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
                    print("==========videoData=========\(pvideo)")
                }
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.put,headers: head,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = profileParsar(json: json)
                            if parser.responseCode == 200 {
                                //                                parser.result.saveUserJSON(json)
                            }
                            completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                            
                        }else{
                            completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
                        }
                    case .failure(let error):
                        completionBlock(0,nil,error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    func editPersonalInfo(emailId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, passcode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String, header: String, completionBlock: @escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(emailId, forKey: "emailId")
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        params.updateValue(firstName, forKey: "firstName")
        params.updateValue(middleName, forKey: "middleName")
        params.updateValue(lastName, forKey: "lastName")
        params.updateValue(designationId, forKey: "designationId")
        params.updateValue(langCode, forKey: "langCode")
        params.updateValue(passcode, forKey: "password")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(pinCode, forKey: "pinCode")
        params.updateValue(shortBio, forKey: "shortBio")
        params.updateValue(Country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(mailingAddress, forKey: "mailingAddress")
        
        let url = api.editPersonalInfo.url()
        print("========\(url)")
        print("========\(params)")
        let head = ["authtoken":header]
        Alamofire.request(url,method: .put,parameters: params,headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = profileParsar(json: json)
                    
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                }else{
                    completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil,error.localizedDescription)
            }
        }
    }
    
    
    func getAppContentData(type : String ,completionBlock:@escaping ( _ success: Int,  _ message: String, _ data: storyModal?) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(type , forKey: "type")
        
//        let url = "https://apimedia.5wh.com/admin/staticContent"
        let url = api.appContentData.url()
        Alamofire.request(url,method: .get, parameters : params).responseJSON { response in
            switch response.result {
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
            
        }
    }

    func contactUs(name: String, emailID: String, message: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(name, forKey: "name")
        params.updateValue(emailID, forKey: "emailId")
        params.updateValue(message, forKey: "description")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.contactUs.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    func changePassword(oldPassword: String, newPassword: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(oldPassword, forKey: "oldPassword")
        params.updateValue(newPassword, forKey: "newPassword")
        
        let head = ["authtoken" : header]
        
        Alamofire.request(api.changePassword.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    
    func forgetPassword(email: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(email, forKey: "emailId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.forgetPassword.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    
    func otpVerification(email: String, otp : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(email, forKey: "emailId")
        params.updateValue(otp, forKey: "otp")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.otpVerification.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    func resetPassword(email: String, newPass: String, confirPass: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(email, forKey: "emailId")
        params.updateValue(newPass, forKey: "newPassword")
        params.updateValue(confirPass, forKey: "confirmPassword")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.resetPassword.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    
    
    
    
    
    func forgetPasswordWithMObileNumber(phoneCode: String,mobileNumber : String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.forgetPassword.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }

    
    
    func otpVerificationWithMobileNumber(phoneCode: String,mobileNumber : String, otp : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
          params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        params.updateValue(otp, forKey: "otp")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.otpVerification.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }

    
    
    
    func resetPasswordWithMobileNumber(phoneCode: String,mobileNumber : String, newPass: String, confirPass: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
          params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        params.updateValue(newPass, forKey: "newPassword")
        params.updateValue(confirPass, forKey: "confirmPassword")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.resetPassword.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" story json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }

    
    
    func createAssignment(journalistHeadline : String,keyWordId: String, date: String, time:String, journalistDescription : String, country : String, state: String, city: String,brifDesc: String, header: String, live : String, price : String,currency: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistHeadline, forKey: "journalistAssignmentHeadline")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(date, forKey: "date")
        params.updateValue(time, forKey: "time")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(brifDesc, forKey: "journalistAssignmentDescription")
        params.updateValue(live, forKey: "live")
        params.updateValue(price, forKey: "price")
        params.updateValue(currency, forKey: "currency")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.createAssignment.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" Assignment json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func getMyAssignmentList(page : String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.myAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func getSearchAssignmentList(page : String,searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchMyAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func removeAssignmentList(assignmentID: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        
        let head = ["authtoken":header]
        
        Alamofire.request("\(api.removeAssignment.url())/\(assignmentID)",method:.delete, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func getMyEditorAssignmentList(header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.editorAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchEditorsAssignmentList(searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchEditorAssignment.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func replayAssignment(assignmentId: String,assignmentReplay:String ,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        var parms = Dictionary<String,String>()
        parms.updateValue("jaournalistTokenKey", forKey: "authtoken")
        parms.updateValue(assignmentId, forKey: "assignmentId")
        parms.updateValue(assignmentReplay, forKey: "journalistComment")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.assignmentReplay.url(),method: .post,parameters: parms, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" applied job json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    
    func getJobList(header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.jobList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchJobList(searchKey:String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchJobList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func postAppliedJob(jobId: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        var parms = Dictionary<String,String>()
        parms.updateValue("jaournalistTokenKey", forKey: "authtoken")
        parms.updateValue(jobId, forKey: "jobId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.appliedJob.url(),method: .post,parameters: parms, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" applied job json is:\n\(json)")
                    let parser = storyParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
        
    }
    
    func getapproveCollaboratedList(header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.myAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchAllStoryList(page : String,key: String, searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchMyAllTypeStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchMyStoryList(page: String,searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchMyStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func getJournalistDataByStory(journalistID: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: profileModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistID, forKey: "journalistId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getJournalistDataByID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = profileParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getMediaHouseJournalistDataByStory(journalistID: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: profileModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistID, forKey: "journalistId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMediaJournalistByStorty.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = profileParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    
    func getStoryListByID(journalistID: String,page : String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistID, forKey: "journalistId")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getStoryDataByID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    
    func getEarningStoryList(searchKey : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: earningModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.earningStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = earningParsar(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.earningResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func getEarningStoryByID(storyID: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: earningModalByStoryID?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.earningStoryByID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = earningParsarByStoryId(json: json)
                    
                    completionBlock(parser.responseCode,parser.responseMessage,parser.earningResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getupdoadContentData(page : String,storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: contentModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.contentUpload.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = contentParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func deleteUploadedContentByID(contentID: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: contentModal?) -> Void){
        let head = ["authtoken":header]
        
        Alamofire.request("\(api.deleteContentByID.url())/\(contentID)",method: .delete, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = contentParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func renameUploadContent(contentID : String, fileName : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: contentModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(contentID, forKey: "contentId")
        params.updateValue(fileName, forKey: "fileName")
        let head = ["authtoken":header]
        print("params------------\(params)")
        Alamofire.request(api.renameUploadedContent.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = contentParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    func postupdoadContentData(upload: [Data],header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        let url = api.contentUpload.url()
        
        
        print("===================\(params)")
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            for imageData in upload {
                MultipartFormData.append(imageData, withName: "myContent", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
            }
            
            for pdfData in upload {
                MultipartFormData.append(pdfData, withName: "myContent", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for supportingDocs in upload {
                MultipartFormData.append(supportingDocs, withName: "myContent", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
            }
            
            for videos in upload {
                MultipartFormData.append(videos, withName: "myContent", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
            }
            
            
            for (key, value) in params {
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: url, method: .post, headers: head, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ , _ ):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print(" story json is:\n\(json)")
                            let parser = storyParsar(json: json)
                            
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        } else {
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                        
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    func getFavouriteStoryList(storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.addJournalistFavList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = FavoriteListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getReviewByStoryID(storyId: String,storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "storyId")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getReviewByStoryID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func getInviteJournalistList(searchKey: String,Header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: [invitejournalistListModdal]?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":Header]
        
        Alamofire.request(api.getJournalistInviteList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = inviteJournalistParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func createGroup(journalistID: String, groupName: String, groupProfile : Data?,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void) {
        
        var params = Dictionary<String, String>()
        //        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(groupName, forKey: "collaborationGroupName")
        params.updateValue(journalistID, forKey: "journalistId")
        
        print("=params=======\(params)")
        
        
        let head = ["authtoken": header]
        let url = api.createGroup.url()
        
        
        Alamofire.upload(
            multipartFormData: { (MultipartFormData) in
                if groupProfile != nil{
                    MultipartFormData.append(groupProfile!, withName: "collaborationGroupProfile", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    
                }
                
                for (key, value) in params {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
        },to: url,method:.post,headers: head,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = newRequestParsar(json: json)
                            
                            if parser.responseCode == 200 {
                                //                                parser.result.saveUserJSON(json)
                            }
                            completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                            
                        }else{
                            completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                        }
                    case .failure(let error):
                        completionBlock(0,error.localizedDescription,nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    
    func getNewRequestGroupList(searchKey: String,Header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":Header]
        
        Alamofire.request(api.newRequestGroupList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func requestAcceptRejectGroup(groupID: String, status: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(groupID, forKey: "groupId")
        params.updateValue(status, forKey: "status")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.requestAcceptRejectGroup.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func addedGroupList(searchKey: String,Header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":Header]
        
        Alamofire.request(api.addedGroupList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func leaveGroup(groupID: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(groupID, forKey: "groupId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.leaveGroup.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func chatListList(header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        let head = ["authtoken":header]
        
        Alamofire.request(api.chatList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    

    func insertUserChat(mediaHouseID : String,message : String,messageType : String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(mediaHouseID, forKey: "mediahouseId")
        params.updateValue(message, forKey: "message")
        params.updateValue(messageType, forKey: "messageType")
        let head = ["authtoken":header]
        
        Alamofire.request(api.insertChatListJournalist.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    
    
    
    
    func getSaveCollobrateStoryList(header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getSaveCollobrateStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func getSaveCollobrateStoryFilterStory(storyHeader: String,categoryID : String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(categoryID, forKey: "categoryId")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getFilterSaveCollobrateStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getSearchSavedCollobrateStoryList(searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getSearchSaveCollobateStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func saveStoryPostById(storyId: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "stroyId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.saveStoryPostById.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func deleteStory(storyId: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "storyId")
        let head = ["authtoken":header]
        
        Alamofire.request(api.deleteStoryJM.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    

    func translateJM(audio: String?, video: Data?, text: Data?, emailId: String, serviceType: String, toLanguage: String,fileType: String,fileSize : String,amount: String,transactionID : String,header: String,completionBlock: @escaping (_ success: Int, _ userSignIn : TranslateModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(emailId, forKey: "emailId")
        params.updateValue(serviceType, forKey: "serviceType")
        params.updateValue(toLanguage, forKey: "toLanguage")
        params.updateValue(fileType, forKey: "fileType")
        params.updateValue(fileSize, forKey: "fileSize")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(transactionID, forKey: "transactionId")
        let head = ["authtoken":header]
        
        let url = api.transnlateAndTranscribe.url()
        print("========\(url)")
        print("========\(params)")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if fileType == "audio" {
                    //                    if let pimage = audio {
                    //                        if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                    //                            multipartFormData.append(data, withName: "file", fileName: "file", mimeType: "image/jpeg")
                    //                            print("==========imageData=========\(data)")
                    //                        }
                    //                    }
                } else if fileType == "text" {
                    if let pdfDoc = text {
                        multipartFormData.append(pdfDoc, withName: "file", fileName: "\(Date().timeIntervalSince1970).txt", mimeType: "application/pdf")
                        print("==========pdfData=========\(pdfDoc)")
                    }
                } else if fileType == "video" {
                    if let pvideo = video {
                        multipartFormData.append(pvideo, withName: "file", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
                        print("==========videoData=========\(pvideo)")
                    }
                }
                
                
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.post,headers: head,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = TranslateParser(json: json)
                            
                            //                            if parser.responseCode == 200 {
                            //                                parser.result.saveUserJSON(json)
                            //                            }
                            completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                            
                        }else{
                            completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
                        }
                    case .failure(let error):
                        completionBlock(0,nil,error.localizedDescription)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    
    //---------TranslateList--------
    func translateListJM(header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: TranslateListModel?) -> Void){
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.translateListJM.url(),method: .get, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.translateListJM.url())
                    print("TranslateList json is:\n\(json)")
                    let parser = TranslateListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //-------DeleteTranslate----
    func deleteTranslateJM(translateId: String,header:String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: TranslateListModel?) -> Void) {
        let head = ["authtoken":header]
        print("translateId================\(translateId)")
        print("==========\(api.traslateDeleteJM.url())/\(translateId)")
        Alamofire.request("\(api.traslateDeleteJM.url())/\(translateId)", method: .delete,headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("==========\(api.traslateDeleteJM.url())\(translateId)")
                    print("deleteTranslate JSON\n--------------------\n\(json)\n=====================")
                    let parser = TranslateListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                } else {
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //==========approved colloborated list
    func getapprovedCollobratedLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.approvedCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //==========approved colloborated Search list
    func getapprovedCollobratedSearchLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.approvedCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    //==========pending colloborated list
    func getpendingCollobratedLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.pendingCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //==========pending colloborated Search list
    func getPendingCollobratedSearchLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.pendingCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //==========invite colloborated list
    func getInviteCollobratedLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.invitedCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //==========invite colloborated Search list
    func getInviteCollobratedSearchLists(searchkey: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchkey, forKey: "searchKey")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.invitedCollaboratedStoryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //==========invitation collaborated story
    func invitationCollobratedStoryStatus(groupID: String,status: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: collobrationModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(groupID, forKey: "groupId")
        params.updateValue(status, forKey: "status")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.collaboratedStoryInvitationStatus.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = colloborationListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    //-------NotificationList----
    func notificationLists(header:String,completionBlock: @escaping (_ success: Int, _ data: [NotificationList]? ,_ message: String) -> Void) {
        let params = Dictionary<String,String>()
        let head = ["authtoken":header]
        Alamofire.request(api.notificationList.url(), method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.notificationListMedia.url())")
                    print("notificationList JSON\n--------------------\n\(json)\n=====================")
                    let parser = NotificationParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //-------NotificationList----
    func clearNotificationLists(notificationId: String,header:String,completionBlock: @escaping (_ success: Int, _ data: [NotificationList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue(notificationId, forKey: "notificationId")
        let head = ["authtoken":header]
        print(params)
        Alamofire.request(api.notificationList.url(), method: .put,parameters: params,headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.notificationListMedia.url())")
                    print("notificationList JSON\n--------------------\n\(json)\n=====================")
                    let parser = NotificationParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    
    
    func plansList(Header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: paymentsModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":Header]
        
        Alamofire.request(api.membershipPlansListJM.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = membershipParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    func memberShipPayments(amount:String,paymentMode: String,transactionID: String,memberShipID: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: paymentsModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(paymentMode, forKey: "paymentMode")
        params.updateValue(transactionID, forKey: "transactionId")
        params.updateValue(memberShipID, forKey: "membershipId")
        
        print("params======\(params)")
        let head = ["authtoken":header]
        
        Alamofire.request(api.mebershipPaymentJM.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = membershipParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //================
    func getMediaMemberPlansList(Header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: paymentsModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":Header]
        
        Alamofire.request(api.getMediaMembersPlans.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = membershipParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //===========mediaMemberShipPayments
    func mediaMemberShipPayments(amount:String,paymentMode: String,transactionID: String,memberShipID: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: paymentsModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(paymentMode, forKey: "paymentMode")
        params.updateValue(transactionID, forKey: "transactionId")
        params.updateValue(memberShipID, forKey: "membershipId")
        
        print("params======\(params)")
        let head = ["authtoken":header]
        
        Alamofire.request(api.membershipPlansPayMedia.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = membershipParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }


    
    
    func checkCoupon(couponName:String,couponType: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: paymentsModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(couponName, forKey: "couponName")
        params.updateValue(couponType, forKey: "couponType")
        
        
        print("params======\(params)")
        let head = ["authtoken":header]
        
        Alamofire.request(api.checkCouponJM.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = membershipParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func ethicMemberEnquiry(header:String ,completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void) {
        let head = ["authtoken":header]
        Alamofire.request(api.ethicMemberEnquiry.url(), method: .get, headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.ethicMember.url())")
                    print("currency JSON\n--------------------\n\(json)\n=====================")
                    let parser = EthicMemberEnquiryParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                } else {
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func increaseStoryViews(storyId: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "stroyId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.increaseStoryView.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    
    func getTranslateAndtranscribePrice(fileSize : String,fileType : String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: profileModal? ) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(fileSize, forKey: "fileSize")
        params.updateValue(fileType, forKey: "fileType")
        
        print("params======\(params)")
        let head = ["authtoken":header]
        
        Alamofire.request(api.translateFIlePriceJM.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = profileParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func getTranslateAndtranscribePriceMedia(fileSize : String,fileType : String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: profileModal? ) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(fileSize, forKey: "fileSize")
        params.updateValue(fileType, forKey: "fileType")
        
        print("params======\(params)")
        let head = ["authtoken":header]
        
        Alamofire.request(api.translatePriceMedia.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = profileParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    //================
    func liveVideoStart(assignmentID: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(assignmentID, forKey: "assignmentId")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.liveVideoStartJournalist.url(),method:.put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func getFaqMediaAndJournalist(userType : String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: [faqModal]?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(userType, forKey: "userType")
        
        Alamofire.request(api.getFaqMediaAndJournalist.url(),method: .get,parameters: params).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = faqParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    func getMediaAssignmentByJournalistID(journalistID : String,page : String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: listStory?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistID, forKey: "journalistId")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMediaJournalistAssignmentByID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = storyListParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    func getRegistrationFeePlansListing(completionBlock: @escaping (_ success: Int, _ message: String, _ data: [registrationFeePlansListModal]?) -> Void){

            
        Alamofire.request(api.getRegistrationFeePlans.url(),method: .get).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = registrationFeeParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    func registrationFeePayment(JournalistId : String,amount : String,paymentMode : String,transactionID : String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: [registrationFeePlansListModal]?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(JournalistId, forKey: "journalistId")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(paymentMode, forKey: "paymentMode")
        params.updateValue(transactionID, forKey: "transactionId")
        
//        let head = ["authtoken":Header]
        
        Alamofire.request(api.registrationFeePayment.url(),method: .get,parameters: params).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = registrationFeeParser(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    func journalistEthicsChatList(header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        let head = ["authtoken":header]
        
        Alamofire.request(api.journalistEthicsChat.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func insertJournalistEthicsChatList(ethicsCommitteId: String,message: String,messageType: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: newRequestModal?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(ethicsCommitteId, forKey: "ethicsCommitteId")
        params.updateValue(message, forKey: "message")
        params.updateValue(messageType, forKey: "messageType")
        let head = ["authtoken":header]
        
        Alamofire.request(api.journalistEthicsChat.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(" cList json is:\n\(json)")
                    let parser = newRequestParsar(json: json)
                    //                    if parser.responseCode == 200 {
                    //                        parser.result.saveUserJSON(json)
                    //                    }
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    
}


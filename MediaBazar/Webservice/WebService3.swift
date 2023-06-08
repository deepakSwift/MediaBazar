//
//  WebService3.swift
//  MediaBazar
//
//  Created by deepak Kumar on 26/03/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

class WebService3: NSObject {
    
    static let sharedInstance = WebService3()
    
    
    //-------MediaTypeSearch----
    func MediaType(completionBlock: @escaping (_ success: Int, _ data: [CountryList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.mediaType.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.countrySearch.url())")
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = CountryParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //------InviteUserMedia Api------
    func getInviteUserMediaPersonalInfo(profileImageUrl: UIImage?,organisationName: String,mediahouseTypeId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String,phoneCode: String,header : String, completionBlock: @escaping (_ success: Int, _ userSignIn : User?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        params.updateValue(firstName, forKey: "firstName")
        params.updateValue(middleName, forKey: "middleName")
        params.updateValue(lastName, forKey: "lastName")
        params.updateValue(designationId, forKey: "designationId")
        params.updateValue(langCode, forKey: "langCode")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(pinCode, forKey: "pinCode")
        params.updateValue(shortBio, forKey: "shortBio")
        params.updateValue(Country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(mailingAddress, forKey: "mailingAddress")
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(organisationName, forKey: "organizationName")
        params.updateValue(mediahouseTypeId, forKey: "mediahouseTypeId")
        
        
        let url = api.inviteUserMediaHousePersonalInfo.url()
        print("========\(url)")
        print("========\(params)")
        let head = ["authtoken" : header]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "logo", fileName: "logo", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
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
                            let parser = UserParsar(json: json)
                            
                            if parser.responseCode == 200 {
                                parser.result.saveUserJSON(json)
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
    
    
    //------PersonalInfo Api------
    func getPersonalInfo(profileImageUrl: UIImage?,organisationName: String,mediahouseTypeId: String, emailId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, passcode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String,phoneCode: String, completionBlock: @escaping (_ success: Int, _ userSignIn : User?, _ message: String) -> Void) {
        
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
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(organisationName, forKey: "organizationName")
        params.updateValue(mediahouseTypeId, forKey: "mediahouseTypeId")
        
        let url = api.mediaHousePersonalInfo.url()
        print("========\(url)")
        print("========\(params)")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "logo", fileName: "logo", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
                    }
                }
                
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.post,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = UserParsar(json: json)
                            
                            if parser.responseCode == 200 {
                                parser.result.saveUserJSON(json)
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
    
    //------- Frequency ----
    func MediaFrequency(completionBlock: @escaping (_ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.mediahousefrequency.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.countrySearch.url())")
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //-------company Information----
    func companyInformation(areaOfInterest: String, targetAudience: String, frequencyId: String, mediahouseId: String, keywordName: String, stepCount: String, website: String, audience: String, completionBlock: @escaping (_ success: Int, _ userSignIn : CompanyInfoModel? ,_ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(areaOfInterest, forKey: "areaOfInterest")
        params.updateValue(targetAudience, forKey: "targetAudience")
        params.updateValue(frequencyId, forKey: "frequencyId")
        params.updateValue(mediahouseId, forKey: "mediahouseId")
        params.updateValue(keywordName, forKey: "keywordName")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(website, forKey: "website")
        params.updateValue(audience, forKey: "audience")
        print("============\(params)")
        
        Alamofire.request(api.companyInformation.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.companyInformation.url())")
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = CompanyInfoParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //---------SOCIAL_MEDIA_LINK--------------
    func socialMediaLinkData( facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String,instagramLink: String, youtubeLink: String,mediahouseId: String, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : User?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(facebookLink, forKey: "facebookLink")
        params.updateValue(twitterLink, forKey: "twitterLink")
        params.updateValue(linkedinLink, forKey: "linkedinLink")
        params.updateValue(snapChatLink, forKey: "snapChatLink")
        params.updateValue(instagramLink, forKey: "instagramLink")
        params.updateValue(youtubeLink, forKey: "youtubeLink")
        params.updateValue(mediahouseId, forKey: "mediahouseId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.mediaSocialAccountLink.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.socialMedialink.url())")
                    print("socialMedialink JSON\n--------------------\n\(json)\n=====================")
                    let parser = UserParsar(json: json)
                    if parser.responseCode == 200 {
                        parser.result.saveUserJSON(json)
                    }
                    completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
        
    }
    
    
    //--------- MEDIA_STORY ------------
    func getStoryList(page: String ,key: String, storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(page, forKey: "page")
        
        //        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTc0NmM4MzFkNTRmYTRiNTliZTUwODEiLCJpYXQiOjE1ODUxMjM3NzR9.wPGWHa9osbXPd9rrTa39gkPNcwSEn7vxebVnTRf-sM8"]
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getMediaStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getMediaStory.url())
                    print(" Media Story json is:\n\(json)")
                    let parser = mediaStoryParsar(json: json)
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
    
    //--------search Story
    func getSearchAllStoryList(page: String,key: String, searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(searchKey, forKey: "searchKey")
        print(params)
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.searchStory.url())
                    print(" search json is:\n\(json)")
                    let parser = mediaStoryParsar(json: json)
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
    
    //-------  Admin category ---------
    func adminCategoryListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.adminCategory.url(), method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //--------- FILTER STORY ------------
    func getFilterStoryList(page: String,key: String,categoryId: String, storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(key, forKey: "key")
        params.updateValue(categoryId, forKey: "categoryId")
        params.updateValue(page, forKey: "page")
        print("========\(params)")
        
        //        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTc0NmM4MzFkNTRmYTRiNTliZTUwODEiLCJpYXQiOjE1ODUxMjM3NzR9.wPGWHa9osbXPd9rrTa39gkPNcwSEn7vxebVnTRf-sM8"]
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.filetrStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("=========\(api.filetrStory.url())")
                    print(" Filter Story json is:\n\(json)")
                    let parser = mediaStoryParsar(json: json)
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
    
    
    //--------- Add Favorite Story ------------
    func AddToFavoriteStroy(storyId: String, storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: AddTofavoriteModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "storyId")
        print("========\(params)")
        
        //        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTc0NmM4MzFkNTRmYTRiNTliZTUwODEiLCJpYXQiOjE1ODUxMjM3NzR9.wPGWHa9osbXPd9rrTa39gkPNcwSEn7vxebVnTRf-sM8"]
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.favouriteStory.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
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
    
    //-------JobCategory---------
    func jobCategoryListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.jobCategory.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //-------JobfunctionalCategory---------
    func jobFunctionalListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.jobFunctionalArea.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("login JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //-------JobRoleCategory---------
    func JobRoleListData(searchKey: String, completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue(searchKey, forKey: "searchKey")
        
        Alamofire.request(api.jobRole.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.jobRole.url())
                    print(params)
                    print("JobRole JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //-------JobQualificationCategory---------
    func JobQualificationData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        Alamofire.request(api.jobQualification.url(), method: .get,parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.jobRole.url())
                    print("JobQualification JSON\n--------------------\n\(json)\n=====================")
                    let parser = languageParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //------------journalistProfile
    func mediaHouseProfileData(header: String,completionBlock: @escaping ( _ success: Int, _ data: CompanyProfileModel? ,_ message: String) -> Void){
        
        var params = Dictionary<String,String >()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMediahouseProfile.url(), method: .get,parameters: params, headers: head).responseJSON{(response) in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print("journalist JSON\n---------------\n\(json)\n=====================")
                    let Parser = CompanyProfileParser(json: json)
                    completionBlock(Parser.responseCode, Parser.result, Parser.responseMessage)
                }else{
                    completionBlock(0, nil, response.result.error?.localizedDescription ?? "Something Went Wrong")
                }
            case .failure(let error):
                completionBlock(0, nil,error.localizedDescription)
                
            }
        }
    }
    
    //------updateLogo-------
    func updateLogo(header: String,profileImageUrl: UIImage?, completionBlock: @escaping (_ success: Int, _ userSignIn : CompanyInfoModel?, _ message: String) -> Void) {
        
        let params = Dictionary<String, String>()
        //           let url = "https://apimedia.5wh.com/api/mediahouse/logo"
        let url = api.mediaHouseLogo.url()
        print("========\(url)")
        print("========\(params)")
        
        let head = ["authtoken": header]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "logo", fileName: "logo", mimeType: "image/jpeg")
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
                            let parser = CompanyInfoParser(json: json)
                            
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
    
    //------editPersonalInfo Api------
    func editPersonalInfo(emailId: String, mobileNumber: String, firstName: String, middleName: String, lastName: String, designationId: String, langCode: String, currency: String, pinCode: String, shortBio: String, country: String, state: String, city: String, stepCount: String, organizationName: String, mediahouseTypeId: String, mailingAddress: String,header: String, completionBlock: @escaping (_ success: Int, _ userSignIn : SocialMedialinkModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(emailId, forKey: "emailId")
        params.updateValue(mobileNumber, forKey: "mobileNumber")
        params.updateValue(firstName, forKey: "firstName")
        params.updateValue(middleName, forKey: "middleName")
        params.updateValue(lastName, forKey: "lastName")
        params.updateValue(designationId, forKey: "designationId")
        params.updateValue(langCode, forKey: "langCode")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(pinCode, forKey: "pinCode")
        params.updateValue(shortBio, forKey: "shortBio")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(stepCount, forKey: "stepCount")
        params.updateValue(mailingAddress, forKey: "mailingAddress")
        //params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(organizationName, forKey: "organizationName")
        params.updateValue(mediahouseTypeId, forKey: "mediahouseTypeId")
        let head = ["authtoken":header]
        print(params)
        
        Alamofire.request(api.mediaHousePersonalInfo.url(),method: .put,parameters: params,headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("=========\(api.mediaHousePersonalInfo.url())")
                    print("Edit personalInfo json is:\n\(json)")
                    let parser = UserParsar(json: json)
                    completionBlock(parser.responseCode,parser.resultPersonalInfo,parser.responseMessage)
                }else{
                    completionBlock(0,nil,response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
                
            case .failure(let error):
                completionBlock(0,nil,error.localizedDescription)
            }
        }
    }
    
    //---CangePassword-----
    func changeMediaPassword(oldPassword: String, newPassword: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(oldPassword, forKey: "oldPassword")
        params.updateValue(newPassword, forKey: "newPassword")
        
        let head = ["authtoken" : header]
        
        Alamofire.request(api.changePasswordMedia.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
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
    
    //-----ConatctUs----
    func mediaContactUs(name: String, emailID: String, message: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(name, forKey: "name")
        params.updateValue(emailID, forKey: "emailId")
        params.updateValue(message, forKey: "message")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediaContactUs.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
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
    
    //--------postMediaEnquiryData-------
    func postMediaEnquiryData(enquiryTitle: String, enquiryDescription: String,header: String, completionBlock: @escaping ( _ success: Int, _ data: EnquiryModel? ,_ message: String) -> Void) {
        
        var params = Dictionary<String,String >()
        params.updateValue("EnquiryTokenKey", forKey: "authtoken")
        params.updateValue(enquiryTitle, forKey: "enquiryTitle")
        params.updateValue(enquiryDescription, forKey: "enquiryDescription")
        print(params)
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediaEnquiry.url(), method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("Enquiry JSON\n-----------------\n\(json)\n=====================")
                    let parser = EnquiryParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //---------EnquiryData--------
    func EnquiryMediaData(page : String ,header:String,completionBlock: @escaping ( _ success: Int, _ data: EnquiryModel? ,_ message: String) -> Void) {
        
        var params = Dictionary<String,String >()
        params.updateValue("EnquiryTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediaEnquiry.url(), method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("Enquiry JSON\n-----------------\n\(json)\n=====================")
                    let parser = EnquiryParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    
    //---------FavoriteListData--------
    func favoriteStoryList(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.favouriteMediaStory.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.favouriteMediaStory.url())
                    print(" Fav Story json is:\n\(json)")
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
    
    //---------AssgnmentList--------
    func assgnmentList(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: AssignmentListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediahouseAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.mediahouseAssignmentList.url())
                    print("AssignmentList json is:\n\(json)")
                    let parser = AssignmnetParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //-------postAssignment----
    func postAssignment(assignmentTitle: String, langCode: String,keyWordId: String, date: String, time:String, currency: String, price:String, country: String, state: String, city: String, assignmentDescription: String, header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: PostAssignmentModel?) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(assignmentTitle, forKey: "assignmentTitle")
        params.updateValue(langCode, forKey: "langCode")
        params.updateValue(keyWordId, forKey: "keywordName")
        params.updateValue(date, forKey: "date")
        params.updateValue(time, forKey: "time")
        params.updateValue(currency, forKey: "currency")
        params.updateValue(price, forKey: "price")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        
        params.updateValue(assignmentDescription, forKey: "assignmentDescription")
        print("============\(params)")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.postMediaAssignment.url(), method: .post, parameters : params, headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.postMediaAssignment.url())")
                    print("postAssignment JSON\n--------------------\n\(json)\n=====================")
                    let parser = PostAssignmentParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                } else {
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //--------Search Assignments---------
    func getSearchAssignments(page: String,searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: AssignmentListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        print(params)
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchMediaAssignment.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.searchStory.url())
                    print(" search json is:\n\(json)")
                    let parser = AssignmnetParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------JournalistAssgnmentList--------
    func journalistAssgnmentList(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: AssignmentListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.journalistAssignmentList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.mediahouseAssignmentList.url())
                    print("AssignmentList json is:\n\(json)")
                    let parser = JournalistAssignmentParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //---------CreateJob--------
    func createJob(jobRoleId: String,jobQualificationId: String,jobCategoryId: String,jobFunctionalAreaId: String,jobKeywordName: String,workExperience: String,expectedSalary: String,employementType: String,jobDescription: String,country: String,state: String,city: String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: CreatJobModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(jobRoleId, forKey: "jobRoleId")
        params.updateValue(jobQualificationId, forKey: "jobQualificationId")
        params.updateValue(jobCategoryId, forKey: "jobCategoryId")
        params.updateValue(jobFunctionalAreaId, forKey: "jobFunctionalAreaId")
        params.updateValue(jobKeywordName, forKey: "jobKeywordName")
        params.updateValue(workExperience, forKey: "workExperience")
        params.updateValue(expectedSalary, forKey: "expectedSalary")
        params.updateValue(employementType, forKey: "employementType")
        params.updateValue(jobDescription, forKey: "jobDescription")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        let head = ["authtoken":header]
        print(params)
        
        Alamofire.request(api.createjobMedia.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.createjobMedia.url())
                    print("createjobMedia json is:\n\(json)")
                    let parser = CreateJobParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------GetJobListing--------
    func getJobListing(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJobModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.createjobMedia.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.mediahouseAssignmentList.url())
                    print("jobMediaList json is:\n\(json)")
                    let parser = GetJobListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------UpdateJob--------
    func updateJob(jobRoleId: String,jobQualificationId: String,jobCategoryId: String,jobFunctionalAreaId: String,jobKeywordName: String,workExperience: String,expectedSalary: String,employementType: String,jobDescription: String,country: String,state: String,city: String,jobId: String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: CreatJobModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(jobRoleId, forKey: "jobRoleId")
        params.updateValue(jobQualificationId, forKey: "jobQualificationId")
        params.updateValue(jobCategoryId, forKey: "jobCategoryId")
        params.updateValue(jobFunctionalAreaId, forKey: "jobFunctionalAreaId")
        params.updateValue(jobKeywordName, forKey: "jobKeywordName")
        params.updateValue(workExperience, forKey: "workExperience")
        params.updateValue(expectedSalary, forKey: "expectedSalary")
        params.updateValue(employementType, forKey: "employementType")
        params.updateValue(jobDescription, forKey: "jobDescription")
        params.updateValue(country, forKey: "country")
        params.updateValue(state, forKey: "state")
        params.updateValue(city, forKey: "city")
        params.updateValue(jobId, forKey: "jobId")
        let head = ["authtoken":header]
        print(params)
        
        Alamofire.request(api.createjobMedia.url(),method: .put,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.createjobMedia.url())
                    print("createjobMedia json is:\n\(json)")
                    let parser = CreateJobParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //--------searchJob
    func searchJob(page : String,searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJobModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        print(params)
        let head = ["authtoken":header]
        
        Alamofire.request(api.searchMediaJob.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.searchMediaJob.url())
                    print(" searchMediaJob json is:\n\(json)")
                    let parser = GetJobListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.result)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------PurchaseStoryListData--------
    func purchaseStoryList(page : String,searchKey: String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        print(params)
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.purchaseStroryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseStroryList.url())
                    print(" PurchaseStroryList json is:\n\(json)")
                    let parser = FavoriteListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //--------searchPurchaseStory
    func searchPurchaseStory(page : String,searchKey: String,header: String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        print(params)
        let head = ["authtoken":header]
        
        Alamofire.request(api.purchaseStroryList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseStroryList.url())
                    print(" search json is:\n\(json)")
                    let parser = FavoriteListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //-------CurrenctList----
    func currenctList(completionBlock: @escaping (_ success: Int, _ data: [CountryList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.currency.url(), method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.currency.url())")
                    print("currency JSON\n--------------------\n\(json)\n=====================")
                    let parser = CountryParser(json: json)
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
    func notificationList(header:String,completionBlock: @escaping (_ success: Int, _ data: [NotificationList]? ,_ message: String) -> Void) {
        let params = Dictionary<String,String>()
        let head = ["authtoken":header]
        Alamofire.request(api.notificationListMedia.url(), method: .get,parameters: params, headers: head).responseJSON { (response) in
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
    func clearNotificationList(notificationId: String,header:String,completionBlock: @escaping (_ success: Int, _ data: [NotificationList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue(notificationId, forKey: "notificationId")
        let head = ["authtoken":header]
        print(params)
        Alamofire.request(api.notificationListMedia.url(), method: .put,parameters: params,headers: head).responseJSON { (response) in
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
    
    //------PersonalInfo Api------
    func translateTranscribe(profileImageUrl: UIImage?,organisationName: String,mediahouseTypeId: String, emailId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, passcode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String,phoneCode: String, completionBlock: @escaping (_ success: Int, _ userSignIn : SocialMedialinkModel?, _ message: String) -> Void) {
        
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
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(organisationName, forKey: "organizationName")
        params.updateValue(mediahouseTypeId, forKey: "mediahouseTypeId")
        
        //          let url = "https://apimedia.5wh.com/api/mediahouse/translate"
        let url = api.translate.url()
        print("========\(url)")
        print("========\(params)")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "logo", fileName: "logo", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
                    }
                }
                
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.post,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = UserParsar(json: json)
                            
                            //                              if parser.responseCode == 200 {
                            //                                  parser.result.saveUserJSON(json)
                            //                              }
                            completionBlock(parser.responseCode,parser.resultPersonalInfo,parser.responseMessage)
                            
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
    
    //------Translate Api------
    func translate(audio: String?, video: Data?, text: Data?, emailId: String, serviceType: String, toLanguage: String,fileType: String,fileSize : String,amount: String,transactionID : String,header: String,completionBlock: @escaping (_ success: Int, _ userSignIn : TranslateModel?, _ message: String) -> Void)  {
        
        var params = Dictionary<String, String>()
        params.updateValue(emailId, forKey: "emailId")
        params.updateValue(serviceType, forKey: "serviceType")
        params.updateValue(toLanguage, forKey: "toLanguage")
        params.updateValue(fileType, forKey: "fileType")
        params.updateValue(fileSize, forKey: "fileSize")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(transactionID, forKey: "transactionId")
        
        let head = ["authtoken":header]
        
        //        let url = "https://apimedia.5wh.com/api/mediahouse/translate"
        let url = api.translate.url()
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
    func translateList(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: TranslateListModel?) -> Void){
        var params = Dictionary<String, String>()
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.translate.url(),method: .get, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.translate.url())
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
    func deleteTranslate(translateId: String,header:String,completionBlock: @escaping (_ success: Int, _ message: String, _ data: TranslateListModel?) -> Void) {
        let head = ["authtoken":header]
        print("translateId================\(translateId)")
        print("==========\(api.deleteTranslate.url())/\(translateId)")
        Alamofire.request("\(api.deleteTranslate.url())/\(translateId)", method: .delete,headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("==========\(api.deleteTranslate.url())\(translateId)")
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
    
    //-------GetreplybyAssignmentId-------
    func replyList(assignmentId:String ,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        var params = Dictionary<String, String>()
        params.updateValue(assignmentId, forKey: "assignmentId")
        let head = ["authtoken":header]
        
        Alamofire.request(api.getReply.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getReply.url())
                    print("getReply json is:\n\(json)")
                    let parser = JournalistReplyParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //-------chatList-------
    func chatList(header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.chatLists.url(),method: .get, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.chatLists.url())
                    print("chatList json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //-------chatList-------
    func insertMediaChat(journalistID: String,message : String,messageType : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        var params = Dictionary<String, String>()
        params.updateValue(journalistID, forKey: "journalistId")
        params.updateValue(message, forKey: "message")
        params.updateValue(messageType, forKey: "messageType")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.chatLists.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.chatLists.url())
                    print("chatList json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    
    //-------editorialChatList-------
    func editorialChatList(header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.editorialChatList.url(),method: .get, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.editorialChatList.url())
                    print("editorialChatList json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //-------editorialChatInsert-------
    func editorialChatInsert(header:String, editorialBoardID: String, message: String,
                             messageType: String, completionBlock: @escaping (_ success: Int, _ message: String) -> Void){
        
        let head = ["authtoken":header]
        
        var params = [String : String]()
        params.updateValue(editorialBoardID, forKey: "editorialBoardId")
        params.updateValue(message, forKey: "message")
        params.updateValue(messageType, forKey: "messageType")
        
        Alamofire.request(api.editorialChatList.url(),method: .post, parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.editorialChatList.url())
                    print("editorialChatInsert json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription)
            }
        }
    }
    
    
    //-------GetReviews-------
    func reviewList(storyId:String ,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        var params = Dictionary<String, String>()
        params.updateValue(storyId, forKey: "storyId")
        let head = ["authtoken":header]
        print(params)
        
        Alamofire.request(api.storyReview.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.storyReview.url())
                    print("storyReview json is:\n\(json)")
                    let parser = JournalistReplyParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---PostReview-----
    func postReview(storyId: String, comment: String, plagiarism: String, obscenities: String, fairObjective: String, consistency: String, spellingAndGrammar: String ,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "story_id")
        params.updateValue(comment, forKey: "comment")
        params.updateValue(obscenities, forKey: "obscenitiesProfanitiesAndVulgarities")
        params.updateValue(fairObjective, forKey: "fairObjectiveAndAccuracy")
        params.updateValue(consistency, forKey: "consistencyAndClarity")
        params.updateValue(plagiarism, forKey: "plagiarism")
        params.updateValue(spellingAndGrammar, forKey: "spellingAndGrammar")
        print(params)
        
        let head = ["authtoken" : header]
        
        Alamofire.request(api.storyReview.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.storyReview.url())
                    print(" storyReview json is:\n\(json)")
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
    
    //-------EthicEnquiry----
    func ethicEnquiry(header:String ,completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void) {
        let head = ["authtoken":header]
        Alamofire.request(api.ethicMember.url(), method: .get, headers: head).responseJSON { (response) in
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
    
    //---PostReview-----
    func paymentNow(amount: String, paymentMode: String, storyId: String, transactionId: String,header: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: storyModal?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyId, forKey: "story_id")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(paymentMode, forKey: "paymentMode")
        params.updateValue(transactionId, forKey: "transactionId")
        print(params)
        
        let head = ["authtoken" : header]
        
        Alamofire.request(api.storyPayment.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.storyPayment.url())
                    print(" storyReview json is:\n\(json)")
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
    
    
    
    //---------PurchaseStoryListData--------
    func bidStoryList(page : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        print(params)
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediaBidding.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseStroryList.url())
                    print(" PurchaseStroryList json is:\n\(json)")
                    let parser = FavoriteListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    func biddingPlaceStory(storyID : String, Price : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: FavoriteDocModel?) -> Void){
        
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(storyID, forKey: "storyId")
        params.updateValue(Price, forKey: "price")
        print(params)
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.mediaBidding.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseStroryList.url())
                    print(" PurchaseStroryList json is:\n\(json)")
                    let parser = FavoriteListParsar(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //---------NewEventList--------
    func newEventlist(page : String ,searchKey : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: EventListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(searchKey, forKey: "searchKey")
        params.updateValue(page, forKey: "page")
        let head = ["authtoken":header]
        
        Alamofire.request(api.newEventList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.newEventList.url())
                    print("Event json is:\n\(json)")
                    let parser = EveltListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------purchaseList--------
    func purchaseList(searchKey : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: [PurchaseDetailsModel]?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(searchKey, forKey: "searchKey")
        let head = ["authtoken":header]
        
        Alamofire.request(api.purchaseEventList.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseEventList.url())
                    print("Event json is:\n\(json)")
                    let parser = PurchaseListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //---------getVideoStatus--------
    func getVideoStatus(assignmentIDs : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: PurchaseDetailsModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(assignmentIDs, forKey: "assignmentId")
        let head = ["authtoken":header]
        
        Alamofire.request(api.getVideoEventStatus.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.purchaseEventList.url())
                    print("Event json is:\n\(json)")
                    let parser = GetEventStatusParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    
    //---------getCommentVideo--------
    func getCommentVideoList(assignmentID : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: EventListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(assignmentID, forKey: "assignmentId")
        let head = ["authtoken":header]
        
        Alamofire.request(api.getVideoComment.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getVideoComment.url())
                    print("Event json is:\n\(json)")
                    let parser = EveltListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------getCommentVideo--------
    func addCommentVidep(assignmentID : String,message : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: EventListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(assignmentID, forKey: "assignmentId")
        params.updateValue(message, forKey: "message")
        let head = ["authtoken":header]
        
        Alamofire.request(api.addVideoComment.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getVideoComment.url())
                    print("Event json is:\n\(json)")
                    let parser = EveltListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    //---------paymentNewEvent--------
    func paymentNewEvent(assignmentID : String,amount : String, paymentMode: String,transactionID : String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: EventListModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(assignmentID, forKey: "assignmentId")
        params.updateValue(amount, forKey: "amount")
        params.updateValue(paymentMode, forKey: "paymentMode")
        params.updateValue(transactionID, forKey: "transactionId")
        let head = ["authtoken":header]
        
        Alamofire.request(api.newEventPayment.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getVideoComment.url())
                    print("Event json is:\n\(json)")
                    let parser = EveltListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    
    //--------- MEDIA_STORY_BY_JOURNALIST_ID ------------
    func getStoryListByJournalistID(journalistID : String, page: String, storyHeader: String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: MediaStroyModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        params.updateValue(journalistID, forKey: "journalistId")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":storyHeader]
        
        Alamofire.request(api.getMediaStoryListByJournalistID.url(),method: .get,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.getMediaStory.url())
                    print(" Media Story json is:\n\(json)")
                    let parser = mediaStoryParsar(json: json)
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
    
    
    func mediaEthicsChatList(header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMediaEthicsChatList.url(),method: .get, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.chatLists.url())
                    print("chatList json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }
    
    func insertMediaEthicsChatList(ethicsCommitteId: String,message: String,messageType: String,header:String, completionBlock: @escaping (_ success: Int, _ message: String, _ data: GetJornalistReplyModel?) -> Void){
        var params = Dictionary<String,String>()
        params.updateValue(ethicsCommitteId, forKey: "ethicsCommitteId")
        params.updateValue(message, forKey: "message")
        params.updateValue(messageType, forKey: "messageType")
        let head = ["authtoken":header]
        
        Alamofire.request(api.getMediaEthicsChatList.url(),method: .post,parameters: params, headers: head).responseJSON { (response) in
            switch response.result{
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(api.chatLists.url())
                    print("chatList json is:\n\(json)")
                    let parser = ChatListParser(json: json)
                    completionBlock(parser.responseCode,parser.responseMessage,parser.storyResult)
                }else{
                    completionBlock(0,response.result.error?.localizedDescription ?? "Some thing went wrong",nil)
                }
                
            case .failure(let error):
                completionBlock(0,error.localizedDescription,nil)
            }
        }
    }

    
}

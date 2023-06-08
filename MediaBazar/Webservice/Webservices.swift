//
//  Webservices.swift
//  MediaBazar
//
//  Created by deepak Kumar on 04/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Webservice : NSObject {
    
    static let sharedInstance = Webservice()
    
    func signIn( email : String, password : String, completionBlock:@escaping (_ success: Int, _ userSignIn : User?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(email, forKey: "emailId")
        params.updateValue(password, forKey: "password")
        print("============\(params)")
        
        Alamofire.request(api.login.url(),method: .post, parameters : params).responseJSON { response in
            print(response)
            switch response.result {
            case.success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.login.url())")
                    print(" login json is:\n\(json)")
                    let parser = UserParsar(json: json)
                    
                    if parser.responseCode == 200 {
                        AppSettings.shared.isLoggedIn = true
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
    }
    
    //------getInviteUserPersonalInfo Api------
    func getInviteUserPersonalInfo(profileImageUrl: UIImage?, profileVideo: Data?, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String,nameCode: String,phoneCode: String,stripId : String,header : String, completionBlock: @escaping (_ success: Int, _ userSignIn : SocialMedialinkModel?, _ message: String) -> Void) {
        
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
        params.updateValue(nameCode, forKey: "nameCode")
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(stripId, forKey: "stripeId")
        
        let url = api.invitePersonalInfo.url()
        print("========\(url)")
        print("========\(params)")
        let head = ["authtoken":header]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "profilePic", fileName: "profilePic", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
                    }
                    
                }
                
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
                            let parser = UserParsar(json: json)
                            
                            if parser.responseCode == 200 {
                                parser.result.saveUserJSON(json)
                            }
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

    
    //------PersonalInfo Api------
    func getPersonalInfo(profileImageUrl: UIImage?, profileVideo: Data?, emailId: String, mobileNumber: String, firstName:String, middleName: String, lastName: String, designationId: String, langCode: String, passcode: String, currency: String, pinCode: String, shortBio: String,mailingAddress: String, Country: String, state: String, city: String, stepCount: String,nameCode: String,phoneCode: String,stripId : String, completionBlock: @escaping (_ success: Int, _ userSignIn : SocialMedialinkModel?, _ message: String) -> Void) {
        
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
        params.updateValue(nameCode, forKey: "nameCode")
        params.updateValue(phoneCode, forKey: "phoneCode")
        params.updateValue(stripId, forKey: "stripeId")
        
        let url = api.personalInfo.url()
        print("========\(url)")
        print("========\(params)")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pimage = profileImageUrl {
                    if let data = pimage.jpegData(compressionQuality: 1.0) as Data?{
                        multipartFormData.append(data, withName: "profilePic", fileName: "profilePic", mimeType: "image/jpeg")
                        print("==========image=========\(data)")
                    }
                    
                }
                
                if let pvideo = profileVideo {
                    multipartFormData.append(pvideo, withName: "shortVideo", fileName: "\(Date().timeIntervalSince1970).mp4", mimeType: "video/mp4")
                    print("==========videoData=========\(pvideo)")
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
    
    
    //-------CountrySearch----
    func countryListData(completionBlock: @escaping (_ success: Int, _ data: [CountryList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.countrySearch.url(), method: .get).responseJSON { (response) in
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
    
    
    //-------stateSearch----
    func stateListData(countryId: String, completionBlock: @escaping (_ success: Int, _ data: [CountryList]? ,_ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(countryId, forKey: "countryId")
        print("============\(params)")
        
        Alamofire.request(api.stateSearch.url(), method: .get, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.stateSearch.url())")
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
    
    
    //-------citySearch----
    func cityListData(stateId: String, completionBlock: @escaping (_ success: Int, _ data: [CountryList]? ,_ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(stateId, forKey: "stateId")
        print("============\(params)")
        //"\(api.stateSearch.url())"
        
        
        Alamofire.request(api.citySerach.url(), method: .get, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.citySerach.url())")
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
    
    
    //-------languageListing
    
    func languageListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.languages.url(), method: .get).responseJSON { (response) in
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
    
    //-------tolanguageListing
    
    func toLanguageListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.toLanguagelist.url(), method: .get).responseJSON { (response) in
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
    
    //----Designation --------
    func designationData(completionBlock: @escaping ( _ success: Int, _ data: [DesignationModel]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.designation.url(), method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("Designation JSON\n--------------------\n\(json)\n=====================")
                    let parser = DesignationParser(json: json)
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
    func socialMediaLinkData( facebookLink: String, twitterLink: String, linkedinLink: String, snapChatLink: String,instagramLink: String, youtubeLink: String,journalistId: String, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : SocialMedialinkModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(facebookLink, forKey: "facebookLink")
        params.updateValue(twitterLink, forKey: "twitterLink")
        params.updateValue(linkedinLink, forKey: "linkedinLink")
        params.updateValue(snapChatLink, forKey: "snapChatLink")
        params.updateValue(instagramLink, forKey: "instagramLink")
        params.updateValue(youtubeLink, forKey: "youtubeLink")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.socialMedialink.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.socialMedialink.url())")
                    print("socialMedialink JSON\n--------------------\n\(json)\n=====================")
                    let parser = SocialMediaLinkParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
        
    }
    
    //----------benefitData--------------
    
    func benefitData(platformBenefits: String,journalistId: String, platformSuggestion: String, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : User?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(platformBenefits, forKey: "platformBenefits")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(platformSuggestion, forKey: "platformSuggestion")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.platformBenefits.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.benefit.url())")
                    print("benefit JSON\n----------------\n\(json)\n=====================")
                    let parser = UserParsar(json: json)
                    
                    if parser.responseCode == 200 {
//                        AppSettings.shared.isLoggedIn = true
                        parser.result.saveUserJSON(json)
                    }
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
        
    }
    //-----------previousWorkData----------
    
    func previousWorkData(previousWorks: String, journalistId: String, stepCount: String, completionBlock:@escaping (_ success: Int, _ userSignIn : PreviousModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(previousWorks, forKey: "previousWorks")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.previoousWork.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.previoousWork.url())")
                    print("previousWork JSON\n-----------\n\(json)\n=====================")
                    let parser = PreviousWorkParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                    
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
        
    }
    
    
    func updatePreviousWorkData(previousWorks: String, journalistId: String, stepCount: String, completionBlock:@escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
          
          var params = Dictionary<String, String>()
          params.updateValue(previousWorks, forKey: "previousWorks")
          params.updateValue(journalistId, forKey: "journalistId")
          params.updateValue(stepCount, forKey: "stepCount")
          
          print("============\(params)")
          
          Alamofire.request(api.previoousWork.url(), method: .put, parameters : params).responseJSON { (response) in
              switch response.result {
              case .success:
                  if let value = response.result.value {
                      let json = JSON(value)
                      print("============\(api.previoousWork.url())")
                      print("previousWork JSON\n-----------\n\(json)\n=====================")
                      let parser = profileParsar(json: json)
                      completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                  } else {
                      completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                      
                  }
              case .failure(let error):
                  completionBlock(0,nil, error.localizedDescription)
              }
          }
          
      }
    
    //------- category data ---------
    func categoryListData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.category.url(), method: .get).responseJSON { (response) in
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
    
    
    //-----------storyKeyword---------
    
    func keywordData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.storyKeyweord.url(), method: .get,parameters: params).responseJSON { (response) in
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
    
    //-----------JobKeyword---------
    
    func jobKeywordData(completionBlock: @escaping ( _ success: Int, _ data: [LanguageList]? ,_ message: String) -> Void) {
        var params = Dictionary<String,String>()
        params.updateValue("", forKey: "searchKey")
        
        Alamofire.request(api.jobKeyword.url(), method: .get,parameters: params).responseJSON { (response) in
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
    
    //-----------ProfessionalDetailsData---------
    
    func ProfessionalDetailsData( areaOfInterest: String, targetAudience: String, resumeDetails: String, journalistId: String,uploadResume: Data?, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : ProffesionalDetailModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(areaOfInterest, forKey: "areaOfInterest")
        params.updateValue(targetAudience, forKey: "targetAudience")
        params.updateValue(resumeDetails, forKey: "resumeDetails")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        let url = api.professionalDetail.url()
        print("========\(url)")
        print(params)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let pdfData = uploadResume {
                    multipartFormData.append(pdfData, withName: "uploadResume", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "application/pdf")
                    print("==========pdfData=========\(pdfData)")
                    
                }
                
                
                for (key, value) in params {
                    multipartFormData.append((value).data(using: .utf8)!, withName: key)
                }
                
        },to: url,method:.put,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    switch response.result {
                    case .success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("\(json)")
                            let parser = ProfessionalDetailParser(json: json)
                            
                            if parser.responseCode == 200 {
                                if let value = response.result.value {
                                    let json = JSON(value)
                                    let parser = ProfessionalDetailParser(json: json)
                                    completionBlock(parser.responseCode,parser.result,parser.responseMessage)
                                    
                                }
                            }
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
    
    
    //------------journalistProfile
//    func journalistProfileData(completionBlock: @escaping ( _ success: Int, _ data: [ProffesionalDetailModel]? ,_ message: String) -> Void){
//
//        var params = Dictionary<String,String >()
//        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
//
//        let head = ["authtoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTNhNDc1NWMyNmRlYzIxNWQ3ZjQ5MzciLCJpYXQiOjE1ODE0OTI0MTR9.vJ6agrL8GFaTW3xjGzVGc4kyMulp7XUiZVqAEJbxkCo"]
//
//        Alamofire.request(api.journalistProfile.url(), method: .get,parameters: params, headers: head).responseJSON{(response) in
//
//            switch response.result {
//
//            case .success:
//                if let value = response.result.value{
//                    let json = JSON(value)
//                    print("journalist JSON\n---------------\n\(json)\n=====================")
//                    let Parser = ProfessionalDetailParser(json: json)
//                    completionBlock(Parser.responseCode, Parser.result, Parser.responseMessage)
//                }else{
//                    completionBlock(0, nil, response.result.error?.localizedDescription ?? "Something Went Wrong")
//                }
//            case .failure(let error):
//                completionBlock(0, nil,error.localizedDescription)
//
//            }
//        }
//    }
    
    
//------------journalistProfile
    func journalistProfileData(header: String,completionBlock: @escaping ( _ success: Int, _ data: profileModal? ,_ message: String) -> Void){
        
        var params = Dictionary<String,String >()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.journalistProfile.url(), method: .get,parameters: params, headers: head).responseJSON{(response) in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print("journalist JSON\n---------------\n\(json)\n=====================")
                    let Parser = profileParsar(json: json)
                    completionBlock(Parser.responseCode, Parser.result, Parser.responseMessage)
                }else{
                    completionBlock(0, nil, response.result.error?.localizedDescription ?? "Something Went Wrong")
                }
            case .failure(let error):
                completionBlock(0, nil,error.localizedDescription)
                
            }
        }
    }
    
//----------Refference---------

    func refrencesData(refrences: String,journalistId: String, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : ProffesionalDetailModel?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(refrences, forKey: "refrences")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.refrences.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.refrences.url())")
                    print("refrences JSON\n----------------\n\(json)\n=====================")
                    let parser = ProfessionalDetailParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    func updateRefrencesData(refrences: String,journalistId: String, stepCount: String,completionBlock:@escaping (_ success: Int, _ userSignIn : profileModal?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(refrences, forKey: "refrences")
        params.updateValue(journalistId, forKey: "journalistId")
        params.updateValue(stepCount, forKey: "stepCount")
        
        print("============\(params)")
        
        Alamofire.request(api.refrences.url(), method: .put, parameters : params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.refrences.url())")
                    print("refrences JSON\n----------------\n\(json)\n=====================")
                    let parser = profileParsar(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
    }
    
    //----adminBenefits --------
    func adminBenefitsData(completionBlock: @escaping ( _ success: Int, _ data: [DesignationModel]? ,_ message: String) -> Void) {
        
        Alamofire.request(api.adminBenefit.url(), method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("Designation JSON\n--------------------\n\(json)\n=====================")
                    let parser = DesignationParser(json: json)
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

    func EnquiryData(page : String,header:String,completionBlock: @escaping ( _ success: Int, _ data: EnquiryModel? ,_ message: String) -> Void) {
        
        var params = Dictionary<String,String >()
        params.updateValue("EnquiryTokenKey", forKey: "authtoken")
        params.updateValue(page, forKey: "page")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.enquiry.url(), method: .get,parameters: params, headers: head).responseJSON { (response) in
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
//--------postEnquiryData
    func postEnquiryData(enquiryTitle: String, enquiryDescription: String,header: String, completionBlock: @escaping ( _ success: Int, _ data: EnquiryModel? ,_ message: String) -> Void) {
        
        var params = Dictionary<String,String >()
        params.updateValue("EnquiryTokenKey", forKey: "authtoken")
        params.updateValue(enquiryTitle, forKey: "enquiryTitle")
        params.updateValue(enquiryDescription, forKey: "enquiryDescription")
        print(params)
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.enquiry.url(), method: .post,parameters: params, headers: head).responseJSON { (response) in
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
    
    
    
    //------------journalistProfileStatus
    func journalistProfileStatus(header: String,completionBlock: @escaping ( _ success: Int, _ data: profileModal? ,_ message: String) -> Void){
        
        var params = Dictionary<String,String >()
        params.updateValue("jaournalistTokenKey", forKey: "authtoken")
        
        let head = ["authtoken":header]
        
        Alamofire.request(api.getProfileStatus.url(), method: .get,parameters: params, headers: head).responseJSON{(response) in
            
            switch response.result {
                
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print("journalist JSON\n---------------\n\(json)\n=====================")
                    let Parser = profileParsar(json: json)
                    completionBlock(Parser.responseCode, Parser.result, Parser.responseMessage)
                }else{
                    completionBlock(0, nil, response.result.error?.localizedDescription ?? "Something Went Wrong")
                }
            case .failure(let error):
                completionBlock(0, nil,error.localizedDescription)
                
            }
        }
    }

    
    
    //---------purchaseStory--------------
    func purchaseDownloadStory( storyId : String, header : String,completionBlock:@escaping (_ success: Int, _ userSignIn : StoryDownloadModal?, _ message: String) -> Void) {
        
        var params = Dictionary<String, String>()
        params.updateValue(storyId, forKey: "storyId")
        
        let head = ["authtoken":header]
        
        print("============\(params)")
        
        Alamofire.request(api.downloadPurchaseStory.url(), method: .get, parameters : params,headers: head).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("============\(api.downloadPurchaseStory.url())")
                    print("purchaseDownloadStory JSON\n--------------------\n\(json)\n=====================")
                    let parser = downloadStoryParser(json: json)
                    completionBlock(parser.responseCode, parser.result, parser.responseMessage)
                } else {
                    completionBlock(0,nil, response.result.error?.localizedDescription ?? "Some thing went wrong")
                }
            case .failure(let error):
                completionBlock(0,nil, error.localizedDescription)
            }
        }
        
    }
    

}








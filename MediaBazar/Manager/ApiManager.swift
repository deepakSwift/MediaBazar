//
//  ApiManager.swift
//  WeekInChina
//
//  Created by Kanika Mishra on 13/03/19.
//  Copyright © 2019 MobileCoderz. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

enum UrlType {
    case apiUrl(String)
    case customUrl(String)
}

class ApiManager {
    
    static let sharedManager = ApiManager()
    
    enum HTTPMethodType {
        case post
        case get
        case put
        case delete
    }
    
    //for url
    func serviceApi(serviceName:String,parameter:[String:Any]?,methodType:HTTPMethodType,responseHandler:@escaping ([String:Any]?,Int?,Error?)-> () ) {
        //  var params = Dictionary<String, String>()
        // params = ["user_id":"1"]
        let apiUrl = API.baseUrl + serviceName
        print("-------\(apiUrl)")
        var method: HTTPMethod = .post
        switch methodType {
        case .get:
            method = .get
        case .post:
            method = .post
        case .put:
            method = .put
        case .delete:
            method = .delete
        }
        Alamofire.request( apiUrl ,method: .post, parameters : parameter).responseJSON { response in
            switch (response.result) {
            case .success(_):
                
                if let json = response.result.value as? [String:Any],let statusCode = response.response?.statusCode{
                    
                   // print(json)
                    responseHandler(json,statusCode,nil)
                }
            case .failure(_):
                responseHandler(nil,nil, response.result.error as NSError?)
                print("Something going wrong data not found")
            }
            // to do anything
        }
    }
    
    
    
    // for images and videos
    func serviceMultiPart(serviceName:String,parameter:[String:Any]?,methodType:HTTPMethodType,responseHandler:@escaping (Any?,Error?)-> Void ) {
        let apiUrl = API.baseUrl + serviceName
        var method: HTTPMethod = .post
        switch methodType {
        case .get:
            method = .get
        case .post:
            method = .post
        case .put:
            method = .put
        case .delete:
            method = .delete
        }
        
        Alamofire.request(apiUrl, method: method, parameters: parameter, encoding: JSONEncoding.default)
        
    }
    
    
    func downloadService(urlString:String,parameter:[String:Any]?,methodType:HTTPMethodType,responseHandler:@escaping (Data?,Int?,Error?)-> () ) {
        
        print(urlString)
        var method: HTTPMethod = .post
        switch methodType {
        case .get:
            method = .get
        case .post:
            method = .post
        case .put:
            method = .put
        case .delete:
            method = .delete
        }

        Alamofire.request(urlString, method: method, parameters: parameter, encoding: JSONEncoding.default).responseString { (response) in
            switch (response.result) {
            case .success(_):
                
                if let data = response.data,let statusCode = response.response?.statusCode{
                    responseHandler(data,statusCode,nil)
                }
            case .failure(_):
                responseHandler(nil,nil, response.result.error as NSError?)
            }
        }
    }
}

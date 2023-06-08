//
//  JsonModel.swift
//  MediaBazar
//
//  Created by deepak Kumar on 06/02/20.
//  Copyright © 2020 Saurabh Chandra Bose. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryList: NSObject {
    
    enum Keys: String, CodingKey {
        case placeId = "id"
        case sortName = "sortname"
        case name = "name"
        case phoneCode = "phonecode"
        case symbol = "symbol"
        case currencyName = "currencyName"
        case countryId = "country_id"
        case stateId = "state_id"
        case mediahouseTypeId = "_id"
        case mediahouseTypeName = "mediahouseTypeName"
        //case frequencyId = "ids"
        case mediahouseFrequencyName = "mediahouseFrequencyName"
        case currencyCode = "currencyCode"
        case currencySymbol = "currencySymbol"
    }
    
    var placeId = ""
    var sortName = ""
    var name = ""
    var phoneCode = ""
    var symbol = ""
    var currencyName = ""
    var countryId = ""
    var stateId = ""
    var mediahouseTypeId = ""
    var mediahouseTypeName = ""
    //var frequencyId = ""
    var mediahouseFrequencyName = ""
    var currencyCode = ""
    var currencySymbol = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let placeId = dict[Keys.placeId.stringValue] as? String {
            self.placeId = placeId
        }
        if let sortName = dict[Keys.sortName.stringValue] as? String {
            self.sortName = sortName
        }
        if let name = dict[Keys.name.stringValue] as? String {
            self.name = name
        }
        if let phoneCode = dict[Keys.phoneCode.stringValue] as? String {
            self.phoneCode = phoneCode
        }
        if let symbol = dict[Keys.symbol.stringValue] as? String {
            self.symbol = symbol
        }
        if let currencyName = dict[Keys.currencyName.stringValue] as? String {
            self.currencyName = currencyName
        }
        if let countryId = dict[Keys.countryId.stringValue] as? String {
            self.countryId = countryId
        }
        if let stateId = dict[Keys.stateId.stringValue] as? String {
            self.stateId = stateId
        }
        if let mediahouseTypeId = dict[Keys.mediahouseTypeId.stringValue] as? String {
            self.mediahouseTypeId = mediahouseTypeId
        }
        if let mediahouseTypeName = dict[Keys.mediahouseTypeName.stringValue] as? String {
            self.mediahouseTypeName = mediahouseTypeName
        }
        if let currencyCode = dict[Keys.currencyCode.stringValue] as? String {
            self.currencyCode = currencyCode
        }
        if let mediahouseFrequencyName = dict[Keys.mediahouseFrequencyName.stringValue] as? String {
            self.mediahouseFrequencyName = mediahouseFrequencyName
        }
        if let currencySymbol = dict[Keys.currencySymbol.stringValue] as? String {
            self.currencySymbol = currencySymbol
        }

        
        super.init()
    }
    
}


class StateList: NSObject {
    
    enum Keys: String, CodingKey {
        case stateId = "id"
        case stateName = "name"
        case countryId = "country_id"
        case symbol = "symbol"
        case currencyName = "currencyName"
        
    }
    
    var stateId = ""
    var stateName = ""
    var countryId = ""
    var symbol = ""
    var currencyName = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let stateId = dict[Keys.stateId.stringValue] as? String {
            self.stateId = stateId
        }
        if let stateName = dict[Keys.stateName.stringValue] as? String {
            self.stateName = stateName
        }
        if let countryId = dict[Keys.countryId.stringValue] as? String {
            self.countryId = countryId
        }
        if let symbol = dict[Keys.symbol.stringValue] as? String {
            self.symbol = symbol
        }
        if let currencyName = dict[Keys.currencyName.stringValue] as? String {
            self.currencyName = currencyName
        }
        super.init()
    }
    
}


class CityList: NSObject {
    
    enum Keys: String, CodingKey {
        case cityID = "id"
        case cityName = "name"
        case state_id = "state_id"
        
    }
    
    var cityID = ""
    var cityName = ""
    var state_id = ""
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        
        if let cityID = dict[Keys.cityID.stringValue] as? String {
            self.cityID = cityID
        }
        if let cityName = dict[Keys.cityName.stringValue] as? String {
            self.cityName = cityName
        }
        if let state_id = dict[Keys.state_id.stringValue] as? String {
            self.state_id = state_id
        }

        super.init()
    }
    
}













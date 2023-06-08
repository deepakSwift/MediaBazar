//
//  StringExtension.swift
//  MyLaundryApp
//
//  Created by TecOrb on 15/12/16.
//  Copyright © 2016 Nakul Sharma. All rights reserved.
//


import Foundation

extension String {
//    static func className(aClass: AnyClass) -> String {
//        return NSStringFromClass(aClass).componentsSeparated(by: ".").last!
//    }
//    
//    func substring(from: Int) -> String {
//        return self.substring(from: self.startIndex.advancedBy(from))
//    }
//    
//    var length: Int {
//        return self.characters.count
//    }
    var chomp : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}


//-----Validation email and passsword
extension String {
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
        
    var isValidPassword: Bool {
        let passwordRegEx = "^.{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
//    var isValidPassword: Bool {
//           let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z].*[a-z].*[a-z]).{8}$"
//           let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
//           return passwordTest.evaluate(with: self)
//       }
    
    var isValidMobileNo: Bool {
        let PHONE_REGEX = "^[7-9][0-9]{9}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func getDate(_ inFormat: String, _ outFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outFormat
        return dateFormatter.string(from: date ?? Date())
    }
    
    
   

}

extension String {

    private func matches(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive])
        return regex.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: utf16.count)) != nil
    }

    func isValidURL() -> Bool {
        guard let url = URL(string: self) else { return false }
        if !UIApplication.shared.canOpenURL(url) {
            return false
        }

        let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
        return self.matches(pattern: urlPattern)
    }
    
    
    func validateUrl() -> Bool {
      let urlRegEx = "((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
      return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
}



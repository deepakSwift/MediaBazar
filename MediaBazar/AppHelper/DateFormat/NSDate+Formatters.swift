//
//  NSDate+Formatters.swift
//
//  Created by Anish Kumar on 30/03/16.
//  Copyright © 2016 Appster. All rights reserved.
//



import Foundation

public extension Date {
    static func dateFormatCCCCDDMMMYYYY() -> String {
        return "cccc, dd MMM yyyy"
    }

    static func dateFormatCCCCDDMMMMYYYY() -> String {
        return "cccc, dd MMMM yyyy"
    }

    static func dateFormatDDMMMYYYY() -> String {
        return "dd/MM/yyyy"
    }

    static func dateFormatddMMMMYYYY() -> String {
        return "dd MMMM yyyy"
    }

    static func dateFormatMMMMYYYY() -> String {
        return "MMMM yyyy"
    }

    static func dateFormatMMMM() -> String {
        return "MMMM"
    }

    static func dateFormatYYYY() -> String {
        return "YYYY"
    }

    static func dateFormatMM() -> String {
        return "MM"
    }

    static func dateFormatDDMMYYYYDashed() -> String {
        return "dd-MM-yyyy"
    }

    static func dateFormatDDMMYYYYSlashed() -> String {
        return "dd/MM/yyyy"
    }

    static func dateFormatDDMMMYYYYSlashed() -> String {
        return "dd/MMM/yyyy"
    }

    static func dateFormatMMMDDYYYY() -> String {
        return "MMM dd, yyyy"
    }

    static func dateFormatYYYYMMDDDashed() -> String {
        return "yyyy-MM-dd"
    }

    static func dateFormatYYYYMMDDHHMMSSDashed() -> String {
        return "yyyy-MM-dd HH:mm:ss Z"
        //2019-10-10 06:30:00 +0000
    }
    
    static func dateFormatDDMMMYYYYHHMMSSADashed() -> String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }

    static func dateFormatYYYYMMDDHHMMDashed() -> String {
        return "yyyy-MM-dd HH:mm"
    }

    static func dateFormatddMMMMHHMM() -> String {
        return "dd MMMM HH:mm"
    }

    static func dateFormatMMMMyyyy() -> String {
        return "MMM yyyy"
    }

    static func dateFormatHHMM() -> String {
        return "yyyy-MM-dd"
    }

    static func UTCTimeZone() -> TimeZone? {
        return TimeZone(abbreviation: "UTC")
    }

    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Date.dateFormatDDMMYYYYDashed()
        return formatter.string(from: self)
    }

    func formattedStringUsingFormat(_ format: String, timeZone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let zone = timeZone {
            formatter.timeZone = zone
        }
        return formatter.string(from: self)
    }

    func ordinaryDayName() -> String {
        let day = formattedStringUsingFormat("dd")
        switch Int(day) {
        case 1, 21, 31:
            return day.description + "st"
        case 2, 22:
            return day.description + "nd"
        case 3, 23:
            return day.description + "rd"
        default:
            return day.description + "th"
        }
    }
}

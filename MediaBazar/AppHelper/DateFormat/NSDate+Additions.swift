//
//  NSDate+Additions.swift
//
//  Created by Pawan Joshi on 30/03/16.
//  Copyright © 2016 Appster. All rights reserved.
//

import Foundation

struct TimeAgoComponent {
    static let year = "yr"
    static let month = "mon"
    static let week = "wk"
    static let day = "day"
    static let hour = "hr"
    static let minute = "min"
    static let second = "sec"
    static let now = "now"
}

public extension Date {

    // MARK: NSDate Manipulation

    /**
     Returns a new NSDate object representing the date calculated by adding the amount specified to self date

     - parameter seconds: number of seconds to add
     - parameter minutes: number of minutes to add
     - parameter hours: number of hours to add
     - parameter days: number of days to add
     - parameter weeks: number of weeks to add
     - parameter months: number of months to add
     - parameter years: number of years to add
     - returns: the NSDate computed
     */
    public func add(_ seconds: Int = 0, minutes: Int = 0, hours: Int = 0, days: Int = 0, weeks: Int = 0, months: Int = 0, years: Int = 0) -> Date {
        let calendar = Calendar.current

        let version = floor(NSFoundationVersionNumber)

        if version <= NSFoundationVersionNumber10_9_2 {
            var component = DateComponents()
            (component as NSDateComponents).setValue(seconds, forComponent: .second)

            var date: Date! = (calendar as NSCalendar).date(byAdding: component, to: self, options: [])!
            component = DateComponents()
            (component as NSDateComponents).setValue(minutes, forComponent: .minute)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!

            component = DateComponents()
            (component as NSDateComponents).setValue(hours, forComponent: .hour)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!

            component = DateComponents()
            (component as NSDateComponents).setValue(days, forComponent: .day)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!

            component = DateComponents()
            (component as NSDateComponents).setValue(weeks, forComponent: .weekOfMonth)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!

            component = DateComponents()
            (component as NSDateComponents).setValue(months, forComponent: .month)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!

            component = DateComponents()
            (component as NSDateComponents).setValue(years, forComponent: .year)
            date = (calendar as NSCalendar).date(byAdding: component, to: date, options: [])!
            return date
        }

        var date: Date! = (calendar as NSCalendar).date(byAdding: .second, value: seconds, to: self, options: [])
        date = (calendar as NSCalendar).date(byAdding: .minute, value: minutes, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .day, value: days, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .hour, value: hours, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .weekOfMonth, value: weeks, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .month, value: months, to: date, options: [])
        date = (calendar as NSCalendar).date(byAdding: .year, value: years, to: date, options: [])
        return date
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of seconds to self date

     - parameter seconds: number of seconds to add
     - returns: the NSDate computed
     */
    public func addSeconds(_ seconds: Int) -> Date {
        return add(seconds)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of minutes to self date

     - parameter minutes: number of minutes to add
     - returns: the NSDate computed
     */
    public func addMinutes(_ minutes: Int) -> Date {
        return add(minutes: minutes)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of hours to self date

     - parameter hours: number of hours to add
     - returns: the NSDate computed
     */
    public func addHours(_ hours: Int) -> Date {
        return add(hours: hours)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of days to self date

     - parameter days: number of days to add
     - returns: the NSDate computed
     */
    public func addDays(_ days: Int) -> Date {
        return add(days: days)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of weeks to self date

     - parameter weeks: number of weeks to add
     - returns: the NSDate computed
     */
    public func addWeeks(_ weeks: Int) -> Date {
        return add(weeks: weeks)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of months to self date

     - parameter months: number of months to add
     - returns: the NSDate computed
     */
    public func addMonths(_ months: Int) -> Date {
        return add(months: months)
    }

    /**
     Returns a new NSDate object representing the date calculated by adding an amount of years to self date

     - parameter years: number of year to add
     - returns: the NSDate computed
     */
    public func addYears(_ years: Int) -> Date {
        return add(years: years)
    }

    // MARK: - Class Functions

    /**
     Convert date from String

     - parameter dateStr: date String
     - parameter format:  date format

     - returns: Date object
     */
    static func dateFromString(_ dateStr: String?, WithFormat format: String) -> Date? {
        if dateStr == nil {
            return nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone.local // NSTimeZone(name: "UTC") as TimeZone!
        let dateString = dateStr!
        return formatter.date(from: dateString) as Date?
    }

    public static func currentTimeStamp() -> String {
        return Int64(Date().timeIntervalSince1970 * 100_000.0).description
    }

    public static func timeDifferenceFromNow(dateString: String?, WithFormat format: String) -> String {
        guard let dateStr = dateString else {
            return "now"
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "EST")

        if let date = formatter.date(from: dateStr) as NSDate? {
            return Date.timeAgoSinceDate(date: date)
        }
        return "now"
    }

    public static func timeAgoSinceDate(date: NSDate) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date, to: latest as Date)

        return convertIntoTimeAgoFromComponent(components)
    }

    private static func convertIntoTimeAgoFromComponent(_ components: DateComponents) -> String {
        if let year = components.year, year > 0 {
            return componentAgoString(value: year, unit: TimeAgoComponent.year)
        } else if let month = components.month, month > 0 {
            return componentAgoString(value: month, unit: TimeAgoComponent.month)
        } else if let week = components.weekOfYear, week > 0 {
            return componentAgoString(value: week, unit: TimeAgoComponent.week)
        } else if let day = components.day, day > 0 {
            return componentAgoString(value: day, unit: TimeAgoComponent.day)
        } else if let hour = components.hour, hour > 0 {
            return componentAgoString(value: hour, unit: TimeAgoComponent.hour)
        } else if let minute = components.minute, minute > 0 {
            return componentAgoString(value: minute, unit: TimeAgoComponent.minute)
        } else if let second = components.second, second > 5 {
            return componentAgoString(value: second, unit: TimeAgoComponent.second)
        } else {
            return TimeAgoComponent.now
        }
    }

    private static func componentAgoString(value: Int, unit: String) -> String {
        return "\(value) " + (value == 1 ? unit : unit + "s") + " ago"
    }
}

extension Date {
    /**
     Get date by timeIntervalSinceReferenceDate

     - parameter n: time interval

     - returns: Date object
     */
    public func advanced(by timeInterval: TimeInterval) -> Date {
        return type(of: self).init(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate + timeInterval)
    }
}

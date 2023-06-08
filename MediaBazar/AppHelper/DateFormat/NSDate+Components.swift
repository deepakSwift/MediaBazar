//
//  NSDate+Components.swift
//
//  Created by Anish Kumar on 30/03/16.
//  Copyright © 2016 Appster. All rights reserved.
//

import Foundation

public extension Date {

    // MARK: - Getter

    /**
     Date year
     */
    public var year: Int {
        return getComponent(.year)
    }

    /**
     Date month
     */
    public var month: Int {
        return getComponent(.month)
    }

    /**
     Date weekday
     */
    public var weekday: Int {
        return getComponent(.weekday)
    }

    /**
     Date weekMonth
     */
    public var weekMonth: Int {
        return getComponent(.weekOfMonth)
    }

    /**
     Date days
     */
    public var days: Int {
        return getComponent(.day)
    }

    /**
     Date hours
     */
    public var hours: Int {
        return getComponent(.hour)
    }

    /**
     Date minuts
     */
    public var minutes: Int {
        return getComponent(.minute)
    }

    /**
     Date seconds
     */
    public var seconds: Int {
        return getComponent(.second)
    }

    /**
     Returns the value of the NSDate component

     - parameter component: NSCalendarUnit
     - returns: the value of the component
     */

    public func getComponent(_ component: NSCalendar.Unit) -> Int {
        let calendar = Calendar.current
        let components: NSDateComponents = (calendar as NSCalendar).components(component, from: self) as NSDateComponents

        return components.value(forComponent: component)
    }

    /**
     Returns the value of the NSDate component

     - returns: the value of the component
     */
    public func components() -> DateComponents {
        return (Calendar.current as NSCalendar).components([.era, .year, .month, .weekOfYear, .weekOfMonth, .weekday, .weekdayOrdinal, .day, .hour, .minute, .second], from: self)
    }

    public func dayNameOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

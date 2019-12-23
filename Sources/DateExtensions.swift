//
//  DateExtensions.swift
//  StartAppsKit
//
//  Created by Gabriel Lanata on 11/16/14.
//  Credits to Erika Sadun (NSDate-Utilities)
//  Copyright (c) 2014 StartApps. All rights reserved.
//  Version: 1.0
//

import Foundation

let TimeIntervalMinute: TimeInterval = 60
let TimeIntervalHour:   TimeInterval = 3600
let TimeIntervalDay:    TimeInterval = 86400
let TimeIntervalWeek:   TimeInterval = 604800
let TimeIntervalYear:   TimeInterval = 31556926

let CalendarComponents: Set<Calendar.Component> = [
    .year, .month, .day, .weekOfYear, .weekday, .weekdayOrdinal, .hour, .minute, .second
]

private var _forcedNowDate: Date?
extension Date {
    
    public static var forcedNow: Date? {
        set { _forcedNowDate = newValue }
        get { return _forcedNowDate }
    }
    
    public static func now() -> Date {
        return _forcedNowDate ?? Date()
    }
    
}

public enum DateParsingError: LocalizedError {
    case failedToParseString
    public var errorDescription: String {
        switch self {
        case .failedToParseString: return "Failed to parse date string".localized
        }
    }
    
}

extension Date {
    
    private static var _isoDateFormatter: DateFormatter?
    
    public static var isoDateFormat: String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    public static var isoDateLocale: String {
        return "en_US_POSIX"
    }
    
    public static var isoDateFormatter: DateFormatter {
        if _isoDateFormatter == nil {
            _isoDateFormatter = DateFormatter()
            _isoDateFormatter!.locale = Locale(identifier: Date.isoDateLocale)
            _isoDateFormatter!.dateFormat = Date.isoDateFormat
        }
        return _isoDateFormatter!
    }
    
    public init(isoString: String) throws {
        guard let date = Date.isoDateFormatter.date(from: isoString) else {
            throw DateParsingError.failedToParseString
        }
        self = date
    }
    
    public var isoString: String {
        return Date.isoDateFormatter.string(from: self)
    }
    
}

extension Date {


    /********************************************************************************************************/
    // MARK: String Date Methods
    /********************************************************************************************************/
    
    public init(string: String, format: String, locale: String? = nil) throws {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let locale = locale {
            formatter.locale = Locale(identifier: locale)
        }
        guard let date = formatter.date(from: string) else {
            throw DateParsingError.failedToParseString
        }
        self.init(timeInterval:0, since:date)
    }
    
    public func string(format: String, locale: String? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format;
        if let locale = locale {
            formatter.locale = Locale(identifier: locale)
        }
        return formatter.string(from: self)
    }

    public func string(dateStyle: DateFormatter.Style? = nil, timeStyle: DateFormatter.Style? = nil, locale: String? = nil) -> String {
        let formatter = DateFormatter()
        if let dateStyle = dateStyle {
            formatter.dateStyle = dateStyle;
        }
        if let timeStyle = timeStyle {
            formatter.timeStyle = timeStyle;
        }
        if let locale = locale {
            formatter.locale = Locale(identifier: locale)
        }
        return formatter.string(from: self)
    }

    public func shortDateString(locale: String? = nil) -> String {
        //return string(format: dateStyle: .ShortStyle, locale: locale)
        return string(format: (locale?.contains("es") ?? false ? "dd/MM/yyyy" : "MM/dd/yyyy"), locale: locale)
    }

    public func mediumDateString(locale: String? = nil) -> String {
        return string(format: "EEEE d MMM", locale: locale)
    }

    public func longDateString(locale: String? = nil) -> String {
        return string(format: (locale?.contains("es") ?? false ? "EEEE d 'de' MMMM" : "EEEE d MMMM"), locale: locale)
    }

    public func timeString(locale: String? = nil) -> String {
        return string(format: "h:mm a", locale: locale)
    }

    public func time24String(locale: String? = nil) -> String {
        return string(format: "H:mm", locale: locale)
    }

    public func timeAgoString(exact: Bool = false, locale: String? = nil) -> String {
        var timeAgoValue: Int = 0
        var timeAgoUnit:  String = ""
        let secondsAgo = TimeInterval(secondsBeforeNow())
        if (secondsAgo < TimeIntervalMinute) { // Smaller than a minute
            if !exact || secondsAgo < 1 { return (locale?.contains("es") ?? false ? "Ahora" : "Now") }
            timeAgoValue = Int(secondsAgo)
            timeAgoUnit  = (locale?.contains("es") ?? false ? "segundo" : "seconds")
        } else if (secondsAgo < TimeIntervalHour) { // Smaller than an hour
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalMinute)))
            timeAgoUnit  = (locale?.contains("es") ?? false ? "minuto" : "minute")
        } else if (secondsAgo < TimeIntervalDay) { // Smaller than a day
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalHour)))
            timeAgoUnit  = (locale?.contains("es") ?? false ? "hora" : "hour")
        } else { // Bigger than a day
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalDay)))
            timeAgoUnit  = (locale?.contains("es") ?? false ? "día" : "day")
        }
        let timeAgoPlural = (timeAgoValue == 1 ? "" : "s")
        if (locale?.contains("es") ?? false) {
            return "Hace \(timeAgoValue) \(timeAgoUnit)\(timeAgoPlural)"
        } else {
            return "\(timeAgoValue) \(timeAgoUnit)\(timeAgoPlural) ago"
        }

    }

    public func tinyTimeAgoString(_ locale: String? = nil) -> String {
        let timeAgoValue: Int
        let timeAgoUnit:  String
        let secondsAgo = TimeInterval(secondsBeforeNow())
        if (secondsAgo < TimeIntervalMinute) { // Smaller than a minute
            timeAgoValue = Int(secondsAgo)
            timeAgoUnit  = "s"
        } else if (secondsAgo < TimeIntervalHour) { // Smaller than an hour
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalMinute)))
            timeAgoUnit  = "m"
        } else if (secondsAgo < TimeIntervalDay) { // Smaller than a day
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalHour)))
            timeAgoUnit  = "h"
        } else { // Bigger than two days
            timeAgoValue = Int(floor(secondsAgo/(TimeIntervalDay)))
            timeAgoUnit  = "d"
        }
        return "\(timeAgoValue)\(timeAgoUnit)"
    }

    /********************************************************************************************************/
    // MARK: Comparing Date Methods
    /********************************************************************************************************/

    public func isSameDayAsDate(_ date: Date) -> Bool {
        let components1 = self.components()
        let components2 = date.components()
        return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day))
    }

    public func isToday() -> Bool {
        return isSameDayAsDate(Date.now())
    }

    public func isTomorrow() -> Bool {
        return isSameDayAsDate(Date.now().dateByAddingDays(1))
    }

    public func isYesterday() -> Bool {
        return isSameDayAsDate(Date.now().dateBySubtractingDays(1))
    }

    public func isSameWeekAsDate(_ date: Date) -> Bool {
        let components1 = self.components()
        let components2 = date.components()

        // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
        if (components1.weekOfYear != components2.weekOfYear) { return false }

        // Must have a time interval under 1 week. Thanks @aclark
        return (abs(self.timeIntervalSince(date)) < TimeIntervalWeek)
    }

    public func isThisWeek() -> Bool {
        return isSameWeekAsDate(Date.now())
    }

    public func isNextWeek() -> Bool {
        return isSameWeekAsDate(Date.now().dateByAddingDays(7))
    }

    public func isLastWeek() -> Bool {
        return isSameWeekAsDate(Date.now().dateBySubtractingDays(7))
    }

    public func isSameMonthAsDate(_ date: Date) -> Bool {
        let components1 = self.components()
        let components2 = date.components()
        return ((components1.month == components2.month) &&
            (components1.year == components2.year))
    }

    public func isThisMonth() -> Bool {
        return isSameMonthAsDate(Date.now())
    }

    public func isSameYearAsDate(_ date: Date) -> Bool {
        let components1 = self.components()
        let components2 = date.components()
        return (components1.year == components2.year)
    }

    public func isThisYear() -> Bool {
        return isSameYearAsDate(Date.now())
    }

    public func isEarlierThanDate(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedAscending)
    }

    public func isLaterThanDate(_ date: Date) -> Bool {
        return (self.compare(date) == .orderedDescending)
    }

    public func isBetweenDates(dateStart: Date, dateEnd: Date, including: Bool) -> Bool {
        if including && isSameDayAsDate(dateStart) { return true }
        if including && isSameDayAsDate(dateEnd)   { return true }
        return isLaterThanDate(dateStart) && isEarlierThanDate(dateEnd)
    }

    public func isBetweenDays(dateStart: Date, dateEnd: Date, including: Bool) -> Bool {
        if isSameDayAsDate(dateStart) { return including }
        if isSameDayAsDate(dateEnd)   { return including }
        return isLaterThanDate(dateStart) && isEarlierThanDate(dateEnd)
    }

    public func isInPast() -> Bool {
        return isEarlierThanDate(Date.now())
    }

    public func isInFuture() -> Bool {
        return isLaterThanDate(Date.now())
    }

    /********************************************************************************************************/
    // MARK: Adjusting Date Methods
    /********************************************************************************************************/

    public func dateByAddingDays(_ days: Int) -> Date {
        let timeInterval = self.timeIntervalSinceReferenceDate+TimeIntervalDay*Double(days)
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }

    public func dateBySubtractingDays(_ days: Int) -> Date {
        return dateByAddingDays(-days)
    }

    public func dateByAddingHours(_ hours: Int) -> Date {
        let timeInterval = self.timeIntervalSinceReferenceDate+TimeIntervalHour*Double(hours)
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }

    public func dateBySubtractingHours(_ hours: Int) -> Date {
        return dateByAddingHours(-hours)
    }

    public func dateByAddingMinutes(_ minutes: Int) -> Date {
        let timeInterval = self.timeIntervalSinceReferenceDate+TimeIntervalMinute*Double(minutes)
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }

    public func dateBySubtractingMinutes(_ minutes: Int) -> Date {
        return dateByAddingMinutes(-minutes)
    }

    public func dateByAddingSeconds(_ seconds: Int) -> Date {
        let timeInterval = self.timeIntervalSinceReferenceDate+Double(seconds)
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate
    }

    public func dateBySubtractingSeconds(_ seconds: Int) -> Date {
        return dateByAddingSeconds(-seconds)
    }

    public func dateAtStartOfDay(locale: String? = nil) -> Date {
        var components = self.components(locale: locale)
        components.hour = 0
        components.minute = 0
        components.second = 0
        var calendar = Calendar.current
        if let locale = locale {
            calendar.locale = Locale(identifier: locale)
        }
        return calendar.date(from: components)!
    }

    public func dateAtStartOfWeek(locale: String? = nil) -> Date {
        return self.dateBySubtractingDays(self.weekday(locale: locale)).dateAtStartOfDay(locale: locale)
    }

    /********************************************************************************************************/
    // MARK: Decomposing Date Methods
    /********************************************************************************************************/

    fileprivate func components(locale: String? = nil) -> Foundation.DateComponents {
        var calendar = Calendar.current
        if let locale = locale {
            calendar.locale = Locale(identifier: locale)
        }
        return calendar.dateComponents(CalendarComponents, from: self)
    }

    public func nearestHour(locale: String? = nil) -> Int {
        let timeInterval = self.timeIntervalSinceReferenceDate+TimeIntervalMinute*30
        let newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        return newDate.components(locale: locale).hour!
    }

    public func minute(locale: String? = nil) -> Int {
        return components(locale: locale).minute!
    }

    public func second(locale: String? = nil) -> Int {
        return components(locale: locale).second!
    }

    public func hour(locale: String? = nil) -> Int {
        return components(locale: locale).hour!
    }

    public func hour12(locale: String? = nil) -> Int {
        let hour24 = hour(locale: locale)
        return hour24 > 12 ? hour24-12 : hour24
    }

    public func day(locale: String? = nil) -> Int {
        return components(locale: locale).day!
    }

    public func week(locale: String? = nil) -> Int {
        return components(locale: locale).weekOfYear!
    }

    public func weekday(locale: String? = nil) -> Int {
        var weekDay = components(locale: locale).weekday!-2 //1 es domingo
        if weekDay < 0 { weekDay += 7 }
        return weekDay
    }

    public func nthWeekday(locale: String? = nil) -> Int { // e.g. 2nd Tuesday of the month is 2
        return components(locale: locale).weekdayOrdinal!
    }

    public func month(locale: String? = nil) -> Int {
        return components(locale: locale).month!
    }

    public func monthName(locale: String? = nil) -> String {
        return string(format: "MMMM", locale: locale)
    }

    public func year(locale: String? = nil) -> Int {
        return components(locale: locale).year!
    }

    public func dayOfWeek() -> DayOfWeek {
        // Force Peru for Monday = 0
        return DayOfWeek(rawValue: weekday(locale: "es_PE"))!
    }

    /********************************************************************************************************/
    // MARK: Retrieving Intervals Date Methods
    /********************************************************************************************************/

    public func secondsAfterNow() -> Int {  // In ## Seconds
        return secondsAfterDate(Date.now())
    }

    public func secondsBeforeNow() -> Int { // ## Seconds Ago
        return secondsBeforeDate(Date.now())
    }

    public func secondsAfterDate(_ date: Date) -> Int {
        let timeInterval = self.timeIntervalSince(date)
        return Int(timeInterval)
    }

    public func secondsBeforeDate(_ date: Date) -> Int {
        let timeInterval = date.timeIntervalSince(self)
        return Int(timeInterval)
    }

    public func minutesAfterDate(_ date: Date) -> Int {
        let timeInterval = self.timeIntervalSince(date)
        return Int(timeInterval/TimeIntervalMinute)
    }

    public func minutesBeforeDate(_ date: Date) -> Int {
        let timeInterval = date.timeIntervalSince(self)
        return Int(timeInterval/TimeIntervalMinute)
    }

    public func hoursAfterDate(_ date: Date) -> Int {
        let timeInterval = self.timeIntervalSince(date)
        return Int(timeInterval/TimeIntervalHour)
    }

    public func hoursBeforeDate(_ date: Date) -> Int {
        let timeInterval = date.timeIntervalSince(self)
        return Int(timeInterval/TimeIntervalHour)
    }

    public func daysAfterDate(_ date: Date) -> Int {
        let timeInterval = self.timeIntervalSince(date)
        return Int(timeInterval/TimeIntervalDay)
    }

    public func daysBeforeDate(_ date: Date) -> Int {
        let timeInterval = date.timeIntervalSince(self)
        return Int(timeInterval/TimeIntervalDay)
    }

}

public enum DayOfWeek: Int, Equatable {
    case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday

    public init?(string: String) {
        switch string.uppercased().trimmed() {
        case "LUNES":     self = .monday
        case "MARTES":    self = .tuesday
        case "MIERCOLES": self = .wednesday
        case "MIÉRCOLES": self = .wednesday
        case "JUEVES":    self = .thursday
        case "VIERNES":   self = .friday
        case "SABADO":    self = .saturday
        case "SÁBADO":    self = .saturday
        case "DOMINGO":   self = .sunday
        case "MONDAY":    self = .monday
        case "TUESDAY":   self = .tuesday
        case "WEDNESDAY": self = .wednesday
        case "THURSDAY":  self = .thursday
        case "FRIDAY":    self = .friday
        case "SATURDAY":  self = .saturday
        case "SUNDAY":    self = .sunday
        case "LU":        self = .monday
        case "MA":        self = .tuesday
        case "MI":        self = .wednesday
        case "JU":        self = .thursday
        case "VI":        self = .friday
        case "SA":        self = .saturday
        case "DO":        self = .sunday
        case "LUN":       self = .monday
        case "MAR":       self = .tuesday
        case "MIE":       self = .wednesday
        case "JUE":       self = .thursday
        case "VIE":       self = .friday
        case "SAB":       self = .saturday
        case "DOM":       self = .sunday
        case "MO":        self = .monday
        case "TU":        self = .tuesday
        case "WE":        self = .wednesday
        case "TH":        self = .thursday
        case "FR":        self = .friday
        case "SU":        self = .sunday
        case "MON":       self = .monday
        case "TUE":       self = .tuesday
        case "WED":       self = .wednesday
        case "THU":       self = .thursday
        case "FRI":       self = .friday
        case "SAT":       self = .saturday
        case "SUN":       self = .sunday
        default:          return nil
        }
    }
    
    public var name: String {
        switch self {
        case .monday:    return "Lunes".localized
        case .tuesday:   return "Martes".localized
        case .wednesday: return "Miércoles".localized
        case .thursday:  return "Jueves".localized
        case .friday:    return "Viernes".localized
        case .saturday:  return "Sábado".localized
        case .sunday:    return "Domingo".localized
        }
    }
    
    public var shortName: String {
        switch self {
        case .monday:    return "LUN".localized
        case .tuesday:   return "MAR".localized
        case .wednesday: return "MIE".localized
        case .thursday:  return "JUE".localized
        case .friday:    return "VIE".localized
        case .saturday:  return "SAB".localized
        case .sunday:    return "DOM".localized
        }
    }

    public var sundayFirstRawValue: Int {
        var alternateRawValue = rawValue+1
        if alternateRawValue > 7 { alternateRawValue -= alternateRawValue }
        return alternateRawValue
    }

    // TODO: Should this be here?
    public var alternateRawValue: Int {
        var alternateRawValue = rawValue+2
        if alternateRawValue > 7 { alternateRawValue -= alternateRawValue }
        return alternateRawValue
    }


    /// Returns wether day of week is in the weekend
    public var isWeekend: Bool {
        switch self {
        case .monday:    return false
        case .tuesday:   return false
        case .wednesday: return false
        case .thursday:  return false
        case .friday:    return false
        case .saturday:  return true
        case .sunday:    return true
        }
    }

}


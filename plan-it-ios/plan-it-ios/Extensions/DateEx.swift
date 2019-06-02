//
//  DateEx.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation

extension Date {
    var today: Date {
        return rewindDays(0)
    }
    
    func rewindDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func offsetFrom(date: Date) -> Int {
        let calendar = Calendar.current
        let startOfCurrentDate = calendar.startOfDay(for: date)
        let startofOtherDay = calendar.startOfDay(for: self)
        
        return calendar.dateComponents([.day], from: startOfCurrentDate, to: startofOtherDay).day!
    }
    
    var formatted: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "E, d MMM yyyy"
        
        return dateFormatterPrint.string(from: self)
    }
    
    var formattedForMonth: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "ru_RU")
        dateFormatterPrint.dateFormat = "LLLL yyyy"
        
        return dateFormatterPrint.string(from: self)
    }
    
}

extension Task {
    func daysLeft() -> Int? {
        if let timestamp = self.deadline {
            let date = Date(timeIntervalSince1970: timestamp)
            return date.offsetFrom(date: Date().today)
        }
        return nil
    }
    
    func date() -> String {
        if let timestamp = self.deadline {
            let date = Date(timeIntervalSince1970: timestamp)
            return date.formatted
        }
        return ""
    }
}

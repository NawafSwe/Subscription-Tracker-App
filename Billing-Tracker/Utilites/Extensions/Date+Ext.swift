//
//  Date+Ext.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
extension Date{
 
    
    var notYesterday:Date {
        /// getting date from now till 101
        Calendar.current.date(byAdding: .year, value: -101, to: Date())!
    }
    
    /// calculating days different
    static func daysDiffrent(start: Date, end: Date) -> Int {
        Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    
//    "y, M d"                // 2020, 10 29
//    "YY, MMM d"             // 20, Oct 29
//    "YY, MMM d, hh:mm"      // 20, Oct 29, 02:18
//    "YY, MMM d, HH:mm:ss"   // 20, Oct 29, 14:18:31
    static func dateToString(date:Date , option:String)->String{
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = option

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    static func preventBackDate(from start:Date , to end:Date) -> Date{
        return Date()
    }
}

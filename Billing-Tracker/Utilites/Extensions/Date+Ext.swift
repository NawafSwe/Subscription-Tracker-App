//
//  Date+Ext.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
extension Date{
    static func daysDiffrent(start: Date, end: Date) -> Int {
        Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
}

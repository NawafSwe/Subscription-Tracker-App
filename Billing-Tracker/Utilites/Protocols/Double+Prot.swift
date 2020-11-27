//
//  Double+Prot.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import Foundation
protocol Double {
    /// adding function to convert a string number to double
    func toDouble(numberString:String)->Double
}

extension Double: Double{
    
}

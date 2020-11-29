//
//  Constants.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
//MARK:- K struct holds constants values used across the app
struct K {
    static let devAccount = URL(string:"https://twitter.com/Nawaf_B_910")!
}

/// firebase keys
struct FireStoreKeys{
    enum collections:String {
        case users = "users"
        case providers = "providers"
        case subscriptions = "subscriptions"
    }
    
    enum userFileds:String {
        case providers = "providers"
        case subscriptions = "subscriptions"
    }
}

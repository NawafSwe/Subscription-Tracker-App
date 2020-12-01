//
//  Constants.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
//MARK:- K struct holds constants values used across the app
struct K {
    /// developer account
    static let devAccount = URL(string:"https://twitter.com/Nawaf_B_910")!
}

/// firebase keys collections
struct FirestoreKeys{
    enum collections:String {
        case users = "users"
        case providers = "providers"
        case subscriptions = "subscriptions"
    }
}

//
//  ProviderFormAlert.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import Foundation
import SwiftUI

struct ProviderFormAlert{
    static let emptyName = AlertItem(title: Text("Invalid Form"), message: Text("Please Provider name cannot be empty"), dismissButton: .default(Text("OK")))
    static let exceedLimit = AlertItem(title: Text("Chars Limit Exceeded"), message: Text("Please You are limited to provide only 10 chars for provider name"), dismissButton: .default(Text("Got it")))
}

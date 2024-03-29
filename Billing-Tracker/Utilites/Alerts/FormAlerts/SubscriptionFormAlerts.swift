//
//  SubscriptionFormAlerts.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import Foundation
import SwiftUI
struct SubscriptionFormAlerts {
    static let descriptionCharsLimit = AlertItem(title: Text("Error"), message: Text("You have reached the maximum number of characters where it is 26"), dismissButton: .default(Text("Got it")))
    
    static let invalidForm = AlertItem(title: Text("Invalid Form"), message: Text("Please You Cannot leave any field blank "), dismissButton: .default(Text("Got it")))
    
    static let savedSuccessfully = AlertItem(title: Text("Success"), message: Text("Subscription added successfully"), dismissButton: .default(Text("OK")))
    
    static let unableToProceed = AlertItem(title: Text("Error"), message: Text("Cannot save your subscription please try again "), dismissButton: .default(Text("OK")))
    
    static let didNotSelectedProvider = AlertItem(title: Text("Invalid form"), message: Text("Please You have to select a provider"), dismissButton: .default(Text("OK")))
    
    static let notificationMessageLimit = AlertItem(title: Text("Error"), message: Text("You have reached the maximum number of characters where it is 27"), dismissButton: .default(Text("Got it")))
    static let CannotUpdate = AlertItem(title: Text("Error"), message: Text("We Are Sorry We cannot update your subscription in this time try again later"), dismissButton: .default(Text("OK")))
    static let priceError = AlertItem(title: Text("Error"), message: Text("Price must be valid numbers such 32.40"), dismissButton: .default(Text("Got it")))
    
}

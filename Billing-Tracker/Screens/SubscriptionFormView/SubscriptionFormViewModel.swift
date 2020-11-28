//
//  SubscriptionFormViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import SwiftUI
import CoreData

final class SubscriptionFormViewModel: ObservableObject {
    @Environment (\.presentationMode) var presentationMode
    @Published var providersList = Providers.providersList
    @Published var selectedProvider = 0
    @Published var subDescription = ""
    @Published var subPrice:String = ""
    @Published var date = Date()
    @Published var selectedCycle = 0
    @Published var cycleTypes = ["weekly","monthly","yearly"]
    var calculatePrice:Double {
        Double(subPrice) ?? 0.0
    }
    @Published var remindUser = false
    
}


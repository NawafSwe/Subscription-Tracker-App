//
//  ManageSubscriptionsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class ManageSubscriptionsViewModel : ObservableObject{
    @Published var subscriptions = SubscriptionsService.shared.subscriptions
    @Published var alertItem: AlertItem? = nil
    @Published var selectedSubIndex = 0
    
    
    func deleteSubscription(indices: IndexSet){    }
    
}

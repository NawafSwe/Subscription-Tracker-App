//
//  SubscriptionTimingsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
import Combine
final class SubscriptionTimingsViewModel: ObservableObject {
    @Published var subscriptions = [SubscriptionCellViewModel] ()
    @Published var alertItem : AlertItem? = nil
    @Published var subscriptionRepository = SubscriptionRepository()
    // for storage
    private var cancellables  = Set<AnyCancellable>()
    init() {
        self.subscriptionRepository.$subscriptions
            .map{ subscriptions in
                subscriptions.map{subscription in
                    SubscriptionCellViewModel(subscription: subscription)
                }
            }
            //assign and store received subscriptions
            .assign(to: \.subscriptions, on: self)
            .store(in: &cancellables)
    }
    //creating lazy grid , flexible telling him fill the size of the screen as much as you can
    //each gridItem inside the grid item array represents number of columns
    let columns : [GridItem] = [ GridItem(.flexible()) ,GridItem(.flexible())]
    
    
    
}

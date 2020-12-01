//
//  ManageSubscriptionsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
import Combine
final class ManageSubscriptionsViewModel : ObservableObject{
    @Published var subscriptions = [SubscriptionCellViewModel]()
    @Published var alertItem: AlertItem? = nil
    @Published var selectedSubIndex = 0
    @Published var subscriptionsRepository = SubscriptionRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        self.subscriptionsRepository.$subscriptions
            .map{subscriptions in
                subscriptions.map{ subscription in
                    SubscriptionCellViewModel(subscription: subscription)
                }
            }
            //assign values and store it
            .assign(to: \.subscriptions, on: self)
            .store(in: &cancellables)
    }
    func deleteSubscription(offsets: IndexSet){
        var captureId :String? =  nil
        for offset in offsets {
            // subscription
            let foundSub = subscriptionsRepository.subscriptions[offset]
            captureId = foundSub.id
            
        }
        // making sure we have the id
        guard let safeId = captureId else {return }
        // deleting the subscription
        subscriptionsRepository.deleteSubscription(subscriptionId: safeId)
    }
}



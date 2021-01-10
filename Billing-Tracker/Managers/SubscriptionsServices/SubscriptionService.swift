//
//  SubscriptionService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import Foundation
import SwiftUI
import Firebase
import Combine

final class SubscriptionServices : ObservableObject , Identifiable{
    // published subscription
    @Published var subscription : Subscription
    @Published var subscriptionRepository = SubscriptionRepository()
    // for storage
    private var cancellables  = Set<AnyCancellable>()
    var id :String  = ""
    var userId = Auth.auth().currentUser?.uid
    
    init (subscription: Subscription){
        self.subscription = subscription
        // now let listen for the repo changes
        // when $ sign proceed a published var from else where means listen to any changes and keep me updated
        // saving the doc id into id field , using compact map because we have string of optional
        $subscription
            .compactMap{ subscription in
                subscription.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
}

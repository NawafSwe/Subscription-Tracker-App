//
//  SubscriptionListViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
import Combine
final class SubscriptionListViewModel : ObservableObject{
    @Published var alertItem : AlertItem? = nil
    @Published var showSubscriptionDetail = false
    @Published var selectedSubscription:Subscription? {didSet {self.showSubscriptionDetail = true } }
    @Published var showSubscriptionForm = false
    @Published var viewState : CGSize = .zero
    @Published var callingTimes = 0
    @Published var subscriptionCellViewModels = [SubscriptionCellViewModel]()
    @Published var subscriptionRepository = SubscriptionRepository()
    private var cancellables = Set<AnyCancellable>()
   // var totalPrice : Double { subscriptions.reduce(0){$0 + $1.price} }
    init(){
        // getting all subscriptions and initing it into the subscription cell view model
        /// `$subscriptions` to listen for life updates keep me updated
        self.subscriptionRepository.$subscriptions
            .map{ subscriptions in
                
                subscriptions.map{ subscription in
                    SubscriptionCellViewModel(subscription: subscription)
                }
                
            }
            // assigns the subscriptions into our subscription cell view model
            .assign(to: \.subscriptionCellViewModels, on: self)
            // saving memory
            .store(in: &cancellables)
    }
    
}

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
    @Published var selectedSubscription:SubscriptionServices? {didSet {self.showSubscriptionDetail = true } }
    @Published var showSubscriptionForm = false
    @Published var viewState : CGSize = .zero
    @Published var callingTimes = 0
    @Published var subscriptionServices = [SubscriptionServices]()
    @Published var subscriptionRepository = SubscriptionRepository()
    let columns : [GridItem] = [ GridItem(.flexible())]
    let rows : [GridItem] = [GridItem(.flexible() )]
    private var cancellables = Set<AnyCancellable>()
    let listSample = MockData.subscriptionSampleList
    var totalPrice  = Double()
    init(){
        // getting all subscriptions and initing it into the subscription cell view model
        /// `$subscriptions` to listen for life updates keep me updated
        self.subscriptionRepository.$subscriptions
            .map{ subscriptions in
                
                subscriptions.map{ subscription in
                    SubscriptionServices(subscription: subscription)
                    
                }
            }
            // assigns the subscriptions into our subscription cell view model
            .assign(to: \.subscriptionServices, on: self)
            // saving memory
            .store(in: &cancellables)
        
        // mapping on price
        self.subscriptionRepository.$subscriptions
            .map { subscriptions in
                subscriptions.reduce(0){$0 + $1.price}
            }
            .assign(to: \.totalPrice, on: self)
            .store(in: &cancellables)
    }
}



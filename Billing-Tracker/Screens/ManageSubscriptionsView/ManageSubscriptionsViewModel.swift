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
    @Published var subscriptions = [SubscriptionServices]()
    @Published var alertItem: AlertItem? = nil
    @Published var selectedSubIndex = 0
    @Published var subscriptionsRepository = SubscriptionRepository()
    @Published var isEditing = false
    private var cancellables = Set<AnyCancellable>()
    @Published var showUpdateForm = false
    @Published var selectedSubscription:Subscription? { didSet{self.showUpdateForm = true } }

    init(){
        self.subscriptionsRepository.$subscriptions
            .map{subscriptions in
                subscriptions.map{ subscription in
                    SubscriptionServices(subscription: subscription)
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
        subscriptionsRepository.deleteSubscription(subscriptionId: safeId){result in
            switch result{
                case .success(_):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Success"), message: Text("Subscription deleted successfully"), dismissButton: .default(Text("OK")))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Server Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                    }
            }
        }
    }
}


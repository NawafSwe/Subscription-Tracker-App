//
//  SubscriptionListViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class SubscriptionListViewModel : ObservableObject{
    @Published var subscriptions : [Subscription] = []
    @Published var alertItem : AlertItem? = nil
    @Published var showSubscriptionDetail = false
    @Published var selectedSubscription:Subscription? {didSet {self.showSubscriptionDetail = true } }
    @Published var showSubscriptionForm = false
    @Published var viewState : CGSize = .zero
    
    func getSubscriptions(){
        print(UserAuthenticationManager.shared.user.uid)
        DispatchQueue.main.async {
            SubscriptionsService.shared.getSubscriptionsFromDB(){ result in
                switch result {
                    case .success(_):
                        self.subscriptions =  SubscriptionsService.shared.subscriptions
                        print(self.subscriptions)
                    case .failure(let err):
                        self.alertItem = AlertItem(title: Text("NetworkError"), message: Text("\(err.localizedDescription)"), dismissButton: .default(Text("OK")))
                        
                }
                
            }
        }
        
    }
}

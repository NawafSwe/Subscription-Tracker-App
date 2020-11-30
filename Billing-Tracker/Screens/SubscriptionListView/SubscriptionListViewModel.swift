//
//  SubscriptionListViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class SubscriptionListViewModel : ObservableObject{
    @Published var subscriptions : [Subscription] = SubscriptionsService.shared.subscriptions
    @Published var alertItem : AlertItem? = nil
    @Published var showSubscriptionDetail = false
    @Published var selectedSubscription:Subscription? {didSet {self.showSubscriptionDetail = true } }
    @Published var showSubscriptionForm = false
    @Published var viewState : CGSize = .zero
    @Published var callingTimes = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var totalPrice : Double {
        subscriptions.reduce(0){$0 + $1.price}
    }
    
    func getSubscriptions(){
        DispatchQueue.main.async {
            SubscriptionsService.shared.getSubscriptionsFromDB(){ result in
                switch result {
                    case .success(_):
                        self.subscriptions =  SubscriptionsService.shared.subscriptions
                    case .failure(let err):
                        self.alertItem = AlertItem(title: Text("NetworkError"), message: Text("\(err.localizedDescription)"), dismissButton: .default(Text("OK")))
                }
                
            }
        }
    }
    
    /// watch it carefully --- maybe retrieving all data of user on the tab bar view better 
    func doStopCalling(){
        if self.callingTimes > 1 || !subscriptions.isEmpty {
            self.timer.upstream.connect().cancel()
            print("stoping at \(callingTimes)")
            
        }else{
            self.getSubscriptions()
            callingTimes += 1
            print("counting now is \(callingTimes)")
        }
        
    }
}

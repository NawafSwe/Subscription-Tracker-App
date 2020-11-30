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
    @Published var callingTimes = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var totalPrice : Double { subscriptions.reduce(0){$0 + $1.price} }
    func getSubscriptions(){
        
        SubscriptionsService.shared.getSubscriptionsFromDB(){result in
            print(self.subscriptions)
            switch result {
                case .success(let subscriptions):
                    DispatchQueue.main.async {
                        self.subscriptions = subscriptions
                       
                        }
                    return
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("NetworkError"), message: Text("\(err.localizedDescription)"), dismissButton: .default(Text("OK")))
                        
                    }
                    return
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

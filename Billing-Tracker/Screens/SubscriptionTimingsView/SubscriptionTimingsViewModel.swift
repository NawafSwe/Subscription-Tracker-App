//
//  SubscriptionTimingsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class SubscriptionTimingsViewModel: ObservableObject {
    @Published var subscriptions :[Subscription] = []
    @Published var alertItem : AlertItem? = nil
        
    //creating lazy grid , flexible telling him fill the size of the screen as much as you can
    //each gridItem inside the grid item array represents number of columns
    let columns : [GridItem] = [ GridItem(.flexible()) ,GridItem(.flexible())]
    
    
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
    func daysBetween(start: Date, end: Date) -> Int {
        Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
}

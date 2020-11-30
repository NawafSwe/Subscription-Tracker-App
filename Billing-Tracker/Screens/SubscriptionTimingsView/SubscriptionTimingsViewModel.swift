//
//  SubscriptionTimingsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class SubscriptionTimingsViewModel: ObservableObject {
    @Published var subscriptions : [Subscription] = SubscriptionsService.shared.subscriptions
    @Published var alertItem : AlertItem? = nil
    @Published var callingTimes = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //creating lazy grid , flexible telling him fill the size of the screen as much as you can
    //each gridItem inside the grid item array represents number of columns
    let columns : [GridItem] = [ GridItem(.flexible()) ,GridItem(.flexible())]
    
    
    func getSubscriptions(){
        
        SubscriptionsService.shared.getSubscriptionsFromDB(){ result in
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.subscriptions =  SubscriptionsService.shared.subscriptions
                        
                    }
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("NetworkError"), message: Text("\(err.localizedDescription)"), dismissButton: .default(Text("OK")))
                        
                    }
                    
            }
            
        }
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    /// watch it carefully --- maybe retrieving all data of user on the tab bar view better
    func doStopCalling(){
        if self.callingTimes > 1 || !subscriptions.isEmpty {
            self.timer.upstream.connect().cancel()
            //  print("stoping at \(callingTimes)")
            
        }else{
            self.getSubscriptions()
            callingTimes += 1
            //  print("counting now is \(callingTimes)")
        }
        
    }
}

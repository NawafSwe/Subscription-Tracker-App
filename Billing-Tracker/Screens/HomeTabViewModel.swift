//
//  HomeTabViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation

final class HomeTabViewModel:ObservableObject{
    @Published var callingTimes = 0
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()
    
    
    func getSubscriptions(){
        DispatchQueue.main.async {
            SubscriptionsService.shared.getSubscriptionsFromDB(){ result in
                switch result {
                    case .success(_):
                        return
                    case .failure(_):
                      return
                        
                }
            }
        }
    }
    
    func doStopCalling(){
        if self.callingTimes > 3 {
            self.timer.upstream.connect().cancel()
            
        }else{
            self.getSubscriptions()
            callingTimes += 1
        }
        
    }
    
}


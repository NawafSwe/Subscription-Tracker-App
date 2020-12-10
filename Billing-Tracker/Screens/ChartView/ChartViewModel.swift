//
//  ChartViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 10/12/2020.
//

import Foundation
import SwiftUI
import Combine
final class ChartViewModel:ObservableObject{
    @Published var subscriptionsRepository = SubscriptionRepository()
    @Published var Period = "Weekly"
    @Published var data : [Double] = [Double]()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData(period:String){
        self.subscriptionsRepository.getCategorizedSubscriptions(period: period){ _ in }
        
        self.subscriptionsRepository
            .$subscriptions.map{subscriptions in
                subscriptions.map{subscription in
                    subscription.price
                }
            }
            .assign(to: \.data, on: self)
            .store(in: &cancellables)
        
    }
}

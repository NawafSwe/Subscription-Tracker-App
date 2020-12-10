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
    @Published var data : [Double] = [Double]()
    @Published var title = "Weekly"
    let myCustomStyle = ChartStyle(backgroundColor: .chartBackground , accentColor: .mainColor, secondGradientColor: .charsLimitColor1, textColor: .standardText, legendTextColor: .buttonSnow, dropShadowColor: .black)
    @Published var showMonthly = false
    @Published var showWeekly = true
    @Published var showYearly = false
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData(period:String){
        //making sure we clear the list before we fetch data
        data = []
        print(showYearly)
        print(showMonthly)
        print(showWeekly)
        self.title = period
        self.subscriptionsRepository.getCategorizedSubscriptions(period: self.title){ _ in }
        self.subscriptionsRepository
            .$subscriptions.map{subscriptions in
                subscriptions.map{subscription in
                    subscription.price
                }
            }
            .assign(to: \.data, on: self)
            .store(in: &cancellables)
    }
    func togglePeriod(_ period: String){
        switch period {
            case "Weekly":
                DispatchQueue.main.async {
                    
                    self.showWeekly = true
                    self.showMonthly = false
                    self.showYearly = false
                }
            case "Monthly":
                DispatchQueue.main.async {
                    
                    self.showWeekly = false
                    self.showMonthly = true
                    self.showYearly = false
                }
            case "Yearly":
                DispatchQueue.main.async {
                    self.showWeekly = false
                    self.showMonthly = false
                    self.showYearly = true
                }
            default:
                return
        }
    }
    
}

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
    @Published var title = "overall Expenses Statistics"
    let myCustomStyle = ChartStyle(backgroundColor: .chartBackground , accentColor: .mainColor, secondGradientColor: .charsLimitColor1, textColor: .standardText, legendTextColor: .buttonSnow, dropShadowColor: .black)
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        self.getAllStat()
    }
    
    
    
    func getAllStat(){
        self.subscriptionsRepository
            .$subscriptions.map{subscriptions in
                subscriptions.map{subscription in
                    
                    subscription.price
                    
                    
                }
            }
            .assign(to: \.data, on: self)
            .store(in: &cancellables)
        
    }
    //MARK:- Helpers
    //    func togglePeriod(_ period: String){
    //        switch period {
    //            case "Weekly":
    //                DispatchQueue.main.async {
    //
    //                    self.showWeekly = true
    //                    self.showMonthly = false
    //                    self.showYearly = false
    //                }
    //            case "Monthly":
    //                DispatchQueue.main.async {
    //
    //                    self.showWeekly = false
    //                    self.showMonthly = true
    //                    self.showYearly = false
    //                }
    //            case "Yearly":
    //                DispatchQueue.main.async {
    //                    self.showWeekly = false
    //                    self.showMonthly = false
    //                    self.showYearly = true
    //                }
    //            default:
    //                return
    //        }
    //    }
    //
    
    
    
    //MARK:- Future features
    
    
    //    func getWeeklyStat(){
    //        self.title = "weekly"
    //        togglePeriod("weekly")
    //        self.subscriptionsRepository.getCategorizedSubscriptions("weekly"){ _ in }
    //        self.subscriptionsRepository
    //            .$subscriptions.map{subscriptions in
    //                subscriptions.map{subscription in
    //                    if subscription.cycleDays == "Weekly" {
    //                        return subscription.price
    //
    //                    }
    //                    return 0
    //                }
    //            }
    //            .assign(to: \.weeklyData, on: self)
    //            .store(in: &cancellables)
    //
    //
    //
    //    }
    //
    //    func getMonthlyStat(){
    //
    //        self.title = "monthly"
    //        togglePeriod("monthly")
    //        self.subscriptionsRepository.getCategorizedSubscriptions("monthly"){ _ in }
    //        self.subscriptionsRepository
    //            .$subscriptions.map{subscriptions in
    //                subscriptions.map{ subscription in
    //
    //                    if subscription.cycleDays == "Monthly" {
    //                        return subscription.price
    //
    //                    }
    //                    return 0
    //                }
    //            }
    //            .assign(to: \.monthlyData, on: self)
    //            .store(in: &cancellables)
    //
    //
    //    }
    //
    //
    //
    //    func getYearlyStat(){
    //        self.title = "yearly"
    //        togglePeriod("yearly")
    //        self.subscriptionsRepository.getCategorizedSubscriptions("yearly"){ _ in }
    //        self.subscriptionsRepository
    //            .$subscriptions.map{subscriptions in
    //                subscriptions.map{subscription in
    //                    if subscription.cycleDays == "Yearly" {
    //                        return subscription.price
    //
    //                    }
    //                    return 0
    //                }
    //            }
    //            .assign(to: \.yearlyData, on: self)
    //            .store(in: &cancellables)
    //
    //
    //    }
}


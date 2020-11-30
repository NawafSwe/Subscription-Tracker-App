//
//  SubscriptionFormViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import SwiftUI
import CoreData

final class SubscriptionFormViewModel: ObservableObject {
    @Environment (\.presentationMode) var presentationMode
    @Published var providersList = Providers.providersList
    @Published var selectedProvider = 0
    @Published var subDescription = ""
    @Published var subPrice:String = ""
    @Published var date = Date()
    @Published var selectedCycle = 0
    @Published var alertItem:AlertItem? = nil
    @Published var cycleTypes = ["weekly" , "monthly", "yearly"]
    var calculatePrice:Double {
        Double(subPrice) ?? 0.0
    }
    @Published var remindUser = false
    
    
    func addSubscription(){
        
        let sub = Subscription(id: UUID(), userId: UserAuthenticationManager.shared.user.uid, name: providersList[selectedProvider].name, image: providersList[selectedProvider].image, description: subDescription,dueDateString: date.description(with: .current), price: calculatePrice, dueDateInDate: date , cycleDays: cycleTypes[selectedCycle] , notifyMe: remindUser)
        SubscriptionsService.shared.saveSubscriptionWithCustomId(subscription: sub) { (result) in
            switch result{
                case .success(_):
                    self.alertItem = AlertItem(title: Text("Success"), message: Text("You have added your subscription successfully"), dismissButton: .default(Text("Cool")))
                    return
                case .failure(let error):
                    self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                    return
            }
        }
    }
    
}

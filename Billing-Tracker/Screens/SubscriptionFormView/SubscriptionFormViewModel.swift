//
//  SubscriptionFormViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

final class SubscriptionFormViewModel: ObservableObject {
    @Environment (\.presentationMode) var presentationMode
    @Published var providersList = Providers.providersList
    @Published var selectedProvider = 0
    @Published var subDescription = ""
    @Published var subPrice:String = ""
    @Published var date = Date()
    @Published var selectedCycle = 0
    @Published var alertItem:AlertItem? = nil
    
    // cycles when date due add based on it
    @Published var cycleTypes = ["weekly" , "monthly", "yearly"]
    @Published var subscriptionRepository = SubscriptionRepository()
    @Published var remindUser = false
    
    
    // calculating price
    var calculatePrice:Double { Double(subPrice) ?? 0.0 }
    
    /// adding new subscription function
    func addSubscription(){
        // check the form if its valid or not 
        if !isValidForm(){
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return
        }
        // added subscription
        let addedSubscription = Subscription(name: providersList[selectedProvider].name,
                                             image: providersList[selectedProvider].image,
                                             description: subDescription,
                                             dueDateString:Date.dateToString(date: date , option: "YY, MMM d" ) ,
                                             price: calculatePrice,
                                             dueDateInDate: date,
                                             cycleDays: cycleTypes[selectedCycle],
                                             notifyMe: remindUser,
                                             expired: false )
        self.subscriptionRepository.addSubscription(subscription: addedSubscription){ [self] result in
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.alertItem = SubscriptionFormAlerts.savedSuccessfully
                    }
                    return
                case .failure(_):
                    DispatchQueue.main.async {
                        self.alertItem = SubscriptionFormAlerts.unableToProceed
                    }
            }
        }
    }
    
    /// calculating progress
    func calculatingProgress(value: String){
        if value.count > 26 {
            self.subDescription = String(value.prefix(26))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.descriptionCharsLimit
            }
        }
    }
    
    // validation of form
    func isValidForm() -> Bool {
        if subDescription.isEmpty || subPrice.isEmpty {
            return false
        }
        return true
    }
}

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
    @Published var cycleTypes = ["weekly" , "monthly", "yearly"]
    @Published var subscriptionRepository = SubscriptionRepository()
    
    var calculatePrice:Double {
        Double(subPrice) ?? 0.0
    }
    @Published var remindUser = false
    

    func addSubscription(){
        var addedSubscription = Subscription(name: providersList[selectedProvider].name, image: providersList[selectedProvider].image, description: subDescription, dueDateString: date.description(with: .current), price: calculatePrice, dueDateInDate: date, cycleDays: cycleTypes[selectedCycle], notifyMe: remindUser)
        addedSubscription.userId =  Auth.auth().currentUser?.uid
        self.subscriptionRepository.addSubscription(subscription: addedSubscription)
    }
    
}

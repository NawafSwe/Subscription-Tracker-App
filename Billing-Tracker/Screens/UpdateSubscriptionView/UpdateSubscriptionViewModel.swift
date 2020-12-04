//
//  UpdateSubscriptionViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 04/12/2020.
//

import Foundation
import SwiftUI
import Combine
final class UpdateSubscriptionViewModel:ObservableObject{
    
    @Environment (\.presentationMode) var presentationMode
    @Published var alertItem:AlertItem? = nil
    @Published var subscriptionRepository = SubscriptionRepository()
    //fetching providers from repo
    @Published var providersRepository = ProviderRepository()
    private var cancellables = Set<AnyCancellable>()
    var subDescription:Binding<String>
    var subPrice:Binding<String>
    var date: Binding<Date>
    var selectedCycle = 0
    var cycleTypes = ["weekly" , "monthly", "yearly"]
    var remindUser: Binding<Bool>
    var selectedProvider : Binding<Provider>
    @Published var notificationMessage = ""
   
    // calculating price
    var calculatePrice:Double { Double(subPrice.wrappedValue) ?? 0.0 }
    
    init(subDescription:Binding<String> ,subPrice:Binding<String> , date: Binding<Date> , remindUser: Binding<Bool> , selectedProvider:Binding<Provider>){
        self.subDescription = subDescription
        self.subPrice = subPrice
        self.date = date
        self.remindUser = remindUser
        self.selectedProvider = selectedProvider
    }
    
    
    //MARK:- updateSubscription
    func updateSubscription(subscription:Subscription){
        // check the form if its valid or not
        if !isValidForm(){
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return
        }
        
        let updatedSubscription = Subscription(name: selectedProvider.wrappedValue.name,
                                               image: selectedProvider.wrappedValue.image,
                                               description: subDescription.wrappedValue,
                                               dueDateString:Date.dateToString(date: date.wrappedValue , option: "YY, MMM d" ) ,
                                               price: calculatePrice,
                                               dueDateInDate: date.wrappedValue,
                                               cycleDays: cycleTypes[selectedCycle],
                                               notifyMe: remindUser.wrappedValue,
                                               expired: false )
        
        self.subscriptionRepository.updateSubscription(subscriptionId: "some"  ,subscription: updatedSubscription){ [self] result in
            switch result {
                case .success( _ ):
                    /// in case offline
                    DispatchQueue.main.async { self.alertItem = SubscriptionFormAlerts.savedSuccessfully }
                    
                    
                case .failure( _ ):
                    DispatchQueue.main.async { self.alertItem = SubscriptionFormAlerts.unableToProceed }
                    
                    
            }
        }
    }
    
    
    //MARK:- Chars limit functions and form validations
    /// calculating progress
    func descriptionLimit(value: String){
        if value.count > 26 {
            self.subDescription.wrappedValue = String(value.prefix(26))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.descriptionCharsLimit
            }
        }
    }
    
    func notificationLimit(value: String){
        if value.count > 27 {
            self.notificationMessage = String(value.prefix(27))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.notificationMessageLimit
            }
        }
    }
    
    // validation of form
    func isValidForm() -> Bool {
        if subDescription.wrappedValue.isEmpty || subPrice.wrappedValue.isEmpty {
            return false
        }
        return true
    }
}

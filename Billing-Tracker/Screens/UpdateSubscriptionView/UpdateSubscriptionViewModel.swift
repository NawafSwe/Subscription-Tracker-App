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
    var selectedCycle = 0
    var cycleTypes = ["weekly" , "monthly", "yearly"]
    
    @Published var subscription:Subscription
    
    // calculating price
    // var calculatePrice:Double { Double(subPrice.wrappedValue) ?? 0.0 }
    
    init(subscription:Subscription){
        self.subscription = subscription
        
            }
            
        
    
    //MARK:- updateSubscription
    func updateSubscription(){
        // check the form if its valid or not
        if !isValidForm(){
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return
        }
        //asking repo to update and sink it
        
                self.subscriptionRepository.updateSubscription(subscription: subscription) { result in
                    switch result {
                        case .success( let subscription):
                           
                                self.subscription = subscription
                                self.alertItem = SubscriptionFormAlerts.savedSuccessfully
                            
                        case .failure( _ ):
                            DispatchQueue.main.async { self.alertItem = SubscriptionFormAlerts.unableToProceed }

                    }
                }
            
         
    }
    //  MARK:- Chars limit functions and form validations
    //calculating progress
    func descriptionLimit(value: String){
        if value.count > 26 {
            subscription.description = String(value.prefix(26))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.descriptionCharsLimit
            }
        }
    }
    
    func notificationLimit(value: String){
        if value.count > 27 {
            subscription.notificationMessage = String(value.prefix(27))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.notificationMessageLimit
            }
        }
    }
    
    // validation of form
    func isValidForm() -> Bool {
        if subscription.description.isEmpty{
            return false
        }
        guard let _ = Double(subscription.priceString) else {return false }
        return true
    }
}

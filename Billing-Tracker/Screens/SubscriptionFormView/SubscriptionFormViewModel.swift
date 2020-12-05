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
import Combine

final class SubscriptionFormViewModel: ObservableObject {
    @Environment (\.presentationMode) var presentationMode
    @Published var providersList = [ProviderServices]()
    @Published var alertItem:AlertItem? = nil
    @Published var subscriptionRepository = SubscriptionRepository()
    //fetching providers from repo
    @Published var providersRepository = ProviderRepository()
    private var cancellables = Set<AnyCancellable>()
    @Published var didSelectProvider = false
    @Published var showProvidersList = false
    
    //MARK:- Shared
    @Published var subDescription = ""
    @Published var subPrice:String = ""
    @Published var date = Date()
    @Published var selectedCycle = 0
    @Published var cycleTypes = ["weekly" , "monthly", "yearly"]
    @Published var remindUser = false
    @Published var selectedProvider:Provider?{ didSet{didSelectProvider = true} }
    @Published var notificationMessage = ""
    // calculating price
    var calculatePrice:Double { Double(subPrice) ?? 0.0 }
    
    
    //MARK:-  init
    /// initing the providers list
    init(){
        self.providersRepository.$providers
            .map{ providers in
                providers.map{provider in
                    ProviderServices(provider: provider)
                }
            }
            .assign(to: \.providersList, on: self)
            .store(in: &cancellables)
    }
    
    //MARK:- addSubscription
    /// adding new subscription function
    func addSubscription(){
        // check the form if its valid or not 
        if !isValidForm(){
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return
        }
        
        // the selectedProvider if no selected throw alert
        guard let selectedProvider = self.selectedProvider else {
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.didNotSelectedProvider
            }
            return
            
        }
        // added subscription
        
        let addedSubscription = Subscription(name: selectedProvider.name,
                                             image: selectedProvider.image,
                                             description: subDescription,
                                             dueDateString:Date.dateToString(date: date , option: "YY, MMM d" ) ,
                                             price: calculatePrice,
                                             dueDateInDate: date,
                                             cycleDays: cycleTypes[selectedCycle],
                                             notifyMe: remindUser,
                                             expired: false ,
                                             priceString:subPrice,
                                             notificationMessage:notificationMessage
                                             
        )
        self.subscriptionRepository.addSubscription(subscription: addedSubscription){ [self] result in
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
            self.subDescription = String(value.prefix(26))
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
        if subDescription.isEmpty || subPrice.isEmpty {
            return false
        }
        // checks if user put numbers or chars
        guard let _ = Double(subPrice) else {return
            false
            
        }
        return true
    }
    
}

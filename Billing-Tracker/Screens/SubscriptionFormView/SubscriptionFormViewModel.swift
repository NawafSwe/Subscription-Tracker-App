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
import UserNotifications

final class SubscriptionFormViewModel: ObservableObject {
     //MARK:- Attributes
    /// presentationMode for dismiss views
    @Environment (\.presentationMode) var presentationMode
    
    /// providersList getting all user providersList
    @Published var providersList = [ProviderServices]()
    /// alertItem to alert user on actions
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
    @Published var cycleTypes = ["Weekly" , "Monthly", "Yearly"]
    @Published var remindUser = false
    @Published var selectedProvider:Provider?{ didSet{didSelectProvider = true} }
    @Published var notificationMessage = ""
    private var notificationId = ""
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
        if !isValidForm(){ return }
        if remindUser{
            initNotification(with: self.date)
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
                                             notificationMessage:notificationMessage, cycleIndex: self.selectedCycle  , notificationId: self.notificationId
                                             
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
    
    //  MARK:- descriptionLimit
    /// calculating  description progress
    func descriptionLimit(value: String){
        if value.count > 26 {
            self.subDescription = String(value.prefix(26))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.descriptionCharsLimit
            }
        }
    }
    //MARK:- notificationLimit
    /// notification limit char checker
    func notificationLimit(value: String){
        if value.count > 27 {
            self.notificationMessage = String(value.prefix(27))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.notificationMessageLimit
            }
        }
    }
    
    //MARK:- isValidForm
    /// checking if the form valid or not before proceed
    func isValidForm() ->Bool {
        if self.subDescription.isEmpty{
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return false
            
        }
        guard let _ = Double(subPrice) else {
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.priceError
                
            }
            return false
        }
        return true
        
    }
    
    //MARK:- initNotification
    /// creating notification
    func initNotification(with date:Date){
        let providerName = selectedProvider?.name
        // choose a random identifier
        self.notificationId =  UUID().uuidString
        K.initNotification(date: date, message: notificationMessage , providerName: providerName , notificationId: self.notificationId)
        
    }
    //MARK:- requestNotificationAuthorization
    /// request user authorization if not requested before
    func requestNotificationAuthorization(){
        K.requestNotificationAuthorization(){ [self] result in
            switch result{
                case true : return
                case false :
                    // tell user to turn on notification center
                    DispatchQueue.main.async {
                        alertItem = AlertItem(title: Text("Notification Error"), message: Text("Please turn on your notification from the notification center"), dismissButton: .default(Text("Ok")))
                    }
                    return
                    
            }
        }
    }
}

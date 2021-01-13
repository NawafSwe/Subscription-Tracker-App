//
//  UpdateSubscriptionViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 04/12/2020.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications
final class UpdateSubscriptionViewModel:ObservableObject{
    
    @Environment (\.presentationMode) var presentationMode
    @Published var alertItem:AlertItem? = nil
    @Published var subscriptionRepository = SubscriptionRepository()
    //fetching providers from repo
    @Published var providersRepository = ProviderRepository()
    private var cancellables = Set<AnyCancellable>()
    @Published var cycleTypes = ["Weekly" , "Monthly", "Yearly"]
    @Published var subscription: SubscriptionServices
    
    
    //MARK:- init
    init(subscription:SubscriptionServices){ self.subscription = subscription }
    
    //MARK:- updateSubscription
    /// update current subscription data
    func updateSubscription(){
        // check the form if its valid or not
        if !isValidForm(){ return }
        
        // if notification was allowed and user want to be notified
        if subscription.subscription.notifyMe{
            initNotification(with: subscription.subscription.dueDateInDate)
        }
        
        //asking repo to update and sink it
        self.subscriptionRepository.updateSubscription(subscription: subscription.subscription) { [self] result in
            switch result {
                case .success(_):
                    DispatchQueue.main.async { self.alertItem = SubscriptionFormAlerts.savedSuccessfully }
                    
                case .failure( _ ):
                    DispatchQueue.main.async { self.alertItem = SubscriptionFormAlerts.unableToProceed }
            }
        }
    }
    //  MARK:- Chars limit functions and form validations
    /// calculating progress
    func descriptionLimit(value: String){
        if value.count > 26 {
            subscription.subscription.description = String(value.prefix(26))
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
            subscription.subscription.notificationMessage = String(value.prefix(27))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.notificationMessageLimit
            }
        }
    }
    
    //MARK:- isValidForm
    /// checking if the form valid or not before proceed
    func isValidForm() ->Bool {
        if subscription.subscription.description.isEmpty{
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.invalidForm
            }
            return false
            
        }
        guard let _ = Double(subscription.subscription.priceString) else {
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.priceError
                
            }
            return false
        }
        return true
        
    }
    
    //MARK:- requestNotificationAuthorization
    /// request user authorization if not requested before
    func requestNotificationAuthorization(){
        // removing notification with an id if the notification toggled to false
        if !subscription.subscription.notifyMe{
            removeNotification(with: subscription.subscription.notificationId)
        }
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
    
    //MARK:- initNotification
    /// creating notification
    func initNotification(with date:Date){
        let providerName = subscription.subscription.name
        // choose a random identifier
        self.subscription.subscription.notificationId =  UUID().uuidString
        
        K.initNotification(date: date, message: subscription.subscription.notificationMessage, providerName: providerName, notificationId: self.subscription.subscription.notificationId)
    }
    func removeNotification(with identifier: String){
        self.subscription.subscription.notificationId = ""
        K.removeNotification(with: identifier)
    }
}

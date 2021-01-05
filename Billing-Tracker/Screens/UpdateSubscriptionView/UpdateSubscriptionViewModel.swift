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
    private var isNotificationAllowed = false
    
    
    
    //MARK:- init
    init(subscription:SubscriptionServices){ self.subscription = subscription }
    
    //MARK:- updateSubscription
    func updateSubscription(){
        // check the form if its valid or not
        if !isValidForm(){ return }
        
        // if notification was allowed and user want to be notified
        if isNotificationAllowed && subscription.subscription.notifyMe{
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
    // calculating progress
    func descriptionLimit(value: String){
        if value.count > 26 {
            subscription.subscription.description = String(value.prefix(26))
            /// put alert to user about the reason.
            DispatchQueue.main.async {
                self.alertItem = SubscriptionFormAlerts.descriptionCharsLimit
            }
        }
    }
    
    //notification limit char
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
    
    //MARK:- creating notification
    func requestNotificationAuthorization(){
        // removing notification with an id if the notification toggled to false
        if !subscription.subscription.notifyMe{
            removeNotification(with: subscription.subscription.notificationId)
        }
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                self.isNotificationAllowed = true
                return
            } else if let _ = error{
                self.isNotificationAllowed = false
                // tell user to turn on notification center
                DispatchQueue.main.async {
                    self.alertItem = AlertItem(title: Text("Notification Error"), message: Text("Please turn on your notification from the notification center"), dismissButton: .default(Text("Ok")))
                }
                return
            }
        }
    }
    
    func initNotification(with date:Date){
        let content = UNMutableNotificationContent()
        content.title = "Subscription due date Reminder"
        content.subtitle = subscription.subscription.name
        
        content.body = "\(subscription.subscription.notificationMessage)"
        content.sound = UNNotificationSound.default
        
        //// Configure the recurring date.
        var dateComponents = DateComponents()
        /// to extract date component
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.calendar = calendar
        // end of config date
        ////  Create the trigger as a repeating event.
        
        // choosing the trigger if the day is equal to one we want to notify user after an hour
        // choose a random identifier
        subscription.subscription.notificationId =  UUID().uuidString
        var request:UNNotificationRequest
        
        if Date.daysDiffrent(start: Date(), end: date) == 1{
            // not repeated
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: false)
            request = UNNotificationRequest(identifier:  subscription.subscription.notificationId , content: content, trigger: trigger)
            
        }else{
            // not repeated
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            request = UNNotificationRequest(identifier:  subscription.subscription.notificationId, content: content, trigger: trigger)
            
        }
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func removeNotification(with identifier: String){
        if !identifier.isEmpty{
            self.subscription.subscription.notificationId = ""
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            
        }
    }
}

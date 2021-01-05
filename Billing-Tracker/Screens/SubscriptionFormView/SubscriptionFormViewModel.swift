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
    // validation of form
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
    
    //MARK:- creating notification
    func requestNotificationAuthorization(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success{
                print("success")
                return
            } else if let _ = error{
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
        content.subtitle = self.notificationMessage
        content.body = "\(self.notificationMessage)"
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
        self.notificationId =  UUID().uuidString
        var request:UNNotificationRequest
        
        if Date.daysDiffrent(start: Date(), end: date) == 1{
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
            request = UNNotificationRequest(identifier: self.notificationId, content: content, trigger: trigger)
            
        }else{
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            request = UNNotificationRequest(identifier: self.notificationId, content: content, trigger: trigger)
            
        }
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
}


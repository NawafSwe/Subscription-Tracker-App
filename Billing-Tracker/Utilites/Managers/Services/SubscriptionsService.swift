//
//  SubscriptionsService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import Combine

//MARK:- SubscriptionsService singleton class
final class SubscriptionsService : ObservableObject{
    static let shared = SubscriptionsService()
    @Published var subscriptions:[Subscription] = [Subscription]()
    @Published var subscriptionRepository = SubscriptionRepository()
    let fireStore = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    private init(){   }
    /// getSubscriptionsFromDB get all subscriptions from db life data
    /// - Parameter completion: completion handler
    func getSubscriptionsFromDB(completion: @escaping(Result<[Subscription],Error>) ->Void){
        
        
    }
}

/// addSubscription adding document to firebase
/// - Parameters:
///   - subscription: subscription object has the data
///   - completion: completion handler
/// - Returns: void
func addSubscription(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
    
}



/// saveSubscriptionWithId save document data with id
/// - Parameters:
///   - subscription: subscription data
///   - completion:  completion handler
/// - Returns: Void
func saveSubscriptionWithCustomId(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
    
    
    
}
/// deleteSubscription
/// - Parameters:
///   - docId: document id
///   - completion: completion handler
/// - Returns: Void
func deleteSubscription(docId:String , completion: @escaping (Result<Void,Error>) -> () ){
    
}


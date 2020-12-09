//
//  SubscriptionRepository.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 01/12/2020.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

final class SubscriptionRepository :ObservableObject{
    private let db = Firestore.firestore()
    @Published var subscriptions  = [Subscription]()
    private let collectionName = FirestoreKeys.Collections.subscriptions.rawValue
    
    init(){ loadData() }
    
    /// LoadData loading all subscriptions data once from firebase life  and setting the subscriptions
    /// - Returns: Void
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid{
            // loading subscriptions with user id
            db.collection(collectionName)
                .whereField("userId", isEqualTo: userId)
                .order(by: "createdTime")
                .addSnapshotListener { (querySnapshot, error) in
                    if let error = error {
                        fatalError("Error in your network I will customize them for sure \(error.localizedDescription)" )
                        
                    }
                    // if we have query
                    if let querySnapshot = querySnapshot {
                        // mapping query with its id and adding them into subscriptions list
                        self.subscriptions = querySnapshot.documents
                            .compactMap{ document in
                                try? document.data(as: Subscription.self)
                                
                            }
                        
                    }
                }
        }
    }
    
    /// LoadDataOnce loading all subscriptions data once from firebase and setting the subscriptions
    /// - Returns: Void
    func LoadDataOnce(){
        if let userId = Auth.auth().currentUser?.uid{
            // loading subscriptions with user id
            db.collection(collectionName)
                .whereField("userId", isEqualTo: userId)
                .order(by: "createdTime")
                .getDocuments { (querySnapshot, error) in
                    if let error = error {
                        fatalError("Error in your network I will customize them for sure \(error.localizedDescription)" )
                        
                    }
                    // if we have query
                    if let querySnapshot = querySnapshot {
                        // mapping query with its id and adding them into subscriptions list
                        self.subscriptions = querySnapshot.documents
                            .compactMap{ document in
                                try? document.data(as: Subscription.self)
                                
                            }
                        
                    }
                }
        }
    }
    
    /// addSubscription adding subscription document to firebase
    /// - Parameters:
    ///   - collection: collection name
    ///   - model: model data has the data
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    
    func addSubscription(subscription: Subscription , completion: @escaping (Result<Void , Error> ) -> Void){
        if let userId = Auth.auth().currentUser?.uid{
            var helperSubscription = Subscription(name: subscription.name, image: subscription.image, description: subscription.description, dueDateString: subscription.dueDateString, price: subscription.price, dueDateInDate: subscription.dueDateInDate, cycleDays: subscription.cycleDays, notifyMe: subscription.notifyMe, expired: subscription.expired , priceString: subscription.priceString , notificationMessage: subscription.notificationMessage, cycleIndex: subscription.cycleIndex)
            helperSubscription.userId = userId
            do{
                let _ =  try db.collection(collectionName).addDocument(from: helperSubscription){ error in
                    if let error = error{
                        completion(.failure(error))
                        return
                    }
                    completion(.success( () ))
                    return
                }
                
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    /// updateSubscription subscription document to firebase by id
    /// - Parameters:
    ///   - subscriptionId: id of the document
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    
    func updateSubscription(subscription :Subscription , completion: @escaping (Result<Void,Error>) -> () ){
        if let userid = Auth.auth().currentUser?.uid{
            // formating date nicely
            if let subscriptionId = subscription.id{
                let dateInString = Date.dateToString(date: subscription.dueDateInDate, option: "YY, MMM d")
                // I am sure user will not enter doubles because I have checked
                let capturedPrice = Double(subscription.priceString)!
                var capturedCycleDays = ""
                
                switch subscription.cycleIndex {
                    case 0: capturedCycleDays = "Weekly"
                    case 1: capturedCycleDays = "Monthly"
                    case 2: capturedCycleDays = "Yearly"
                    default: capturedCycleDays = "Weekly"
                }
    
                // updating subscription data
                let updatedSubscription = Subscription(userId:userid , name: subscription.name, image: subscription.image,
                                                       description: subscription.description, dueDateString: dateInString , price: capturedPrice,
                                                       dueDateInDate: subscription.dueDateInDate, cycleDays: capturedCycleDays, notifyMe: subscription.notifyMe,
                                                       expired: subscription.expired, priceString: subscription.priceString, notificationMessage: subscription.notificationMessage , cycleIndex: subscription.cycleIndex)
                do{
                    try db.collection(collectionName).document(subscriptionId)
                        .setData(from: updatedSubscription){error in
                            if let error = error {
                                completion(.failure(error))
                                print(error)
                                return
                            }
                            
                            completion(.success( () ))
                        
                        }
                }catch {
                    completion(.failure(error))
                    return
                }
            }
            
        }
        
    }
    
    
    /// deleteSubscription deleting subscription document to firebase
    /// - Parameters:
    ///   - subscriptionId: id of the document
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    
    func deleteSubscription(subscriptionId : String , completion: @escaping (Result<Void, Error>) -> Void ){
        db.collection(FirestoreKeys.Collections.subscriptions.rawValue).document(subscriptionId).delete{ error in
            if let error  = error{
                completion(.failure(error))
                return
            }
            completion(.success( () ))
            return 
        }
    }
}

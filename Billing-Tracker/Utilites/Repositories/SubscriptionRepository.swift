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
    let db = Firestore.firestore()
    @Published var subscriptions  = [Subscription]()
    let collectionName = FirestoreKeys.collections.subscriptions.rawValue
    
    init(){
        loadData()
        
    }
    
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid{
            // loading subscriptions with user id
            db.collection(collectionName)
                .order(by: "createdTime")
                .whereField("userId", isEqualTo: userId)
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
    
    func getAllSubscriptions (completion: @escaping (Result<[Subscription] , Error>) -> () ){
        
    }
    
    
    
    /// addSubscription adding subscription document to firebase
    /// - Parameters:
    ///   - collection: collection name
    ///   - model: model data has the data
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    
    func addSubscription(subscription: Subscription , completion: @escaping (Result<Void , Error> ) -> Void){
        if let userId = Auth.auth().currentUser?.uid{
            var helperSubscription = Subscription(name: subscription.name, image: subscription.image, description: subscription.description, dueDateString: subscription.dueDateString, price: subscription.price, dueDateInDate: subscription.dueDateInDate, cycleDays: subscription.cycleDays, notifyMe: subscription.notifyMe)
            helperSubscription.userId = userId
            do{
                let _ =  try db.collection(collectionName).addDocument(from: helperSubscription){ error in
                    if let error = error{
                        completion(.failure(error))
                        return
                    }
                }
                
            }catch {
                completion(.failure(error))
            }
        }
    }
    
    
    func deleteSubscription(subscriptionId : String){
        db.collection(FirestoreKeys.collections.subscriptions.rawValue).document(subscriptionId).delete{ error in
            if let error  = error{
                fatalError("cannot delete for some reason \(error.localizedDescription)")
            }
            
        }
    }
    
}


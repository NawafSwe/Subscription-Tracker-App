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
        let userId = Auth.auth().currentUser?.uid
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
    
    func addSubscription(subscription: Subscription){
        if let userId = Auth.auth().currentUser?.uid{
        var helperSubscription = Subscription(name: subscription.name, image: subscription.image, description: subscription.description, dueDateString: subscription.dueDateString, price: subscription.price, dueDateInDate: subscription.dueDateInDate, cycleDays: subscription.cycleDays, notifyMe: subscription.notifyMe)
            helperSubscription.userId = userId
            do{
               let _ =  try db.collection(FirestoreKeys.collections.subscriptions.rawValue).addDocument(from: subscription)
            }catch {
                fatalError("Cannot encode subscription \(error.localizedDescription)")
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


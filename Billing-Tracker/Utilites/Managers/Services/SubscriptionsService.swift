//
//  SubscriptionsService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import CodableFirebase
//MARK:- SubscriptionsService singleton class
final class SubscriptionsService : ObservableObject{
    static let shared = SubscriptionsService()
    @Published var subscriptions:[Subscription] = []
    let fireStore = Firestore.firestore()
    private init(){}
    /// getSubscriptionsFromDB get all subscriptions from db life data
    /// - Parameter completion: completion handler
    func getSubscriptionsFromDB(completion: @escaping(Result<[Subscription],Error>) ->Void){
        
        FireStoreService.shared.getDocuments(collection: FireStoreKeys.collections.subscriptions, docId: UserAuthenticationManager.shared.user.uid){(result: Result<[Subscription], Error>) in
            switch result{
                case .success(let subscriptions ):
                    DispatchQueue.main.async {
                        self.subscriptions = subscriptions
                    }
                    completion(.success(subscriptions))
                    return
                case .failure(let error):
                    completion(.failure(error))
                    return
                    
            }
            
        }
    }
    
    /// addSubscription adding document to firebase
    /// - Parameters:
    ///   - subscription: subscription object has the data
    ///   - completion: completion handler
    /// - Returns: void
    func addSubscription(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
        FireStoreService.shared.addDocument(collection: FireStoreKeys.collections.subscriptions, model: subscription) { result in
            DispatchQueue.main.async {
                switch result{
                    case .failure(let err):
                        completion(.failure(err))
                        return
                    case .success(_):
                        completion(.success(()))
                        return
                }
            }
        }
    }
    
    
    /// saveSubscriptionWithId save document data with id
    /// - Parameters:
    ///   - subscription: subscription data
    ///   - completion:  completion handler
    /// - Returns: Void
    func saveSubscriptionWithCustomId(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
        FireStoreService.shared.saveDocumentWithId(collection: FireStoreKeys.collections.subscriptions, docId: subscription.id.uuidString , model: subscription) {
            (result: Result<Void, Error>) in
            DispatchQueue.main.async {
                
                switch result{
                    case .success():
                        completion(.success(()))
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                }
            }
        }
        
    }
    /// deleteSubscription
    /// - Parameters:
    ///   - docId: document id
    ///   - completion: completion handler
    /// - Returns: Void
    func deleteSubscription(docId:String , completion: @escaping (Result<Void,Error>) -> () ){
        
        FireStoreService.shared.deleteDocument(collection: FireStoreKeys.collections.subscriptions, docId: docId) { (result) in
            DispatchQueue.main.async {
                switch result{
                    case .failure(let err):
                        completion(.failure(err))
                        
                    case .success():
                        completion(.success(()))
                }
            }
        }
    }
}

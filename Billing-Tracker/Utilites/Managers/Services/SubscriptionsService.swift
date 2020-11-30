//
//  SubscriptionsService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import CodableFirebase
final class SubscriptionsService : ObservableObject{
    static let shared = SubscriptionsService()
    @Published var subscriptions:[Subscription] = []
    let fireStore = Firestore.firestore()
    private init(){}
    
    func getSubscriptionsFromDB(completion: @escaping(Result<[Subscription],Error>) ->Void){
        print(UserAuthenticationManager.shared.user.uid)
        DispatchQueue.main.async {
            FireStoreService.shared.getDocuments(collection: FireStoreKeys.collections.subscriptions, docId: UserAuthenticationManager.shared.user.uid){(result: Result<[Subscription], Error>) in
                switch result{
                    case .success(let subscriptions ):
                        self.subscriptions = subscriptions
                        completion(.success(subscriptions))
                    case .failure(let error):
                        completion(.failure(error))
                        return
                        
                }
            }
            
        }
        
    }
    
    func addSubscription(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
        DispatchQueue.main.async {
            FireStoreService.shared.addDocument(collection: FireStoreKeys.collections.subscriptions, model: subscription) { result in
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
    
    
    func saveSubscriptionWithId(subscription:Subscription , completion:@escaping (Result<Void,Error>)->()){
        DispatchQueue.main.async {
            FireStoreService.shared.saveDocumentWithId(collection: FireStoreKeys.collections.subscriptions, docId: UserAuthenticationManager.shared.user.uid, model: subscription) { (result: Result<Void, Error>) in
                switch result{
                    case .success():
                        completion(.success(()))
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                }
            }
        }
        
    }
    
    func deleteSubscription(docId:String , completion: @escaping (Result<Void,Error>) -> () ){
        DispatchQueue.main.async {
            FireStoreService.shared.deleteDocument(collection: FireStoreKeys.collections.subscriptions, docId: docId) { (result) in
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


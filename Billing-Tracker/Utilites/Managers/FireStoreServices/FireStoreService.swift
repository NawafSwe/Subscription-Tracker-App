//
//  FireStoreService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import CodableFirebase
/// singleton class
final class FireStoreService{
    let shared = FireStoreService()
    let fireStore = Firestore.firestore()
    private init (){}
    
    /// getDocumentOnce getting the document data once with no live update
    /// - Parameters:
    ///   - collection: collection name
    ///   - docId: document id
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    func getDocumentOnce<T:Codable>(collection : FireStoreKeys.collections, docId:String , completion: @escaping (Result<T , Error>) -> () ){
        let reference = fireStore.collection(collection.rawValue).document(docId)
        reference.getDocument { (documentSnapshot, error) in
            DispatchQueue.main.async {
                // checking if there is an error
                if let error = error{
                    completion(.failure(error))
                    return
                }
                /// validating snap shot
                guard let safeDocSnapshot = documentSnapshot else{
                    completion(.failure(FireStoreErr.noSnapShot))
                    return
                }
                
                /// checking the document data
                guard let safeDocument = safeDocSnapshot.data() else {
                    completion(.failure(FireStoreErr.noSnapShotData))
                    return
                }
                /// decoding the model
                var model:T
                let decoder = FirebaseDecoder()
                do{
                    model = try decoder.decode(T.self, from: safeDocument)
                    completion(.success(model))
                    return
                    
                }catch _ {
                    completion(.failure(FireStoreErr.cannotDecode))
                    return 
                }
                
            }
        }
    }
    
    
    /// getDocument getting life document data where listing to changes
    /// - Parameters:
    ///   - collection: collection name
    ///   - docId: document id
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    func getDocument<T:Codable>(collection:FireStoreKeys.collections, docId:String , completion: @escaping (Result<T,Error>)->() ){
        let reference = fireStore.collection(collection.rawValue).document(docId)
        reference.addSnapshotListener { (documentSnapshot, error) in
            DispatchQueue.main.async {
                // checking if there is an error
                if let error = error{
                    completion(.failure(error))
                    return
                }
                /// validating snap shot
                guard let safeDocSnapshot = documentSnapshot else{
                    completion(.failure(FireStoreErr.noSnapShot))
                    return
                }
                
                /// checking the document data
                guard let safeDocument = safeDocSnapshot.data() else {
                    completion(.failure(FireStoreErr.noSnapShotData))
                    return
                }
                /// decoding the model
                var model:T
                let decoder = FirebaseDecoder()
                do{
                    model = try decoder.decode(T.self, from: safeDocument)
                    completion(.success(model))
                    return
                    
                }catch _ {
                    completion(.failure(FireStoreErr.cannotDecode))
                    return
                }
                
            }
        }
    }
    
    
}


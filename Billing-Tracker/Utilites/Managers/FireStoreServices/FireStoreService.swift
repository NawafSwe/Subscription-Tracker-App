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
    
    
    /// getDocumentsOnce getting documents once from database
    /// - Parameters:
    ///   - collection: collection name
    ///   - docId: document id
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    
    func getDocumentsOnce<T:Codable>(collection:FireStoreKeys.collections, docId:String, completion: @escaping (Result<[T],Error>) -> () ){
        let reference = fireStore.collection(collection.rawValue).whereField("uid", isEqualTo: docId)
        reference.getDocuments { (querySnapshot, error) in
            DispatchQueue.main.async {
                // checking if there is an error
                if let error = error{
                    completion(.failure(error))
                    return
                }
                /// validating snap shot
                guard let safeDocSnapshot = querySnapshot else{
                    completion(.failure(FireStoreErr.noSnapShot))
                    return
                }
                
                /// decoding the model
                var model:[T] = []
                let documents = safeDocSnapshot.documents
                let decoder = FirebaseDecoder()
                for document in documents{
                    /// decoding each one
                    do{
                        let doc = try decoder.decode(T.self, from: document.data())
                        model.append(doc)
                        
                    }catch _ {
                        completion(.failure(FireStoreErr.cannotDecode))
                        return
                    }
                }
                completion(.success(model))
                return
            }
        }
    }
    
    /// getDocuments getting documents life from database
    /// - Parameters:
    ///   - collection: collection name
    ///   - docId: document id
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    func getDocuments<T:Codable>(collection:FireStoreKeys.collections , docId:String , completion: @escaping (Result<[T],Error>)->() ){
        let reference = fireStore.collection(collection.rawValue).whereField("uid", isEqualTo: docId)
        reference.addSnapshotListener{ (querySnapshot, error) in
            DispatchQueue.main.async {
                // checking if there is an error
                if let error = error{
                    completion(.failure(error))
                    return
                }
                /// validating snap shot
                guard let safeDocSnapshot = querySnapshot else{
                    completion(.failure(FireStoreErr.noSnapShot))
                    return
                }
                
                /// decoding the model
                var model:[T] = []
                let documents = safeDocSnapshot.documents
                let decoder = FirebaseDecoder()
                for document in documents{
                    /// decoding each one
                    do{
                        let doc = try decoder.decode(T.self, from: document.data())
                        model.append(doc)
                        
                    }catch _ {
                        completion(.failure(FireStoreErr.cannotDecode))
                        return
                    }
                }
                completion(.success(model))
                return
            }
            
        }
    }
    
    func saveDocument<T:Codable>(collection: FireStoreKeys.collections , docId:String , model : T  , completion: @escaping (Result<Void , Error> ) -> () ){
        let reference = fireStore.collection(collection.rawValue).document(docId)
        var doc :[String:Any] = [:]
        let encoder = FirebaseEncoder()
        do{
            let data = try encoder.encode(model) as! [String:Any]
            doc = data
        }catch _ {
            completion(.failure(FireStoreErr.cannotDecode))
            return
        }
        
        /// saving data
        reference.setData(doc, merge: true) { error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
                return
            }
        }
    }
    
    /// deleteDocument deleting document by id
    /// - Parameters:
    ///   - collection: collection name
    ///   - docId: document id
    ///   - completion: completion to handle the function call
    /// - Returns: @escaping Completion Function
    func deleteDocument(collection:FireStoreKeys.collections , docId : String , completion: @escaping (Result<Void, Error>)-> ()){
        let reference = fireStore.collection(collection.rawValue).document(docId)
        
        reference.delete{ error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
            return
            
        }
    }
    
    /// updateData to update doc data  with filed
    /// - Parameters:
    ///   - collection: collection naem
    ///   - docId: document id
    ///   - filed: the name of the filed
    ///   - newData: the new data
    ///   - completion: completion function
    /// - Returns: @escaping Completion Function
    func updateData<T:Codable>(collection: FireStoreKeys.collections , docId: String, filed:String , newData: T , completion: @escaping(Result<Void , Error> )->() ) {
        DispatchQueue.main.async {
            let encoder = FirebaseEncoder()
            do{
                /// encoding data
                let doc = try encoder.encode(newData) as! [String:Any]
                /// getting document
                let reference = self.fireStore.collection(collection.rawValue).document(docId)
                /// deleting doc
                reference.updateData([filed:doc]){error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success(()))
                }
                
            }catch let error {
                completion(.failure(error))
                return
            }
            
        }
    }
}

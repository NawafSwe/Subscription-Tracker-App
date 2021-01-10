////
////  FireStoreService.swift
////  Billing-Tracker
////
////  Created by Nawaf B Al sharqi on 29/11/2020.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
////MARK:- FireStoreService singleton class pattern
///// class generic functions for firebase
//final class FirestoreService{
//    static let shared = FirestoreService()
//    private let db = Firestore.firestore()
//
//    private init (){}
//    /// getDocumentsOnce getting documents once from database
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - docId: document id
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func getDocumentsOnce<T:Codable>(collection:FirestoreKeys.Collections, docId:String, completion: @escaping (Result<[T],Error>) -> () ){ }
//
//    /// getDocuments getting documents life from database
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func getDocuments<T:Codable>(collection:FirestoreKeys.Collections , completion: @escaping (Result<[T],Error>)->() ){ }
//
//
//    /// getDocumentOnce getting the document data once with no live update
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - docId: document id
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func getDocumentOnce<T:Codable>(collection : FirestoreKeys.Collections, docId:String , completion: @escaping (Result<T , Error>) -> () ){ }
//
//
//    /// getDocument getting life document data where listing to changes
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - docId: document id
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func getDocument<T:Codable>(collection:FirestoreKeys.Collections, docId:String , completion: @escaping (Result<T,Error>)->() ){ }
//
//
//    /// addDocument adding document to firebase
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - model: model data has the data
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func addDocument<T:Codable>(collection : FirestoreKeys.Collections, model:T , completion: @escaping (Result<Void , Error>)->() ){
//        do{
//            let _ = try  db.collection(collection.rawValue).addDocument(from: model)
//
//        }catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//
//    /// saveDocument saving document data of a document
//    /// - Parameters:
//    ///   - collection: name of the collection
//    ///   - model: model generic object holds the data
//    ///   - completion: completion handler
//    /// - Returns: @escaping Completion Function
//    func saveDocument<T:Codable>(collection:FirestoreKeys.Collections , model: T,  completion: @escaping (Result<Void , Error>)->() ){ }
//
//
//    /// saveDocumentWithId saving document data of a document with id
//    /// - Parameters:
//    ///   - collection: name of the collection
//    ///   - model: model generic object holds the data
//    ///   - completion: completion handler
//    /// - Returns: @escaping Completion Function
//
//    func saveDocumentWithId<T:Codable>(collection: FirestoreKeys.Collections , docId:String , model : T  , completion: @escaping (Result<Void , Error> ) -> () ){ }
//
//    /// deleteDocument deleting document by id
//    /// - Parameters:
//    ///   - collection: collection name
//    ///   - docId: document id
//    ///   - completion: completion to handle the function call
//    /// - Returns: @escaping Completion Function
//    func deleteDocument(collection:FirestoreKeys.Collections , docId : String , completion: @escaping (Result<Void, Error>)-> ()){ }
//
//    /// updateData to update doc data  with filed
//    /// - Parameters:
//    ///   - collection: collection naem
//    ///   - docId: document id
//    ///   - filed: the name of the filed
//    ///   - newData: the new data
//    ///   - completion: completion function
//    /// - Returns: @escaping Completion Function
//    func updateData<T:Codable>(collection: FirestoreKeys.Collections , docId: String, filed:String , newData: T , completion: @escaping(Result<Void , Error> )->() ) {}
//}

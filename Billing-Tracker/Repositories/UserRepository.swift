//
//  UserRepository.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 01/12/2020.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase
final class UserRepository : ObservableObject{
    @Published var user: User = userHolder.dummyUser
    private let db = Firestore.firestore()
    private let collectionName = FirestoreKeys.Collections.users.rawValue
    static let shared = UserRepository()

    init(){ self.loadUserData(){ _  in } }
    
    /// loading user data from firestore
    /// - Parameter completion: completion function to load user data
    func loadUserData(completion: @escaping (Result<User, Error>)-> Void ){
        if let userId = Auth.auth().currentUser?.uid{
            db.collection(collectionName).document(userId)
                .addSnapshotListener { (documentSnapshot, error) in
                    if let error = error{
                        completion(.failure(error))
                        
                    }
                    if let safeDoc = documentSnapshot{
                        guard let safeUser = try? safeDoc.data(as: User.self)else{ return }
                        self.user = safeUser
                        completion(.success(safeUser))
                    }
                }
        }
    }
    
    
    /// adding new user to database
    /// - Parameters:
    ///   - docId: user id
    ///   - userData: user data
    ///   - returns: Void
    func addUser(docId:String , userData:User){
        do{
            try db.collection(collectionName).document(docId).setData(from: userData){ error in
                if let error = error{
                    fatalError(error.localizedDescription)
                    
                }
                
            }
            
        }catch {
            // display alert instead
            fatalError(error.localizedDescription)
        }
    }
    
    
    /// updating user information
    /// - Parameters:
    ///   - userData: all user data
    ///   - completion: completion function
    ///    - returns  Void
    func updateUserData(userData:User , completion: @escaping (Result<Void , Error>)-> Void){
        if let userId = Auth.auth().currentUser?.uid{
            do{
                try db.collection(collectionName).document(userId).setData(from: userData , merge: true){ error in
                    if let error = error{
                        completion(.failure(error))
                        return
                    }
                    completion(.success( () ))
                    return
                }
                
            }catch{
                completion(.failure(error))
                return
            }
        }
    }
    
    func deleteUserData(){ }
}

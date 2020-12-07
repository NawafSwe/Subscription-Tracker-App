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
    
    
    init(){ self.loadUserData(){ _  in } }
    
    // loading user data from firestore
    func loadUserData(completion: @escaping (Result<User, Error>)-> Void ){
        if let userId = Auth.auth().currentUser?.uid{
            db.collection(collectionName).document(userId)
                .addSnapshotListener { (documentSnapshot, error) in
                    if let error = error{
                        print(error)
                        
                    }
                    if let safeDoc = documentSnapshot{
                        guard let safeUser = try? safeDoc.data(as: User.self)else{
                            completion(.failure(error!))
                            return
                            
                        }
                        completion(.success(safeUser))
                    }
                }
        }
    }
}


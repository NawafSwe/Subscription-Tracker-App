//
//  ProviderRepository.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 01/12/2020.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import Combine
final class ProviderRepository:ObservableObject{
    @Published var providers = [Provider]()
    private let db = Firestore.firestore()
    private let collectionName = FirestoreKeys.collections.providers.rawValue
    
    
    init(){ self.loadData() }
    
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid{
            self.db.collection(collectionName)
                .order(by: "createdTime")
                .whereField("userId", isEqualTo: userId)
                .addSnapshotListener { (querySnapshot, error) in
                    if let error = error {
                        fatalError("Error in your network I will customize them for sure \(error.localizedDescription)" )
                        
                    }
                    if let querySnapshot = querySnapshot {
                        self.providers =  querySnapshot.documents.compactMap{ document in
                            try? document.data(as: Provider.self)
                        }
                    }
                    
                }
        }
    }
    func addProvider(provider:Provider){
        if let userId = Auth.auth().currentUser?.uid{
            let providerHelper = Provider(id: provider.id, createdTime: provider.createdTime, userId: userId, name: provider.name, image: provider.image)
            do{
                let _  =  try self.db.collection(collectionName).addDocument(from: providerHelper){error in
                    if let error = error {
                        print(error)
                        return
                    }
                }
            }catch {
                fatalError("cannot add provider \(error.localizedDescription)")
            }
        }
    }
    
    func deleteProvider(docId: String){
        if let _ = Auth.auth().currentUser?.uid{
            db.collection(collectionName)
                .document(docId)
                .delete() { error in
                    if let error = error {
                        print(error)
                    }
                }
        }
    }
}


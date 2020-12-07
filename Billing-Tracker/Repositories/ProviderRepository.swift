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
    private let collectionName = FirestoreKeys.Collections.providers.rawValue
    private let storage = Storage.storage()
    @Published var originalProviders = [Provider]()
    
    
    init(){
        self.loadData()
        self.getOriginalProviders(){_ in}
        
    }
    
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid{
            self.db.collection(collectionName)
                .order(by: "createdTime")
                .whereField("userId", isEqualTo: userId)
                .whereField("deleted", isEqualTo: false)
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
    /// add provider
    func addProvider(provider:Provider , completion: @escaping (Result <Void, Error>) -> Void){
        if let userId = Auth.auth().currentUser?.uid{
            let providerHelper = Provider(id: provider.id, createdTime: provider.createdTime, userId: userId, name: provider.name, image: provider.image , original:provider.original , deleted: provider.deleted)
            do{
                let _  =  try self.db.collection(collectionName).addDocument(from: providerHelper){error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success( () ))
                    return
                }
            }catch {
                
                completion(.failure(error))
                
            }
        }
    }
    
    /// delete provider
    func deleteProvider(docId: String , completion: @escaping (Result <Void, Error> ) -> Void)  {
        if let _ = Auth.auth().currentUser?.uid{
            db.collection(collectionName)
                .document(docId)
                //changing state to deleted
                .setData(["deleted": true]  , merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                        return 
                    }
                    completion(.success( () ))
                    return
                }
        }
        
    }
    // getting providers given by the developer
    func getOriginalProviders(completion: @escaping(Result< [Provider] , Error >  ) -> Void ){
        if let userId  = Auth.auth().currentUser?.uid{
            db.collection(collectionName)
                .whereField("userId", isEqualTo: userId)
                .whereField("original", isEqualTo: true)
                .addSnapshotListener { (querySnapshot, error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    if let documents = querySnapshot?.documents{
                        self.originalProviders =  documents.compactMap{ provider in
                            try? provider.data(as: Provider.self)
                            
                        }
                    }
                }
        }
    }
    
    func addOriginalProvider(docId:String , completion: @escaping (Result <Void , Error> )-> Void){
        if let _ = Auth.auth().currentUser?.uid{
            db.collection(collectionName)
                .document(docId)
                //changing state to deleted
                .setData(["deleted": false]  , merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    completion(.success( () ))
                    return
                }
        }
    }
    // upload images
    func uploadImage(image:UIImage, providerName: String , completion: @escaping (Result<URL?,Error>)->Void){
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let ref = self.storage.reference()
        let child  = ref.child("/providers/\(providerName)")
        child.putData(imageData, metadata: nil) { (meta, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            ref.downloadURL { (url, err) in
                if let err = err{
                    completion(.failure(err))
                    return
                }
                completion(.success(url))
                
            }
            
        }
    }
    
    
}
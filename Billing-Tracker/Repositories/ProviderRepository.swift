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
    
    //loading all user provider and original providers
    init(){
        self.loadData()
        self.getOriginalProviders(){_ in}
    }
    
    /// load data : loading all user  providers documents from firebase
    func loadData(){
        if let userId = Auth.auth().currentUser?.uid{
            self.db.collection(collectionName)
                .whereField("userId", isEqualTo: userId)
                .whereField("deleted", isEqualTo: false)
                .order(by: "createdTime")
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
    /// addProvider: adding new provider for the user
    /// - Parameters:
    ///   - provider: provider struct has all info about particular provider
    ///   - completion: function handler
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
    
    /// delete provider deleting user provider
    /// - Parameters:
    ///   - docId: document id
    ///   - completion: completion handler
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
    
    /// getting providers given by the developer
    /// - Parameter completion: function handler
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
    
    /// addOriginalProvider adding an original provider provided by the developer
    /// - Parameters:
    ///   - docId: document id
    ///   - completion: function handler
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
    /// uploading images to firebase
    /// - Parameters:
    ///   - image: UIimage to convert it into jpegData
    ///   - providerName: provider name to save the image by the provider name
    ///   - completion: function handler
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

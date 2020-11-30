//
//  ProvidersService.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import SwiftUI
import FirebaseStorage
import Firebase
import UIKit

enum ProvidersErr: String , Error {
    case noName = "Provider must have name"
    case noImage = "provider must have an image"
    
}

enum FireStorageErr:String,Error {
    case cannotUploadImage = "Cannot Upload Image"
}
//MARK:- ProvidersService singleton class
final class ProvidersService : ObservableObject{
    static let shared = ProvidersService()
    @Published var providers:[Provider] = []
    let fireStore = Firestore.firestore()
    let fireStorage = Storage.storage()
    
    init(){}
    
    
    /// getProvidersFromDB get all providers from db life data
    /// - Parameter completion: completion handler
    func getProvidersFromDB(completion: @escaping(Result<[Provider],Error>) ->Void){
        DispatchQueue.main.async {
            FireStoreService.shared.getDocuments(collection: FireStoreKeys.collections.providers, docId: UserAuthenticationManager.shared.user.uid){(result: Result<[Provider], Error>) in
                switch result{
                    case .success(let providers):
                        self.providers = providers
                    case .failure(let error):
                        completion(.failure(error))
                        return
                        
                }
            }
            
        }
        
    }
    
    
    /// addProvider adding provider to db
    /// - Parameters:
    ///   - provider: provider data
    ///   - completion: completion handler
    /// - Returns: @escaping function
    func addProvider(provider:Provider , completion:@escaping (Result<Void,Error>)->()){
        DispatchQueue.main.async {
            FireStoreService.shared.addDocument(collection: FireStoreKeys.collections.providers, model: provider) { result in
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
    
    
    /// saveProviderWithId save provider with id
    /// - Parameters:
    ///   - provider: provider data
    ///   - completion: completion handler
    /// - Returns: @escaping function
    func saveProviderWithId(provider:Provider , completion:@escaping (Result<Void,Error>)->()){
        DispatchQueue.main.async {
            FireStoreService.shared.saveDocumentWithId(collection: FireStoreKeys.collections.providers, docId: UserAuthenticationManager.shared.user.uid, model: provider) { (result: Result<Void, Error>) in
                switch result{
                    case .success():
                        completion(.success(()))
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                }
            }
        }
        
    }
    
    
    
    /// deleteProvider deleting provider by id
    /// - Parameter docId: document id
    func deleteProvider(docId: String){
        
    }
    
    
    /// uploadImage
    /// - Parameters:
    ///   - image: image of the provider
    ///   - providerName: provider name
    ///   - completion: completion handler
    func uploadImage(image:UIImage, providerName: String , completion: @escaping (Result<URL,Error>)->Void){
        /// converting image
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(FireStorageErr.cannotUploadImage))
            return
        }
        
        /// creating reference
        let ref = self.fireStorage.reference()
        let child  = ref.child("/providers/\(providerName)")
        child.putData(imageData, metadata: nil) { (meta, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            /// downloading the url image if was success
            ref.downloadURL { (url, err) in
                if let err = err{
                    completion(.failure(err))
                    return
                }
                
                guard let safeUrl = url else {
                    completion(.failure(FireStorageErr.cannotUploadImage))
                    return
                    
                }
                /// sending url back
                completion(.success(safeUrl))
                
            }
            
        }
    }
}



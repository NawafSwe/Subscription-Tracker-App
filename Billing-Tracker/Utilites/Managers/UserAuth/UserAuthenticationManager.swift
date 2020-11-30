//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
enum AuthenticationState { case signIn , signOut , null }
//MARK:- UserAuthenticationManager class for using firebase authentication services
final class UserAuthenticationManager : ObservableObject{
    @Published var session: User?
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user = User(uid: "", displayName: "nwawaf", email: "")
    @Published var authState:AuthenticationState = .null
    
    static let shared = UserAuthenticationManager()
    private init () {}
    
    /// start listing 
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.user = User(uid: user.uid, displayName: user.displayName, email: user.email)
                DispatchQueue.main.async {
                    self.authState = .signIn
                    
                }
                /// start retrieving user data
                DispatchQueue.main.async {
                    self.retrieveUser(uid: self.user.uid) { result in
                        switch result{
                            case .failure(_):
                                return
                            case .success(_):
                                return
                        }
                    }
                }
                
            } else {
                // if we don't have a user, set our session to nil
                
                self.session = nil
                DispatchQueue.main.async {
                    self.authState = .signOut
                }
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    
    func register(email:String , password:String , completion: @escaping (Result<Void,Error>)-> () ){
        
        Auth.auth().createUser(withEmail: email, password: password){  (authResult, error ) in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let _ = authResult?.user , let result = authResult  else{
                completion(.failure(error!))
                return
            }
            /// initing new user object from the authentication response if there is no error
            let user = User(uid: result.user.uid, displayName: result.user.displayName, email: result.user.email)
            DispatchQueue.main.async { self.user = user }
            FireStoreService.shared.saveDocumentWithId(collection: FireStoreKeys.collections.users, docId: user.uid, model: user,completion: {$0})
            
            
        }
    }
    
    func login(email:String , password:String , completion: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    func logout()->Bool{
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    
    
    /// stop listing
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    /// retrieving user info
    private func retrieveUser(uid: String, completion: @escaping (Result<Void, Error>) -> ()){
        FireStoreService.shared.getDocument(collection: FireStoreKeys.collections.users, docId: uid) { (result: Result<User, Error>) in
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let user):
                    DispatchQueue.main.async {
                        self.user = user
                        SubscriptionsService.shared.getSubscriptionsFromDB{ (result) in
                            switch result {
                                case .failure(let error):
                                    completion(.failure(error))
                                case .success(let subscriptions):
                                    print(subscriptions)
                                    completion(.success(()))
                            }
                        }
                    }
            }
        }
    }
}

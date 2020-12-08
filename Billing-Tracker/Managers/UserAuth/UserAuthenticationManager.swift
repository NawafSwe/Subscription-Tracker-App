//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit
enum AuthenticationState { case signIn , signOut , null }
enum userHolder  { static let dummyUser = User(uid: "" , displayName: "test" , email : "", age: "" , gender: "" , preferredProviderName: "" , preferredProviderImage: "" ) }

//MARK:- UserAuthenticationManager class for using firebase authentication services
final class UserAuthenticationManager : ObservableObject{
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user : User = userHolder.dummyUser
    @Published var authState:AuthenticationState = .null
    @Published var providersRepository = ProviderRepository()
    @Published var userRepository = UserRepository()
    static let shared = UserAuthenticationManager()
    private let db = Firestore.firestore()
    private init () { }

    /// start listing for user
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let _ = user {
                // if we have a user, create a new user model
                // check if I add some providers from the cloud
                    self.userRepository.loadUserData(){result in
                        switch result{
                            case .success(let user):
                                DispatchQueue.main.async {
                                    self.user = user
                                    self.authState = .signIn
                                }
                            case .failure(_):
                                return
                                
                        }
                }
            } else {
                // if we don't have a user, set our session to nil
                DispatchQueue.main.async {
                    
                    self.user =  userHolder.dummyUser
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
            let user = User(uid: result.user.uid, displayName: result.user.displayName, email: result.user.email , age: "" , gender: "" , preferredProviderName: "" , preferredProviderImage: "")
            
            
            DispatchQueue.main.async { self.user = user }
            ///initing user with initial providers
            let givenProviders:[Provider] = [
                .init(name: "Spotify", image: Images.Spotify ,original:true , deleted:false ),
                .init(name: "Netflix", image: Images.Netflix ,original:true , deleted:false ),
                .init(name: "Youtube", image: Images.Youtube ,original:true , deleted:false ),
                .init(name: "iCloud", image: Images.iCloud ,original:true , deleted:false ),
                .init(name: "Amazon", image: Images.amazon ,original:true , deleted:false ),
                .init( name: "Apple Music", image: Images.appleMusic ,original:true , deleted:false),
                .init( name: "Apple TV", image: Images.appleTv ,original:true , deleted:false) ,
                .init(name: "Uber", image: Images.uber ,original:true , deleted:false) ]
            
            for givenProvider in givenProviders{ self.providersRepository.addProvider(provider: givenProvider){_  in} }
            
            
            do{
                let _ = try self.db.collection(FirestoreKeys.Collections.users.rawValue).document(user.uid).setData(from: user)
                completion(.success( () ))
                return
                
                
            }catch {
                completion(.failure(error))
                return
            }
        }
    }
    /// login function
    func login(email:String , password:String , completion: @escaping (Result<Void,Error> ) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult , error) in
            if let error = error{
                completion(.failure(error))
                return
            }
            if let _ = authResult?.user {
                // getting user repo
                // then set the info
                self.userRepository.loadUserData(){result in
                    switch result{
                        case .success(let user):
                            DispatchQueue.main.async {
                                self.user = user
                                self.authState = .signIn
                            }
                        case .failure(let error):
                            completion(.failure(error))
                            
                    }
                }
                completion(.success(( )))
            }
        }
        
    }
    
    /// logout function
    func logout()->Bool{
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user =  userHolder.dummyUser
                self.authState = .signOut
            }
            //stop listing
            self.unbind()
            print("listing removed")
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
    private func retrieveUser(uid: String, completion: @escaping (Result<Void, Error>) -> ()){ }
    
}

//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
enum AuthenticationState { case signIn , signOut , null }
enum userHolder  { static let dummyUser = User(uid: "" , displayName: "test" , email : "") }

//MARK:- UserAuthenticationManager class for using firebase authentication services
final class UserAuthenticationManager : ObservableObject{
    var handle: AuthStateDidChangeListenerHandle?
    @Published var user : User = userHolder.dummyUser
    @Published var authState:AuthenticationState = .null
    static let shared = UserAuthenticationManager()
    let db = Firestore.firestore()
    private init () {}
    
    /// start listing for user
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = user {
                // if we have a user, create a new user model
                DispatchQueue.main.async {
                    self.user = User(uid: user.uid, displayName: user.displayName, email: user.email)
                    self.authState = .signIn
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
            let user = User(uid: result.user.uid, displayName: result.user.displayName, email: result.user.email)
            DispatchQueue.main.async { self.user = user }
            do{
                let _ = try self.db.collection(FirestoreKeys.collections.users.rawValue).document(user.uid).setData(from: user)
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
            if let user = authResult?.user {
                let safeUser =  User(uid: user.uid, displayName: user.displayName, email: user.email)
                DispatchQueue.main.async {
                    self.user  = safeUser
                    self.authState = .signIn
                }
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



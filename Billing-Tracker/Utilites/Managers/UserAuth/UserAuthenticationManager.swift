//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase
enum AuthenticationState {
    case signIn , signOut , null
}
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
                print("oh there is a user")
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
                DispatchQueue.main.async {
                    self.authState = .signIn
                }
                
            } else {
                // if we don't have a user, set our session to nil
                print("oh there are no user")
                self.session = nil
                DispatchQueue.main.async {
                    self.authState = .signOut
                }
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
    
    func register(email:String , password:String , completion: @escaping AuthDataResultCallback ){
        
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
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
    func retriveUser(uid:String , completion: @escaping (Result<User,Error>)->() ){ }
}

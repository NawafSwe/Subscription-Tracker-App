//
//  UserAuthentication.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import Firebase

/// using singleton class
//MARK:- UserAuthenticationManager class for using firebase authentication services
final class UserAuthenticationManager {
    static let shared = UserAuthenticationManager()
    
    private init(){ }
    
    
    func register(email:String , password:String){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                print(err)
                return
            }
            if let safeAuth = authResult{
                print(safeAuth)
            }
        }
        
    }
    
    
    func login(email:String , password:String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // ...
            if let user =  authResult?.user{
                /// get user data or init user defaults
                
            }
        }
    }
}

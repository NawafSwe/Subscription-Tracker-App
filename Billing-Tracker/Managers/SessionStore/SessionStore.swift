//
//  SessionStore.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//


import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
               self.session = User( id: user.uid, displayName: user.displayName
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    // additional methods (sign up, sign in) will go here
}

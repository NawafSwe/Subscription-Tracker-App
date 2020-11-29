//
//  RegisterViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import SwiftUI
final class  RegisterViewModel:ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var alertItem:AlertItem? = nil
    @ObservedObject var shared = UserAuthenticationManager.shared
    
    /// registre func
    func register(email:String, password:String){
        DispatchQueue.main.async {
            self.shared.register(email: email, password: password) { (authResult, error) in
                if let err = error{
                    self.alertItem = AlertItem(title: Text("Authentication Error"), message: Text(err.localizedDescription), dismissButton: .default(Text("OK")))
                }
                if let user = authResult?.user{
                    DispatchQueue.main.async {
                        self.shared.authState = .signIn
                        self.shared.user = User(uid: user.uid, displayName: user.displayName, email: user.email)
                    }
                }
            }
        }
        
    }
    
    func login(email:String, password:String){
        print("login hit")
    }
}

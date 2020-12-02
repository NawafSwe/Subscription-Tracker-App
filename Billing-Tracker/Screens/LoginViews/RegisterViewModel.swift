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
    @Published var isLoading = false
    @Published var isNewUser = false
    private var shared = UserAuthenticationManager.shared
    // registre func
    func register(email:String, password:String){
        DispatchQueue.main.async {
            self.isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.shared.register(email: email, password: password) { result in
                switch result{
                    case .failure(let err):
                        self.isLoading = false
                        self.alertItem = AlertItem(title: Text("Authentication Error"), message: Text(err.localizedDescription), dismissButton: .default(Text("OK")))
                    case .success(_):
                        self.shared.authState = .signIn
                        self.isLoading = false
                        
                }
            }
        }
        
    }
    
    // login func
    func login(email:String, password:String){
        DispatchQueue.main.async {
            self.isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.shared.login(email: email, password: password) { result in
                switch result{
                    case .failure(let err):
                        self.isLoading = false
                        self.alertItem = AlertItem(title: Text("Authentication Error"), message: Text(err.localizedDescription), dismissButton: .default(Text("OK")))
                    case .success(_):
                        self.shared.authState = .signIn
                        self.isLoading = false
                        
                }
            }
        }
    }
}

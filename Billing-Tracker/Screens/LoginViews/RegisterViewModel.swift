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
    @Published var isLoading = false
    @Published var isNewUser = false
 
    
    // registre func
    func register(email:String, password:String){
        DispatchQueue.main.async {
            self.isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.isLoading = false
            self.shared.register(email: email, password: password) { result in
                switch result{
                    case .failure(let err):
                        
                        self.alertItem = AlertItem(title: Text("Authentication Error"), message: Text(err.localizedDescription), dismissButton: .default(Text("OK")))
                    case .success(_):
                        
                        self.shared.authState = .signIn
                        
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
            self.isLoading = false
            self.shared.login(email: email, password: password) { result in
                switch result{
                    case .failure(let error):
                        self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                    case .success(_):
                        return 
                }
            }
        }
    }
}

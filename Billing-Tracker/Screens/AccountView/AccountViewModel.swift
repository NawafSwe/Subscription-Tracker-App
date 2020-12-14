//
//  AccountViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import Foundation
import SwiftUI
import Firebase

final class AccountViewModel : ObservableObject{
    @Published var email:String
    @Published var preferredProviderName:String
    @Published var preferredProviderImage:String
    @Published var age:String
    @Published var gender:String
    @Published var username:String
    @Published var userRepository = UserRepository()
    @Published var alertItem:AlertItem? = nil
    @Published var currentPassword = ""
    @Published var reEnteredPassword = ""
    @Published var verifyReEnteredPassword = ""
    @Published var newEmail = ""
    @Published var password = ""
    @Published var showEmailBox = false
    @Published var showPasswordBox = false 
    init(email:String, preferredProviderName:String , preferredProviderImage:String, age:String,
         gender:String, username:String
    ){
        self.email = email
        self.preferredProviderName = preferredProviderName
        self.preferredProviderImage = preferredProviderImage
        self.age  = age
        self.gender  = gender
        self.username = username
    }
    
    func updateUserInfo(){
        if let currentUser = Auth.auth().currentUser {
            
            let userHelper = User(uid: currentUser.uid, displayName: "", email: self.email, age: self.age, gender: self.gender, preferredProviderName: self.preferredProviderName, preferredProviderImage: self.preferredProviderImage, username:self.username)
            userRepository.updateUserData(userData: userHelper){result in
                switch result{
                    case .success():
                        DispatchQueue.main.async {
                            self.alertItem = AlertItem(title: Text("Success"), message: Text("Successfully updated your data"), dismissButton: .default(Text("Cool")))
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.alertItem = AlertItem(title: Text("Fail"), message: Text("\(error.localizedDescription)"), dismissButton: .default(Text("OK")))
                        }
                }
            }
            
        }
    }
    
    
    func updateUserEmail(){
        if let currentUser = Auth.auth().currentUser{
            let credential = EmailAuthProvider.credential(withEmail: email, password: verifyReEnteredPassword)
            currentUser.reauthenticate(with: credential){
                user , error in
                if let error = error{
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Re-Authentication Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                    }
                    
                    return
                }
                
            }
            currentUser.updateEmail(to: self.newEmail) { error in
                if let error = error {
                    // give alert
                    DispatchQueue.main.async {
                        self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                        
                    }
                    return
                }
                
                self.email = self.newEmail
                
                //update user document
                
                let helperUser = User(uid: currentUser.uid, displayName: "" , email: currentUser.email, age: self.age, gender: self.gender, preferredProviderName: self.preferredProviderName, preferredProviderImage: self.preferredProviderImage, username: self.username)
                
                self.userRepository.updateUserData(userData: helperUser){result in
                    switch result{
                        case .success(_):
                            DispatchQueue.main.async {
                                self.alertItem = AlertItem(title: Text("Success"), message: Text("Successfully updated Your email"), dismissButton: .default(Text("OK")))
                            }
                            
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.alertItem = AlertItem(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                            }
                    }
                }
            }
        }
    }
    func updateUserPassword(){}
}







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
    @Published var displayName:String
    @Published var userRepository = UserRepository()
    @Published var alertItem:AlertItem? = nil
    @Published var currentPassword = "*********************************************************"
    @Published var reEnteredPassword = ""
    @Published var verifyReEnteredPassword = ""
    @Published var newEmail = ""
    @Published var password = ""
    @Published var showEmailBox = false
    init(email:String, preferredProviderName:String , preferredProviderImage:String, age:String,
         gender:String, displayName:String
    ){
        self.email = email
        self.preferredProviderName = preferredProviderName
        self.preferredProviderImage = preferredProviderImage
        self.age  = age
        self.gender  = gender
        self.displayName = displayName
    }
    
    func updateUserInfo(){
        if let currentUser = Auth.auth().currentUser {
            if currentUser.displayName != displayName{
                let changeRequest = currentUser.createProfileChangeRequest()
                changeRequest.displayName = self.displayName
                changeRequest.commitChanges { (error) in
                    if let error = error{
                        print("\(error)")
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
                
                let helperUser = User(uid: currentUser.uid, displayName: self.displayName, email: currentUser.email, age: self.age, gender: self.gender, preferredProviderName: self.preferredProviderName, preferredProviderImage: self.preferredProviderImage)
                    
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







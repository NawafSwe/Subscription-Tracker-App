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
        
        
        // Prompt the user to re-provide their sign-in credentials
        
        
        
        if let currentUser = Auth.auth().currentUser {
            
            // let creditnial = currentUser.refreshToken
            //            currentUser.reauthenticate(with: creditnial) { user,error  in
            //                              if let error = error {
            //                                // An error happened.
            //                              } else {
            //                                // User re-authenticated.
            //                              }
            //                            }
            
            let credential = EmailAuthProvider.credential(withEmail: email, password: "somePass")
            currentUser.reauthenticate(with: credential){
                user , error in
                if let error = error{
                    print(error.localizedDescription)
                }
                
                
            }
            
            if currentUser.email != self.email{
                currentUser.updateEmail(to: self.email) { error in
                    if let error = error {
                        // give alert
                        print(error)
                    }
                }
                
            }
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
    
}

//
//  AccountViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import Foundation
import SwiftUI

final class AccountViewModel : ObservableObject{
    @Published var email:String
    @Published var password = "**************************************************"
    @Published var preferredProviderName:String
    @Published var preferredProviderImage:String
    @Published var age:String
    @Published var gender:String
    @Published var displayName:String
    
    
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
    
    
}

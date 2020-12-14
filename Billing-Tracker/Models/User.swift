//
//  User.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
struct User: Codable{
    var uid: String
    var email: String?
    var displayName: String?
   
    var age:String
    var gender:String
    var preferredProviderName:String
    var preferredProviderImage:String
    var username:String
    init(uid: String, displayName: String?, email: String? , age:String , gender:String , preferredProviderName: String ,preferredProviderImage:String , username:String ) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.age = age
        self.gender  = gender
        self.preferredProviderName = preferredProviderName
        self.preferredProviderImage = preferredProviderImage
        self.username = username
    }
}

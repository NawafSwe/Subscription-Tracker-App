//
//  Constants.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
//MARK:- K struct holds constants values used across the app
struct K {
    /// developer account
    static let devAccount = URL(string:"https://twitter.com/Nawaf_B_910")!
}

/// firebase keys collections
struct FirestoreKeys{
    enum Collections:String {
        case users = "users"
        case providers = "providers"
        case subscriptions = "subscriptions"
        case givenProviders = "givenProviders"
    }
    
    enum HostedImages:String {
        case Netflix = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FNetflix.svg?alt=media&token=abb618f7-8d5a-4832-94ab-78351c25a875"
        
        case Spotify = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FSpotify.svg?alt=media&token=e96dbab2-bf3d-4ef5-ba5c-6a2d476f7ebb"
        
        case Youtube = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FYoutube.svg?alt=media&token=abc2ef7c-128a-45c6-a871-f7c0f3728808"
        case Uber = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FUber.svg?alt=media&token=953e6dfd-a20f-4f4d-bf85-8a308493dda3"
        
        case AppleIcloud = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FAppleIcloud.svg?alt=media&token=a682047b-0e5b-4eb9-ae18-1077e2a5ff0e"
        case AppleMusic = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FAppleMusic.svg?alt=media&token=f8bbbd25-3a94-4277-8fd4-216b57964ffb"
        
        case Amazon = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2Famazon.svg?alt=media&token=52aa0e98-1ebd-4d07-bea1-0200ac549f77"
        case AppleTv = "https://firebasestorage.googleapis.com/v0/b/billing-tracker-bfee4.appspot.com/o/providers%2FProviders%2FProviders%2FAppleTv.svg?alt=media&token=1a43108e-0cba-42d6-b455-5ad796886d42"
        
        
        
    }
}

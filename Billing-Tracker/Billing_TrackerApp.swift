//
//  Billing_TrackerApp.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI
import Firebase
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Billing-Tracker application is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
        /// if there is no user sign in as anonymous user
        //        if Auth.auth().currentUser == nil {
        //            Auth.auth().signInAnonymously()
        //        }
        return true
    }
}
@main
struct Billing_TrackerApp: App {
    
    
    /// using the core data across all the application
    /// let context = DataStore.shared.context
    /// configuring firebase app
    //    This approach works well for Firebase SDKs such as Cloud Firestore and Crashlytics.
    //    For other Firebase SDKs, such as Firebase Cloud Messaging, this is not sufficient, as they use method swizzling to hook into the  application life cycle. This mechanism allows frameworks to intercept calls to specific methods and handle them before passing the call on to your application.
    //    In this case, you need to use the @UIApplicationDelegateAdaptor property wrapper to connect your app to an instance of AppDelegate.
    init(){
        FirebaseApp.configure()
        /// making sure db is works fine
        
        
        
    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        //  let session = UserAuthenticationManager()
        WindowGroup {
            LandingView()
            // HomeTabView()
        }
        
    }
}

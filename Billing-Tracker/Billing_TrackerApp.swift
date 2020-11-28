//
//  Billing_TrackerApp.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

@main
struct Billing_TrackerApp: App {
    /// using the core data across all the application
    let context = DataStore.shared.context
    var body: some Scene {
        WindowGroup {
            HomeTabView().environment(\.managedObjectContext, context)
        }
    }
}

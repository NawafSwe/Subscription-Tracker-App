//
//  DataStore.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation

import Foundation
import CoreData
import SwiftUI
import UIKit
/// using singleton pattern
class DataStore: ObservableObject {
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    // One line singleton
    static let shared = DataStore()
    // Mark the class private so that it is only accessible through the singleton `shared` static property
    private init() {}
    private let persistentStoreName: String = "CoreDataModel"
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentStoreName)
        
        guard let persistentStoreDescriptions = container.persistentStoreDescriptions.first else {
            fatalError("\(#function): Failed to retrieve a persistent store description.")
        }
        persistentStoreDescriptions.setOption(true as NSNumber,
                                              forKey: NSPersistentHistoryTrackingKey)
        persistentStoreDescriptions.setOption(true as NSNumber,
                                              forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving and "other future" support (such as undo)
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                /// put alert here
                
            } catch _ {
                // Customize this code block to include application-specific recovery steps.
                /// put alert here
            }
        }
        
    }
}

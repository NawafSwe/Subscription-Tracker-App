//
//  Subscription.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import Foundation
import CoreData

//MARK:- struct Subscription
/// `Subscription` struct holds all the needed data for a `Subscription`
struct Subscription: Codable , Hashable , Identifiable {
    var id = UUID()
    var userId:String
    let name:String
    let image:String
    let description:String
    let dueDate:String
    let price:Double
    
}
//MARK:- Extension Subscription CoreData to swift struct
extension Subscription{
    /// going from core data to struct
    init(managedSubscription: NSManagedObject){
        self.userId = managedSubscription.value(forKey: "userId") as! String
        self.name = managedSubscription.value(forKey: "name") as! String
        self.image = managedSubscription.value(forKey: "image") as! String
        self.description = managedSubscription.value(forKey: "description") as! String
        self.dueDate = managedSubscription.value(forKey: "dueDate") as! String
        self.price = managedSubscription.value(forKey: "price") as! Double
    }
}

//MARK:- MocData struct 
struct MockData {
    static let subscriptionSample = Subscription(userId: "2", name: "Spotify", image: Images.Spotify, description: "Music", dueDate: "1 month", price: 100)
    
    static let subscriptionSampleList = [
        Subscription(userId:"21" , name: "Spotify", image: Images.Spotify, description: "Music", dueDate: "1 month", price: 100),
        Subscription(userId:"22" , name: "Netflix", image: Images.Netflix, description: "Films", dueDate: "1 month", price: 44),
        Subscription(userId:"23" , name: "Youtube", image: Images.Youtube, description: "Premium", dueDate: "1 month", price: 10.99),
        Subscription(userId:"24" , name: "iCloud", image: Images.iCloud, description: "Cloud Service", dueDate: "1 month", price: 10.99),

    ]
}

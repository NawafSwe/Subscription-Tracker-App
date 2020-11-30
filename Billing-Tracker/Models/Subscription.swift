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
    let dueDateString:String
    let price:Double
    let dueDateInDate : Date
}


//MARK:- MocData struct 
struct MockData {
//    static let subscriptionSample = Subscription(userId: "2", name: "Spotify", image: Images.Spotify, description: "Music", dueDate: "1 month", price: 100)
//
    static let subscriptionSampleList = [
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date()),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date()),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date()),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date())

    ]
    static let subscriptionSample = Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date())
    
}

//
//  Subscription.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK:- struct Subscription
/// `Subscription` struct holds all the needed data for a `Subscription`
struct Subscription: Codable ,Identifiable {
    // if document id exists
    @DocumentID var id : String?
    // timestamp from user side if not exit fill it with server timestamp
    @ServerTimestamp var createdTime: Timestamp?
    // user id 
    var userId:String?
    let name:String
    let image:String
    let description:String
    let dueDateString:String
    let price:Double
    let dueDateInDate : Date
    let cycleDays:String
    let notifyMe:Bool
    let expired:Bool
//    let notificationMessage:String?
    }


//MARK:- MocData struct
#if DEBUG
struct MockData {
    //    static let subscriptionSample = Subscription(userId: "2", name: "Spotify", image: Images.Spotify, description: "Music", dueDate: "1 month", price: 100)
    //
    static let subscriptionSampleList = [
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date(), cycleDays: "Weekly", notifyMe :false, expired: false ),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date() , cycleDays: "Weekly", notifyMe :false, expired: false),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date() , cycleDays: "Weekly", notifyMe :false, expired: false),
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date() , cycleDays: "Weekly", notifyMe :false, expired: false)
    ]
    static let subscriptionSample = Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date(),
                                                 cycleDays: "Weekly", notifyMe :false, expired: false )
    
}
#endif

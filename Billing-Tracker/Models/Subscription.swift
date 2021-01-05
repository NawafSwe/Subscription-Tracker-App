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
    var name:String
    var image:String
    var description:String
    var dueDateString:String
    var price:Double
    var dueDateInDate : Date
    var cycleDays:String
    var notifyMe:Bool
    var expired:Bool
    var priceString:String
    var notificationMessage:String
    var cycleIndex:Int
    var notificationId:String
}


//MARK:- MocData struct
#if DEBUG
struct MockData {
    //    static let subscriptionSample = Subscription(userId: "2", name: "Spotify", image: Images.Spotify, description: "Music", dueDate: "1 month", price: 100)
    //
    static let subscriptionSampleList = [
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date(), cycleDays: "Weekly", notifyMe :false, expired: false, priceString: "34" , notificationMessage : "notificationMessage", cycleIndex: 0 , notificationId: ""  )]
    static let subscriptionSample =
        Subscription(userId: "32", name: "Spotify" , image: Images.Spotify, description: "Music", dueDateString: "1 month", price: 100, dueDateInDate: Date(), cycleDays: "Weekly", notifyMe :false, expired: false, priceString: "34" , notificationMessage : "notificationMessage", cycleIndex: 0 , notificationId: ""  )
               
               }
#endif

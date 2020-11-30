//
//  Provider.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
struct Provider : Codable , Identifiable{
    var id = UUID()
    var userId : String
    var name:String
    var image:String
}

struct Providers{
    static let providersList = [
        Provider(userId:"203",name: "Spotify", image: Images.Spotify),
        Provider(userId:"203" , name: "Netflix", image: Images.Netflix),
        Provider(userId:"203" , name: "Youtube", image: Images.Youtube),
        Provider(userId:"203", name: "iCloud", image: Images.iCloud),
        Provider(userId: "203", name: "Amazon", image: Images.amazon),
        Provider(userId: "203", name: "Apple Music", image: Images.appleMusic),
        Provider(userId: "203", name: "Apple TV", image: Images.appleTv),
        ]
    
    
    
}


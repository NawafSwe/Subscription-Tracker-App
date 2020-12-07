//
//  Provider.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Provider : Codable , Identifiable{
    @DocumentID var id:String?
    @ServerTimestamp var createdTime: Timestamp?
    var userId : String?
    var name:String
    var image:String
    var original:Bool
    var deleted:Bool
}


#if DEBUG
struct Providers{
    static let providersList = [
        Provider(name: "Spotify", image: Images.Spotify ,original:true , deleted:false),
        Provider(name: "Netflix", image: Images.Netflix ,original:true , deleted:false),
        Provider(name: "Youtube", image: Images.Youtube ,original:true , deleted:false),
        Provider(name: "iCloud", image: Images.iCloud   ,original:true , deleted:false),
        Provider(name: "Amazon", image: Images.amazon   ,original:true , deleted:false),
        Provider( name: "Apple Music", image: Images.appleMusic ,original:true , deleted:false),
        Provider( name: "Apple TV", image: Images.appleTv ,original:true , deleted:false),
    ]
}
#endif


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
}


#if DEBUG
struct Providers{
    static let providersList = [
        Provider(name: "Spotify", image: Images.Spotify),
        Provider(name: "Netflix", image: Images.Netflix),
        Provider(name: "Youtube", image: Images.Youtube),
        Provider(name: "iCloud", image: Images.iCloud ),
        Provider(name: "Amazon", image: Images.amazon ),
        Provider( name: "Apple Music", image: Images.appleMusic),
        Provider( name: "Apple TV", image: Images.appleTv),
        ]
    }
#endif


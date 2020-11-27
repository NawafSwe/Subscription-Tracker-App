//
//  Provider.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import Foundation
struct Provider :Identifiable{
    var id = UUID()
    var name:String
    var image:String 
}

struct Providers{
    static let providersList = [
        Provider(name: "Spotify", image: Images.Spotify),
        Provider(name: "Netflix", image: Images.Netflix),
        Provider(name: "Youtube", image: Images.Youtube),
        Provider(name: "iCloud", image: Images.iCloud) ]
    }

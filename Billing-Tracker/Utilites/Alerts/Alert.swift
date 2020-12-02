//
//  Alert.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import SwiftUI
struct AlertItem :Identifiable{
    var id = UUID()
    let title:Text
    let message: Text
    let dismissButton: Alert.Button
    
}

//
//  SettingViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import SwiftUI
final class SettingViewModel:ObservableObject{
    
    @Published var alertItem : AlertItem? = nil
    @ObservedObject var session  = UserAuthenticationManager.shared
    func logout(){
        if  !session.logout(){
            self.alertItem = AlertItem(title: Text("Logout Error"), message: Text("Cannot logout at this time"), dismissButton: .default(Text("OK")))
            return
            
        }
        return
    }
}


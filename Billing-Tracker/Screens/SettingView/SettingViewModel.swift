//
//  SettingViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import Foundation
import SwiftUI
final class SettingViewModel:ObservableObject{
    @Published var showManagedSubscriptions = false 
    @Published var alertItem : AlertItem? = nil
    @ObservedObject var session  = UserAuthenticationManager.shared
    @Published var isLoading = false
    func logout(){
        self.isLoading = true 
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            if  !self.session.logout(){
                self.alertItem = AlertItem(title: Text("Logout Error"), message: Text("Cannot logout at this time"), dismissButton: .default(Text("OK")))
                self.isLoading = false
                return
                
            }
            self.isLoading = false
            return
        }
        
    }
}


//
//  UserServices.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import Foundation
import SwiftUI


final class UserServices:ObservableObject{
    @Published var user:User
    init(user:User){
        self.user = user
    }
}

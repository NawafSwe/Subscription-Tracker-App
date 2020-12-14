//
//  UserServices.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import Foundation
import SwiftUI
import Combine

final class UserServices:ObservableObject{
    @Published var user:User
    @Published var userRepository = UserRepository()
    @Published var cancallebles =  Set<AnyCancellable>()
    init(user:User){
        self.user = user
//        self.userRepository
//            .$user
//            .sink{ user in
//                self.user = user
//            }
//            .store(in: &cancallebles)
        
    }
}

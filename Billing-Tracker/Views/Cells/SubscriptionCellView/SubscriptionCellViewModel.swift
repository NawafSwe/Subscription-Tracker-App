//
//  SubscriptionCellViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 01/12/2020.
//

import Foundation
import SwiftUI
import Combine
import Firebase

final class SubscriptionCellViewModel : ObservableObject , Identifiable{
    // published subscription
    @Published var subscription : Subscription
    @Published var subscriptionRepository = SubscriptionRepository()
    // for storage
    private var cancellables  = Set<AnyCancellable>()
    var id :String  = ""
    var userId = Auth.auth().currentUser?.uid
    
    /// mapping the subscription
    init (subscription : Subscription) {
        // initing the cell with the new subscription
        self.subscription = subscription
        
        // now let listen for the repo changes
        // when $ sign proceed a published var from else where means listen to any changes and keep me updated
        // saving the doc id into id field , using compact map because we have string of optional
        $subscription
            .compactMap{ subscription in
                subscription.id
            }
            // assign it to id
            .assign(to: \.id , on: self)
            // storing it
            .store(in: &cancellables)
        
        }
}




//// anytime we update task
//$subscription
//    /// if we do the update , which means not the user then drop first change
//    .dropFirst()
//    /// using debounce to not make update every type change so will be to much on fire store so will updates when user stop typing
//    .debounce(for: 0.8, scheduler: RunLoop.main)
//    .sink{ task in
//        self.tasksRepository.updateTask(task)
//    }
//    // for storage
//    .store(in: &cancellables)
//}

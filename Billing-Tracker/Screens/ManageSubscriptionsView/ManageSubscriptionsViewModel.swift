//
//  ManageSubscriptionsViewModel.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import Foundation
import SwiftUI
final class ManageSubscriptionsViewModel : ObservableObject{
    @Published var subscriptions = SubscriptionsService.shared.subscriptions
    @Published var alertItem: AlertItem? = nil
    @Published var selectedSubIndex = 0
    
    
    func deleteSubscription(indices: IndexSet){
        var docId:UUID? = nil
        for indice in indices {
            // find this sub
            let subscription = subscriptions[indice]
            docId = subscription.id
        }
        subscriptions.remove(atOffsets: indices)
        guard let foundDocId = docId else {return }
        /// [self] closure syntax 
        SubscriptionsService.shared.deleteSubscription(docId: foundDocId.uuidString) { [self] result in
            switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        alertItem = AlertItem(title: Text("Error while deleting"), message:Text(error.localizedDescription) , dismissButton: .default(Text("OK")))
                    }
                    return
                case .success(_):
                    print("deleted")
                    return
            }
        }
    }
    
}

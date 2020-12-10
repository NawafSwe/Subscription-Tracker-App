//
//  SubscriptionTimeLeftView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionTimingsView: View {
    @StateObject var viewModel = SubscriptionTimingsViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: self.viewModel.columns){
                        ForEach(viewModel.subscriptions){sub in
                            // injecting the subscription cell view model
                            SubscriptionBoxView(subscription: sub.subscription , remindDays: Date.daysDiffrent(start: Date(), end: sub.subscription.dueDateInDate) )
                                
                        }
                    }
                    .padding(.top)
                }
                
                .navigationTitle("Subscriptions Timings⌚️")
                .navigationBarTitleDisplayMode(.inline)
            }
            .alert(item: $viewModel.alertItem){alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            
            /// if subscriptions list  empty show empty state
            if viewModel.subscriptions.isEmpty{
                EmptySubscriptionView(imageName: Images.emptySubscription, text: "Your Subscription List Is Empty Please Add One to show your subscriptions ⌚️.")
            }
        }
    }
}

struct SubscriptionTimingsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTimingsView()
    }
}



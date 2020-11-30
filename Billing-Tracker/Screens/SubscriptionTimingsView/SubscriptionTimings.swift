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
        NavigationView {
            ScrollView {
                LazyVGrid(columns: self.viewModel.columns){
                    ForEach(viewModel.subscriptions){sub in
                        SubscriptionBoxView(subscription: sub , remindDays: Date.daysDiffrent(start: Date(), end: sub.dueDateInDate) )
                    }
                }
                
                .padding(.top)
                
                .navigationTitle("Subscriptions Timings⌚️")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .alert(item: $viewModel.alertItem){alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
        
        .onAppear(perform:viewModel.getSubscriptions)
    }
}

struct SubscriptionTimingsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTimingsView()
    }
}



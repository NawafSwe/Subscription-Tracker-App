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
                        SubscriptionBoxView(subscription: sub, totalDays: 365, remindDays: 30)
                        
                    }
                }
                .padding(.top)
                
                .navigationTitle("Subscriptions Timings⌚️")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .onAppear(perform: viewModel.getSubscriptions)
        .alert(item: $viewModel.alertItem){alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
    }
}

struct SubscriptionTimingsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTimingsView()
    }
}

//
//  SubscriptionTimeLeftView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionTimingsView: View {
    //creating lazy grid , flexible telling him fill the size of the screen as much as you can
    //each gridItem inside the grid item array represents number of columns
    let columns : [GridItem] = [ GridItem(.flexible()) ,GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns:self.columns){
                    ForEach(MockData.subscriptionSampleList){sub in
                        SubscriptionBoxView()
                        
                    }
                }
                .padding(.top)
                
                .navigationTitle("Subscriptions Timings⌚️")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

struct SubscriptionTimingsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionTimingsView()
    }
}

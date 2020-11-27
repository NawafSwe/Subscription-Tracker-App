//
//  SubscriptionListView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionListView: View {
    let subscriptionsList = MockData.subscriptionSampleList
    var body: some View {
        NavigationView {
            ZStack{
                List(subscriptionsList){ sub in
                    
                    SubscriptionCellView(image:sub.image, name:sub.name, price: sub.price, dueDate: sub.dueDate)
                        .padding(.horizontal,-20)
                }
                .listStyle(PlainListStyle())
            }
            
            .navigationBarItems(leading: Button(action: {}, label: {
                AddSubscriptionButtonView()
            }))
            .navigationTitle("Subscriptions 💳")
        }
    }
}

struct SubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListView()
    }
}

struct AddSubscriptionButtonView:View{
    var body: some View{
        Image(systemName: "bag.badge.plus")
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
            .accentColor(.green)
    }
}

//
//  SubscriptionListView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionListView: View {
    var body: some View {
        NavigationView {
            ZStack{
                List(0..<5){ sub in
                    
                    SubscriptionCellView(image:"Netflix",name:"Netflix",price: 43, dueDate: "2 weeks")
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

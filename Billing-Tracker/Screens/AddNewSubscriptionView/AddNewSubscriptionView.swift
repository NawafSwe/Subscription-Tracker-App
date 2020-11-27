//
//  AddNewSubscriptionView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct AddNewSubscriptionView:View{
    var body: some View{
        NavigationView {
            SubscriptionFormView()
                .navigationTitle("New Subscription 💳")
        }
    }
}
struct AddNewSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSubscriptionView()
    }
}

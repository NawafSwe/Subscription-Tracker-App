//
//  AddSubscriptionButtonView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import SwiftUI

struct AddSubscriptionButtonView:View{
    var body: some View{
        Image(systemName: Icons.SFbag)
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
            .accentColor(.blue)
    }
}

struct AddSubscriptionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionButtonView()
    }
}

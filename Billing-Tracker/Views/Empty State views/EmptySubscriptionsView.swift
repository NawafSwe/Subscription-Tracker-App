//
//  EmptySubscriptionsView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct EmptySubscriptionsView: View {
    var body: some View {
        ZStack{
            VStack {
                Image("blogging-site-concept")
                .resizable()
                .imageScale(.large)
                .frame(width: 320, height: 400, alignment: .center)
                .padding()
                    .offset(y: 10)
                
                Text("Your Subscription List Is Empty Please Add One to show your subscriptions ⌚️.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.standardText)
                    .font(.body)
                    .padding()
                    .padding(.top,20)
            }
        }
    }
}
struct EmptySubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySubscriptionsView()
    }
}

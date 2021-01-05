//
//  EmptySubscriptionView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct EmptySubscriptionView: View {
    let imageName: String
    let text:String
    var body: some View {
        ZStack{
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 380, height: 300, alignment: .center)
                    .offset(y: 10)
                
                Text(text)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.standardText)
                    .font(.body)
                    .padding()
                    .padding(.top,10)
            }
        }
    }
}
struct EmptySubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySubscriptionView(imageName: "people-discussing-about-business-in-park", text: "Your Subscription List Is Empty Please Add One to show your subscriptions ⌚️.")
    }
}

//
//  SubscriptionBoxView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI

struct SubscriptionBoxView: View {
    let subscription : Subscription
    let remindDays :Int
    var body: some View {
        VStack(alignment: .center,spacing: 30){
            HStack (spacing:10){
                Image(subscription.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35 , height: 35)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 30), style: .continuous))
                Text(subscription.name)
                    .font(.body)
                    .bold()
                Spacer()
            }
            HStack(spacing: 10 ){
                DaysRingView(color1: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), width: 33, height: 33, reminderDays: CGFloat(remindDays))
                
                Text("Days left")
                    .font(.headline)
                Spacer()
                
            }
            
        }
        .padding(.horizontal)
        .frame(width: 200, height: 120, alignment: .center)
        .background(Color.backgroundCell)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 20), style: .continuous))
        .shadow(radius: 2)
        
        
    }
}

struct SubscriptionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionBoxView(subscription: MockData.subscriptionSample , remindDays: 200)
    }
}

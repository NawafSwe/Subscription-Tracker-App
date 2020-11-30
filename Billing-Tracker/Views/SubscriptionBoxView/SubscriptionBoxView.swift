//
//  SubscriptionBoxView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI

struct SubscriptionBoxView: View {
    let subscription : Subscription
    let totalDays : Int
    let remindDays :Int
    var body: some View {
        VStack(alignment: .center,spacing: 30){
            HStack (spacing:10){
                Image(subscription.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40 , height: 40)
                Text(subscription.name)
                    .font(.title3)
                    .bold()
            }
            HStack(spacing: 10 ){
                DaysRingView(color1: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), width: 33, height: 33, reminderDays: 50, totalDays:100 )
                
                Text("Days left")
                    .font(.headline)
                
            }
            
        }
        
        .frame(width: 170, height: 120, alignment: .center)
        .background(Color.backgroundCell)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous))
        .shadow(radius: 2)
        .padding()
        
    }
}

struct SubscriptionBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionBoxView(subscription: MockData.subscriptionSample, totalDays: 10, remindDays: 200)
    }
}

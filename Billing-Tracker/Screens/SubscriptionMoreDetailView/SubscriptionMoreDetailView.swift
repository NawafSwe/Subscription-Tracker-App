//
//  SubscriptionMoreDetailView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 05/12/2020.
//

import SwiftUI

struct SubscriptionMoreDetailView: View {
    let subscription: Subscription
    var body: some View {
        
        VStack {
            Spacer()
                
            VStack(alignment:.leading){
                HStack {
                    
                    VStack(alignment:.leading) {
                        HStack (spacing:10){
                            Text(subscription.name)
                                .font(.title3)
                                
                               
                            
                            Image(subscription.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35 , height: 35)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 30), style: .continuous))
                               
                        }
                        .padding(.horizontal)
                        Text(" \(  String(format: "%.2f", subscription.price)   )  SR")
                            .font(.body)
                            .bold()
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    HStack {
                        DaysRingView(width: 50, height: 50, reminderDays: CGFloat(Date.daysDiffrent(start: Date(), end: subscription.dueDateInDate)))
                        Text("Days Left")
                            .bold()
                            .padding()
                        
                    }
                    
                }
                Divider()
                HStack {
                    Text("Description:")
                    Spacer()
                    Text("\(subscription.description)")
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                HStack {
                    Text("Billing:")
                    Spacer()
                    Text("\(subscription.dueDateString)")
                }
                .padding()
                
                HStack {
                    Text("Billing cycle:")
                    Spacer()
                    Text("\(subscription.cycleDays)")
                }
                .padding()
                
                HStack {
                    Text("Reminder:")
                    Spacer()
                    Text(subscription.notifyMe ? "Yes" : "No" )
                }
                .padding()
               
                Spacer()
            }
            .padding()
            .frame(width: 400, height: 400, alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(radius: 4)
           
        }
    }
}

struct SubscriptionMoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionMoreDetailView(subscription: MockData.subscriptionSample)
    }
}

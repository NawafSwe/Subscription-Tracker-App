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
                                .font(.subheadline)
                                .bold()
                            Image(subscription.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35 , height: 35)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 30), style: .continuous))
                            
                        }
                        
                        Text(" \(  String(format: "%.2f", subscription.price)   )  SR")
                            .font(.body)
                            .bold()
                            .padding(.trailing)
                    }.padding()
                    
                    Spacer()
                    VStack {
                        Text("Days Left")
                            .font(.subheadline)
                            .bold()
                            .padding()
                        
                        DaysRingView(width: 40, height: 40, reminderDays: CGFloat(Date.daysDiffrent(start: Date(), end: subscription.dueDateInDate)))
                        
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
            .overlay(
                NotchBarView(width: 100, height: 10, cornerRadius: 3).padding(.vertical, -0.6), alignment: .top
            )
            
        }
    }
}
struct SubscriptionMoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionMoreDetailView(subscription: MockData.subscriptionSample)
    }
}

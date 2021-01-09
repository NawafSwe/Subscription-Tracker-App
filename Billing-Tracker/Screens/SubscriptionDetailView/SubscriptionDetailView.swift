//
//  SubscriptionDetailView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionDetailView: View {
    let subscription:Subscription
    @State var viewState:CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack(alignment: .center){
                BrandView(subscription: subscription)
                    .padding()
                
                Divider()
                    .frame(width: 320,height: 2)
                    .background(Color("DividerColor"))
                    .shadow(radius: 30)
                
                SubscriptionRowInfoView(name:"Name" , info: subscription.name)
                    .padding()
                SubscriptionRowInfoView(name:"Description" , info: subscription.description)
                    .padding()
                SubscriptionRowInfoView(name: "Bill Date", info: subscription.dueDateString)
                    .padding()
                SubscriptionRowInfoView(name: "Cycle", info: subscription.cycleDays)
                    .padding()
                SubscriptionRowInfoView(name: "Reminder", info: subscription.notifyMe ? "Yes" : "Never")
                    .padding()
                
            }
            .padding()
            .frame(width: 340,height: 420)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 4)
            
        }
    }
}
struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionDetailView(subscription: MockData.subscriptionSample)
    }
}
// MARK:- SubscriptionRowInfoView
/// SubscriptionRowInfoView shows the info about the subscription row
struct SubscriptionRowInfoView:View{
    let name: String
    let info :String
    var body: some View{
        HStack{
            Text(name)
                .font(.body)
            Spacer()
            Text(info)
                .font(.body)
                .foregroundColor(.secondary)
            
        }
    }
}




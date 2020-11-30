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
            VStack{
                BrandView(image:subscription.image ,name: subscription.name, price: subscription.price, dueDate: subscription.dueDateString)
                    .padding()
                
                Divider()
                    .frame(height: 2)
                    .background(Color("DividerColor"))
                    .shadow(radius: 30)
                
                SubscriptionRowInfoView(name:"Name" , info: subscription.name)
                SubscriptionRowInfoView(name:"Description" , info: "Some info about me and so ")
                SubscriptionRowInfoView(name: "Bill Date", info: "April 2 2202")
                SubscriptionRowInfoView(name: "Cycle", info: "Every Month")
                SubscriptionRowInfoView(name: "Reminder", info: "Never")
                    
                
                
            }
            .frame(width: 340,height: 420)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 4)
            .padding()
        }
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionDetailView(subscription: MockData.subscriptionSample)
    }
}

struct SubscriptionRowInfoView:View{
    let name: String
    let info :String
    var body: some View{
        VStack(alignment: .center){
            HStack{
                Text(name)
                    .font(.body)
                Spacer()
                Text(info)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}


 

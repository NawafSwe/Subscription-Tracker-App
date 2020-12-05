//
//  SubscriptionCellView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionCellView: View {
    @ObservedObject var subscription: SubscriptionServices
    
    var body: some View {
        HStack(alignment: .center){
            BrandView(subscription: subscription.subscription)
                
        }
        .frame(width: 320, height: 60)
        .background(Color("sub_cell_background"))
        .cornerRadius(10)
        .shadow(radius: 3)
        
        
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCellView(subscription: SubscriptionServices(subscription: MockData.subscriptionSample))
    }
}

struct BrandView:View{
    let subscription: Subscription
    var body: some View{
        HStack{
            Image(subscription.image)
                .resizable()
                .frame(width: 32 , height: 32)
                .scaledToFit()
            Text(subscription.name)
                .font(.title)
            
            Spacer()
            
            VStack{
                Text("SR \(String(format: "%.2f", subscription.price) )")
                    .font(.system(size: 16, weight: .medium))
                Text(subscription.dueDateString)
                    .font(.system(size: 16, weight: .thin, design: .default))
            }
        }
        .padding()
       
    }
}

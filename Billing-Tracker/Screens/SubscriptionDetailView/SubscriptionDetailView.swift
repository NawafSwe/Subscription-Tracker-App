//
//  SubscriptionDetailView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionDetailView: View {
    var body: some View {
        VStack{
            BrandView(image:"Netflix",name:"Netflix",price: 43, dueDate: "2 weeks")
                .padding()
            
            Divider()
                .frame(height: 2)
                .background(Color("DividerColor"))
                .shadow(radius: 30)
            
            SubscriptionRowInfoView(name:"Name" , info: "Netflix")
            SubscriptionRowInfoView(name:"Description" , info: "Netflix subscription")
            SubscriptionRowInfoView(name: "Bill Date", info: "April 2 20202")
            
            SubscriptionRowInfoView(name: "Cycle", info: "Every Month")
            
            SubscriptionRowInfoView(name: "Reminder", info: "Never")
            
            
        }
        .frame(width: 330,height: 390)
        .background(Color("sub_cell_background"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 10)
        .padding()
        
        
        
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionDetailView()
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

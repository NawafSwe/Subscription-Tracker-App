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
            /// card header
            HStack{
                Image("Netflix")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                
                Text("Netflix")
                    .font(.title)
                
                Spacer()
                VStack{
                    Text("SR43")
                        .font(.title2)
                        .font(.system(size: 16, weight: .medium))
                    Text("1 month")
                        .font(.system(size: 16, weight: .thin, design: .default))
                    
                    
                }
            }
            .padding()
            Divider()
                .frame(height: 2)
                .background(Color("DividerColor"))
                .shadow(radius: 30)
            
            InfoRow(name:"Name" , info: "Netflix")
            InfoRow(name:"Description" , info: "Netflix subscription")
            InfoRow(name: "Bill Date", info: "April 2 20202")
            
            InfoRow(name: "Cycle", info: "Every Month")
            
            InfoRow(name: "Reminder", info: "Never")
            
            
        }
        
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

struct InfoRow:View{
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


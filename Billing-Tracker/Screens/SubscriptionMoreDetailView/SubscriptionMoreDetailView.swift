//
//  SubscriptionMoreDetailView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 05/12/2020.
//

import SwiftUI

struct SubscriptionMoreDetailView: View {
    var body: some View {
        
        VStack {
            Spacer()
                
            VStack(alignment:.leading){
                HStack {
                    
                    VStack(alignment:.leading) {
                        HStack (spacing:10){
                            Text(Images.Netflix)
                                .font(.title)
                                .font(.body)
                            
                            Image(Images.Netflix)
                                .resizable()
                                .imageScale(.medium)
                                .frame(width: 25 , height : 25)
                            
                        }
                        .padding(.horizontal)
                        Text("Price:39")
                            .font(.body)
                            .bold()
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                    HStack {
                        DaysRingView(width: 50, height: 50, reminderDays: CGFloat(44))
                        Text("Days Left")
                            .bold()
                            .padding()
                        
                    }
                    .padding()
                    
                    
                }
                HStack {
                    Text("Description:")
                    Spacer()
                    Text("it is net flix services and so on")
                }
                .padding()
                
                HStack {
                    Text("Description:")
                    Spacer()
                    Text("it is net flix services and so on")
                }
                .padding()
                
                HStack {
                    Text("Description:")
                    Spacer()
                    Text("it is net flix services and so on")
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
        SubscriptionMoreDetailView()
    }
}

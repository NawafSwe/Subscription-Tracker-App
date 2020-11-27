//
//  SubscriptionListView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionListView: View {
    let subscriptionsList = MockData.subscriptionSampleList
    @State var selectedSubscription:Subscription? = nil
    @State var showSubscriptionDetail = false
    @State var showSubscriptionForm = false
    @State var viewState : CGSize = .zero
    
    var body: some View {
        NavigationView {
            ZStack{
                List(subscriptionsList){ sub in
                    
                    SubscriptionCellView(image:sub.image, name:sub.name, price: sub.price, dueDate: sub.dueDate)
                        .padding(.horizontal,-20)
                        .onTapGesture {
                            self.showSubscriptionDetail = true
                            self.selectedSubscription = sub
                        }
                        
                        .blur(radius: showSubscriptionDetail ? 10 :  0)
                        .shadow(radius: showSubscriptionDetail ? 10 : 0)
                }
                /// sheet for displaying the form
                .sheet(isPresented: $showSubscriptionForm){
                    SubscriptionFormView()
                }
                .listStyle(PlainListStyle())
                
                /// disabling the navigation if user shows sub details
                .disabled(showSubscriptionDetail)
                
                /// if the user tapped on the sub show its detail
                if(showSubscriptionDetail){
                    SubscriptionDetailView(subscription: selectedSubscription!,
                                           dismissView: $showSubscriptionDetail)
                    
                }
            }
            .navigationBarItems(leading: Button(action: {self.showSubscriptionForm.toggle()}, label: {
                                                    AddSubscriptionButtonView() } ))
            .navigationTitle("Subscriptions 💳")
            
        }
    }
}


struct SubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListView()
    }
}

struct AddSubscriptionButtonView:View{
    var body: some View{
        Image(systemName: Icons.SFbag)
            .resizable()
            .scaledToFit()
            .frame(width: 32, height: 32)
            .accentColor(.green)
    }
}

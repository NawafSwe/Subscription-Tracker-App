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
        ZStack {
            VStack{
            NavigationView {
                
                List(subscriptionsList){ sub in
                    SubscriptionCellView(image:sub.image, name:sub.name, price: sub.price, dueDate: sub.dueDate)
                        .padding(.vertical,4)
                        
                        .onTapGesture {
                            self.showSubscriptionDetail = true
                            self.selectedSubscription = sub
                        }
                        
                        .blur(radius: showSubscriptionDetail ? 10 :  0)
                        .shadow(radius: showSubscriptionDetail ? 10 : 0)
                       
                }
                /// disabling the navigation if user shows sub details
                .disabled(showSubscriptionDetail)
                .listStyle(PlainListStyle())
                .navigationBarItems(leading: Button(action: {self.showSubscriptionForm.toggle()}, label: {
                                                        AddSubscriptionButtonView() } ))
                .navigationTitle("Subscriptions 💳")
                
                /// sheet for displaying the form
                .sheet(isPresented: $showSubscriptionForm){
                    SubscriptionFormView()
                }
                
                
            }
            ExpenseView()
                .padding()
                
            }
            
            /// if the user tapped on the sub show its detail
            if(showSubscriptionDetail){
                SubscriptionDetailView(subscription: selectedSubscription!)
                    /// to watch the view state
                    //.overlay(
                    //Text( "\(self.viewState.height)")
                    // , alignment: .top)
                    .animation(.easeOut(duration: 0.5))
                    .gesture(
                        DragGesture().onChanged{ value in
                            //saving the value of the drag
                            self.viewState = value.translation
                            
                            /// if the user dragged it till 260 or more dismiss it
                            if(self.viewState.height >= 205){
                                self.showSubscriptionDetail.toggle()
                                self.viewState = .zero
                            }
                            
                        }
                        //to reset the position after releasing the gesture
                        .onEnded({ value in
                            self.viewState = .zero
                            
                        })
                    )
                    /// by dragging moving card
                    .offset(y: self.viewState.height > 0 ? self.viewState.height : 0)
                    // prevent animation from propagation
                    .animation(nil)
            }
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

//
//  SubscriptionListView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI
import UIKit

struct SubscriptionListView: View {
    @StateObject var viewModel = SubscriptionListViewModel()
    var body: some View {
        ZStack {
            VStack{
                NavigationView {
                    
                    // lopping on the cells
                    
                    List(viewModel.subscriptionServices ){ sub in
                        // passing subscription into cell view
                        SubscriptionCellView(subscription: sub)
                            .padding(.vertical,4)
                            
                            .onTapGesture { viewModel.selectedSubscription = sub
                            }
                            
                            .blur(radius: viewModel.showSubscriptionDetail ? 10 :  0)
                            .shadow(radius: viewModel.showSubscriptionDetail ? 10 : 0)
                        
                    }
                    /// disabling the navigation if user shows sub details
                    .disabled(viewModel.showSubscriptionDetail)
                    .listStyle(PlainListStyle())
                    .navigationBarItems(leading: Button(action: {viewModel.showSubscriptionForm.toggle()}, label: {
                                                            AddSubscriptionButtonView() } ))
                    .navigationTitle("Subscriptions 💳")
                    
                    
                    
                }
                
                if !viewModel.subscriptionRepository.subscriptions.isEmpty{
                    ExpenseView(price: viewModel.totalPrice)
                        .padding()
                }
                
            }
            
            /// sheet for displaying the form
            .sheet(isPresented: $viewModel.showSubscriptionForm){
                NewSubscriptionFormView()
                
            }
            
            /// if subscription list  empty show empty state
            if viewModel.subscriptionServices.isEmpty{
                EmptySubscriptionView(imageName: Images.emptySubscription, text: "Your Subscription List Is Empty Please Add One to show your subscriptions ⌚️.")
            }
            
            /// if the user tapped on the sub show its detail
            if(viewModel.showSubscriptionDetail){
                SubscriptionMoreDetailView(subscription: viewModel.selectedSubscription!.subscription)
                    /// to watch the view state
                    //.overlay(
                    //Text( "\(self.viewState.height)")
                    // , alignment: .top)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn(duration: 0.3))
                    .gesture(
                        DragGesture().onChanged{ value in
                            //saving the value of the drag
                            self.viewModel.viewState = value.translation
                            
                            /// if the user dragged it till 260 or more dismiss it
                            if(self.viewModel.viewState.height >= 150){
                                self.viewModel.showSubscriptionDetail.toggle()
                                self.viewModel.viewState = .zero
                            }
                            
                        }
                        //to reset the position after releasing the gesture
                        .onEnded({ value in
                            self.viewModel.viewState = .zero
                            
                        })
                    )
                    /// by dragging moving card
                    .offset(y: self.viewModel.viewState.height > 0 ? self.viewModel.viewState.height : 0)
                    // prevent animation from propagation
                    .animation(nil)
            }
        }
        
        .alert(item: $viewModel.alertItem){alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
        
    }
}



struct SubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListView()
    }
}




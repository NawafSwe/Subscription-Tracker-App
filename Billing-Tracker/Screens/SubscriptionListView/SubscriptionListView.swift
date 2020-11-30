//
//  SubscriptionListView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionListView: View {
    @StateObject var viewModel = SubscriptionListViewModel()
    var body: some View {
        ZStack {
            VStack{
                NavigationView {
                    
                    List(viewModel.subscriptions){ sub in
                        SubscriptionCellView(image:sub.image, name:sub.name, price: sub.price, dueDate: sub.dueDateString)
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
                
                
                ExpenseView(price: viewModel.totalPrice)
                    .padding()
            }
            
            
            /// sheet for displaying the form
            .sheet(isPresented: $viewModel.showSubscriptionForm){
                SubscriptionFormView()
            }
            
            /// if the user tapped on the sub show its detail
            if(viewModel.showSubscriptionDetail){
                SubscriptionDetailView(subscription: viewModel.selectedSubscription!)
                    /// to watch the view state
                    //.overlay(
                    //Text( "\(self.viewState.height)")
                    // , alignment: .top)
                    .animation(.easeOut(duration: 0.5))
                    .gesture(
                        DragGesture().onChanged{ value in
                            //saving the value of the drag
                            self.viewModel.viewState = value.translation
                            
                            /// if the user dragged it till 260 or more dismiss it
                            if(self.viewModel.viewState.height >= 205){
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
        //        .onAppear(perform: viewModel.getSubscriptions)
        /// getting sub every second
        .onReceive(viewModel.timer){ _ in
            viewModel.doStopCalling()
        }
    }
}



struct SubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListView()
    }
}




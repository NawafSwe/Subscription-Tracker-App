//
//  ManageSubscriptionsView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 30/11/2020.
//

import SwiftUI

struct ManageSubscriptionsView: View {
    @StateObject var viewModel = ManageSubscriptionsViewModel()
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    ForEach(self.viewModel.subscriptions){sub in
                        SubscriptionCellView(subscription: sub)
                            .onTapGesture { DispatchQueue.main.async { self.viewModel.selectedSubscription = sub } }
                            .padding(.vertical,4)
                        
                    }
                    .onDelete(perform: self.viewModel.deleteSubscription)
                    
                    
                }
                .listStyle(PlainListStyle())
                // edit mode
                .environment(\.editMode, .constant(viewModel.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}){ BackTrackButton() } ,
                                    trailing: Button(action:{viewModel.isEditing.toggle()}){
                                        StandardButton(title: "Edit" ,width: 80 , height: 30)
                                    }
                )
                .navigationTitle("Subscriptions 💳")
            }
            .sheet(isPresented: $viewModel.showUpdateForm){
                UpdateSubscriptionView(viewModel: UpdateSubscriptionViewModel(subscription: viewModel.selectedSubscription!))
            }
            
            
            /// if subscriptions list  empty show empty state
            if viewModel.subscriptions.isEmpty{
                EmptySubscriptionView(imageName: Images.emptySubscription, text: "Your Subscription List Is Empty Please Add One to show your subscriptions ⌚️.")
            }
        }
    }
    
}


struct ManageSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageSubscriptionsView()
    }
}

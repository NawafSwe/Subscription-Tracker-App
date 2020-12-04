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
    @State var showUpdate = false
    var body: some View {
        ZStack{
            NavigationView{
                List{
                    ForEach(self.viewModel.subscriptions){sub in
                        SubscriptionCellView(subscription: sub.subscription)                 
                            .padding(.vertical,4)
                        
                    }
                    .onDelete(perform: self.viewModel.deleteSubscription)
                }
                .listStyle(PlainListStyle())
                // edit mode
                .environment(\.editMode, .constant(self.viewModel.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                
                .navigationBarItems(leading: Button(action: {self.presentationMode.wrappedValue.dismiss()}){ DismissButtonView() } ,
                                    trailing:Button(action:{viewModel.isEditing.toggle() }){
                                        EditButton()
                                    }
                )
                .navigationTitle("Subscriptions 💳")
            }
            
            /// if subscriptions list  empty show empty state
            if viewModel.subscriptions.isEmpty{
                EmptySubscriptionsView()
            }
        }
    }
    
}


struct ManageSubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageSubscriptionsView()
    }
}

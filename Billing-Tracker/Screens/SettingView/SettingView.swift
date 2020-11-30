//
//  SettingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SettingView: View {
  @StateObject var viewModel = SettingViewModel()
    var body: some View {
        NavigationView {
            Form{
                
                Section(header:Text("General")){
                    Button(action:{viewModel.showManagedSubscriptions.toggle()}){
                        HStack{
                            Image(systemName:Icons.SFCreditcard)
                                .resizable()
                                .frame(width:20, height: 20)
                                .scaledToFit()
                                .foregroundColor(.white)
                                
                                
                            Text("Manage subscriptions")
                             .foregroundColor(.white)
                        }
                        
                    }
                    .sheet(isPresented: $viewModel.showManagedSubscriptions){
                        ManageSubscriptionsView()
                    }
                    
                    Button(action:{}){
                        Text("Account")
                    }
                    
                    Button(action:{}){
                        Text("Custom App Icon")
                    }
                    
                }
                Section(header:Text("Support")){
                    Link(destination:K.devAccount){
                        HStack{
                            Image(Images.twitter)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26 , height: 26)
                            Text("Contact Developer")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action:{
                        viewModel.logout()
                    }){
                        Text("Logout")
                    }.alert(item: $viewModel.alertItem){alert in
                        Alert(title:alert.title , message: alert.message, dismissButton: alert.dismissButton)
                    }
                }
            }
            
            .navigationTitle("Setting")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

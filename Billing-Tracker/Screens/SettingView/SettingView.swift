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
                            Image(Images.coloredCreditCard)
                                .resizable()
                                .imageScale(.small)
                                .frame(width: 44 , height : 44)
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 50, x: 0, y: 10)
                            Text("Manage subscriptions")
                                .foregroundColor(.standardText)
                            
                        }
                        
                    }
                    .sheet(isPresented: $viewModel.showManagedSubscriptions){
                        ManageSubscriptionsView()
                        
                    }
                    
                    Button(action:{}){
                        HStack {
                            PersonIconView(width: 35, height : 33)
                            Text("Account")
                                .foregroundColor(.standardText)
                        }
                        
                    }
                    
                    Button(action:{}){
                        HStack{
                            Image(systemName: Icons.SFLinkBadge )
                                .resizable()
                                .renderingMode(.original)
                                .imageScale(.small)
                                .frame(width: 30 , height : 30)
                            Text("Add Custom Providers")
                                .foregroundColor(.standardText)
                        }
                    }
                }
                Section(header:Text("Support")){
                    Link(destination:K.devAccount){
                        HStack{
                            Image(Images.twitter)
                                .resizable()
                                .frame(width: 26 , height: 26)
                                .scaledToFit()
                                .scaledToFill()
                                .imageScale(.medium)
                            Text("Contact Developer")
                                .foregroundColor(.standardText)
                        }
                    }
                    
                    Button(action:{
                        viewModel.logout()
                    }){
                        HStack{
                            Image(systemName: "wifi.slash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:20, height: 20)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)))
                                .scaledToFill()
                            
                            Text("Logout")
                                .foregroundColor(.standardText)
                            
                        }
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
            .colorScheme(.dark)
    }
}

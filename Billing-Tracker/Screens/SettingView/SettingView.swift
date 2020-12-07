//
//  SettingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SettingView: View {
    @StateObject var viewModel = SettingViewModel()
    @State var showCustomProvidersView = false
    @State var showReadyProviders = false
    var body: some View {
        ZStack{
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
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundColor(.lunchViewIconsColor)
                                    .frame(width: 30 , height : 30)
                                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
                                Text("Account")
                                    .foregroundColor(.standardText)
                            }
                        }
                        
                        Button(action:{
                            showCustomProvidersView.toggle()
                        }){
                            HStack{
                                Image(systemName: Icons.SFLinkBadge )
                                    .resizable()
                                    .renderingMode(.original)
                                    .imageScale(.small)
                                    .frame(width: 30 , height : 30)
                                Text("Custom Your Providers")
                                    .foregroundColor(.standardText)
                            }
                        }.sheet(isPresented: $showCustomProvidersView){
                            ManageProvidersView()
                        }
                        
                        
                        Button(action:{
                            showReadyProviders.toggle()
                        }){
                            HStack{
                                Image(systemName: Icons.SFbookmark )
                                    .resizable()
                                    .accentColor(.mainColor)
                                    .imageScale(.small)
                                    .frame(width: 20 , height : 30)
                                Text("Ready Providers With Icons")
                                    .foregroundColor(.standardText)
                            }
                        }.sheet(isPresented: $showReadyProviders){
                            ProvidedProvidersView()
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
            
            if viewModel.isLoading {
                LoadingView(isLoading: $viewModel.isLoading)
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .colorScheme(.dark)
    }
}

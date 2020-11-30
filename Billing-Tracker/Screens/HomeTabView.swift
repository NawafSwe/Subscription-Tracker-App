//
//  ContentView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct HomeTabView: View {
    @ObservedObject var userService = UserAuthenticationManager.shared
    var body: some View {

        TabView{
            SubscriptionListView().tabItem {
                Image(systemName: Icons.SFCreditcard)
                    .resizable()
                    .frame(width:20, height: 20)
                    .scaledToFit()
                Text("Subscriptions")
                
            }
            
            SubscriptionTimingsView().tabItem {
                Image(systemName: Icons.SFTimelapse)
                    .resizable()
                    .frame(width:20, height: 20)
                    .scaledToFit()
                Text("Subscription Timings")
            }
                      
            SettingView().tabItem {
                Image(systemName: Icons.SFgearshape)
                    .resizable()
                    .frame(width:20, height: 20)
                    .scaledToFit()
                Text("Setting")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .accentColor(.tabItem)
      
    }
}


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}


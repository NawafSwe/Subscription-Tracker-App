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
                    .modifier(TabIconsModifiers())
                Text("Subscriptions")
                
            }
            
            SubscriptionTimingsView().tabItem {
                Image(systemName: Icons.SFTimelapse)
                    .resizable()
                    .modifier(TabIconsModifiers())
                Text("Subscription Timings")
            }
            
            SettingView().tabItem {
                Image(systemName: Icons.SFgearshape)
                    .resizable()
                    . modifier(TabIconsModifiers())
                Text("Setting")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .accentColor(.mainColor)
        
    }
}


struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}


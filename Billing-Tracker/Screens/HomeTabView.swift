//
//  ContentView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct HomeTabView: View {
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
        .accentColor(Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
        
        
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}

//gearshape

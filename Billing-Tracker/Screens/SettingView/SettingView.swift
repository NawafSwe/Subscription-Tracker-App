//
//  SettingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            Form{
                
                Section(header:Text("General")){
                    Button(action:{}){
                        Text("Manage subscriptions")
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

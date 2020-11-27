//
//  SubscriptionFormView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct SubscriptionFormView: View {
    @State var subscriptionList = MockData.subscriptionSampleList
    @State var selectedProvider = 0
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Subscription Details")){
                    Picker(selection: $selectedProvider, label: Text("Provider"), content: {
                        ProvidersSelectionView(image: Images.Spotify, name: "Spotify").tag(1)
                        ProvidersSelectionView(image: Images.Netflix, name: "Netflix").tag(2)
                        ProvidersSelectionView(image: Images.iCloud, name: "iCloud").tag(3)
                        ProvidersSelectionView(image: Images.Youtube, name: "Youtube").tag(4)
                    })
                }
              
            }
            
            .navigationTitle("New Subscription 💳")
        }
    }
}

struct SubscriptionFormView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionFormView()
    }
}





struct ProvidersSelectionView:View{
    let image:String
    let name:String
    var body: some View{
        HStack{
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width:26, height: 26)
            Text(name)
                .font(.subheadline)
        }
    }
}


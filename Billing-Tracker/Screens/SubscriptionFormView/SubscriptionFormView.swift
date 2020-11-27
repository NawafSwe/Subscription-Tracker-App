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
    @State var subDescription = ""
    @State var subPrice:String = ""
    var calculatePrice:Double { Double(subPrice) ?? 0.0 }
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("Subscription Details")){
                    
                    Picker(selection: $selectedProvider, label: Text("Provider") , content:{
                        List(0..<subscriptionList.count){index in
                            ProvidersSelectionView(image: subscriptionList[index].image, name: subscriptionList[index].name).tag(index)
                        }
                    })
                    
                    TextField("Description", text: $subDescription)
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Price", text: $subPrice)
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                        
                    
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

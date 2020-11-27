//
//  SubscriptionFormView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI
/// we will calculate the next bill date based on the current date
/// and recalculate the next bill date  + from the due date

struct SubscriptionFormView: View {
    @State var subscriptionList = MockData.subscriptionSampleList
    @State var selectedProvider = 0
    @State var subDescription = ""
    @State var subPrice:String = ""
    @State var date = Date()
    @State var selectedCycle = 0
    @State var cycleTypes = ["weekly","monthly","yearly"]
    var calculatePrice:Double {
        Double(subPrice) ?? 0.0
        }
    @State var remindUser = false
    var body: some View {
        NavigationView {
            ZStack {
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
                    
                    Section(header:(Text("Timings"))){
                        Picker("Cycle", selection: $selectedCycle){
                            List(0..<cycleTypes.count){cycle in
                                Text(cycleTypes[cycle])
                            }
                        }
                        
                        DatePicker("Due Date", selection: $date, displayedComponents: .date)
                        
                        
                    }
                    .accentColor(.black)
                    
                    Section(header:Text("Reminders")){
                        Toggle("Remind Me Before Expire", isOn: $remindUser)
                    }
                    
                    
                }
                
                Text("When Enabling This Option You Will Receive a Notification Before Your Subscription Expired.")
                    .foregroundColor(.secondary)
                    .offset(y:120)
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

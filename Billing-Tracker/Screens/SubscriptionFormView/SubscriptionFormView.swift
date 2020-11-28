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
    @Environment (\.presentationMode) var presentationMode
    @State var providersList = Providers.providersList
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
    var body: some View{
        NavigationView {
            ZStack {
                Form{
                    Section(header: Text("Subscription Details")){
                        
                        Picker(selection: $selectedProvider, label: Text("Provider") , content:{
                            List(0..<providersList.count){index in
                                ProvidersSelectionView(image: providersList[index].image, name: providersList[index].name).tag(index)
                            }
                        })
                        
                        TextField("Description", text: $subDescription)
                            /// setting limit for user because we do not want him to miss with the UI
                            .onChange(of: self.subDescription, perform: { value in
                                        if value.count > 26 {
                                            self.subDescription = String(value.prefix(26))
                                            /// put alert to user about the reason.
                                        }})
                            .overlay(
                                CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(subDescription.count))), alignment: .trailing
                                
                            )
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
                    .accentColor(.primary)
                    
                    Section(header:Text("Reminder")){
                        Toggle("Notify Me One Day Before", isOn: $remindUser)
                    }
                    
                }
            }
            .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){
                DismissButtonView()
                    
                
            }
            
            )
            .navigationTitle("New Subscription 💳")
        }
    }
    
}

struct SubscriptionFormView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionFormView()
            .colorScheme(.dark)
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

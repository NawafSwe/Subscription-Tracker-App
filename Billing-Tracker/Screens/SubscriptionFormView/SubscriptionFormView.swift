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
    @StateObject var viewModel = SubscriptionFormViewModel()
    @State var remindUser = false
    var body: some View{
        NavigationView {
            ZStack {
                Form{
                    Section(header: Text("Subscription Details")){
                        
                        Picker(selection: $viewModel.selectedProvider, label: Text("Provider") , content:{
                            List(0..<viewModel.providersList.count){index in
                                ProvidersSelectionView(image: viewModel.providersList[index].image, name: viewModel.providersList[index].name).tag(index)
                            }
                        })
                        
                        TextField("Description", text: $viewModel.subDescription)
                            /// setting limit for user because we do not want him to miss with the UI
                            .onChange(of: self.viewModel.subDescription, perform: { value in
                                        if value.count > 26 {
                                            self.viewModel.subDescription = String(value.prefix(26))
                                            /// put alert to user about the reason.
                                        }})
                            .overlay(
                                CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.subDescription.count))), alignment: .trailing
                                
                            )
                            .keyboardType(.default)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        TextField("Price", text: $viewModel.subPrice)
                            .keyboardType(.decimalPad)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    Section(header:(Text("Timings"))){
                        Picker("Cycle", selection: $viewModel.selectedCycle){
                            List(0..<viewModel.cycleTypes.count){cycle in
                                Text(viewModel.cycleTypes[cycle])
                            }
                        }
                        
                        DatePicker("Due Date", selection: $viewModel.date, displayedComponents: .date)
                        
                        
                    }
                    .accentColor(.primary)
                    
                    Section(header:Text("Reminder")){
                        Toggle("Notify Me One Day Before", isOn: $viewModel.remindUser)
                    }
                    
                }
            }
            .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){
                DismissButtonView().padding()
               
            },trailing:
                Button(action:{viewModel.addSubscription()}){ saveButtonView() }
            )
            .navigationTitle("New Subscription 💳")
        }.alert(item: $viewModel.alertItem){alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
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

struct saveButtonView:View{
    var body: some View{
        Text("Save")
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
}

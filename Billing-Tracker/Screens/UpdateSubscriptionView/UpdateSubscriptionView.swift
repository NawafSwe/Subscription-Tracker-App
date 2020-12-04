//
//  AddNewSubscriptionView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct UpdateSubscriptionView:View{
    @ObservedObject var viewModel:UpdateSubscriptionViewModel
    var body: some View{
        NavigationView {
            Form{
                Section(header: Text("Subscription Details")){
                    
                    Button(action:{}){
                        HStack{
                            Text("Provider")
                            Spacer()
                            ProviderCellView(provider: viewModel.selectedProvider.wrappedValue)
                                
                        }
                    }
                    .disabled(true)
                    .foregroundColor(.standardText)
                     
                    
                    TextField("Description", text: $viewModel.subDescription.wrappedValue)
                        .keyboardType(.default)
                        .modifier(TextFieldModifiers())
                        /// setting limit for user because we do not want him to miss with the UI
                        .onChange(of: self.viewModel.subDescription.wrappedValue, perform: viewModel.descriptionLimit)
                        .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.subDescription.wrappedValue.count) ), totalChars: CGFloat(26) ), alignment: .trailing)
                    
                    
                    
                    TextField("Price", text: $viewModel.subPrice.wrappedValue)
                        .keyboardType(.decimalPad)
                        .modifier(TextFieldModifiers())
                    
                }
                
                Section(header:(Text("Timings"))){
                    Picker("Cycle", selection: $viewModel.selectedCycle){
                        List(0..<viewModel.cycleTypes.count){cycle in
                            Text(viewModel.cycleTypes[cycle])
                        }
                    }
                    
                    /// allowing user to select from now till 90 year only
                    DatePicker("Due Date", selection: $viewModel.date.wrappedValue, in: Date()...Date().notYesterday, displayedComponents: .date)
                    
                    
                }
                .accentColor(.primary)
                
                Section(header:Text("Reminder")){
                    Toggle("Notify Me One Day Before", isOn: $viewModel.remindUser.wrappedValue)
                    
                    if viewModel.remindUser.wrappedValue{
                        TextField("Preferred Notification Message ", text: $viewModel.notificationMessage)
                            .transition(.move(edge: .bottom))
                            .onChange(of: viewModel.notificationMessage, perform: viewModel.notificationLimit)
                            .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.notificationMessage.count) ), totalChars: CGFloat(27) ), alignment: .trailing)
                    }
                }
                
            }
                .navigationTitle("Update Subscription 💳")
        }
    }
}
struct UpdateSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateSubscriptionView(viewModel: UpdateSubscriptionViewModel(subDescription: .constant(""), subPrice: .constant(""), date: .constant(Date()), remindUser: .constant(false), selectedProvider: .constant(Providers.providersList[0])))
    }
}

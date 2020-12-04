//
//  SubscriptionFormView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI
/// we will calculate the next bill date based on the current date
/// and recalculate the next bill date  + from the due date

//MARK:- SubscriptionFormView
struct NewSubscriptionFormView: View {
    @StateObject var viewModel = SubscriptionFormViewModel()
    @Environment (\.presentationMode) var presentationMode
    var body: some View{
        NavigationView {
            ZStack {
                Form{
                    Section(header: Text("Subscription Details")){
                        
                        Button(action:{viewModel.showProvidersList.toggle() }){
                            HStack{
                                Text("Select Provider")
                                
                                Spacer()
                                
                                if viewModel.selectedProvider != nil  {
                                  ProviderCellView(provider: viewModel.selectedProvider!)
                                    }
                            }
                        }
                        
                        .foregroundColor(.standardText)
                        .sheet(isPresented: $viewModel.showProvidersList){ ProvidersSelectionView(viewModel: viewModel
                        ) }
                        
                        TextField("Description", text: $viewModel.subDescription)
                            .keyboardType(.default)
                            .modifier(TextFieldModifiers())
                            /// setting limit for user because we do not want him to miss with the UI
                            .onChange(of: self.viewModel.subDescription, perform: viewModel.descriptionLimit)
                            .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.subDescription.count) ), totalChars: CGFloat(26) ), alignment: .trailing)
                        
                        
                        
                        TextField("Price", text: $viewModel.subPrice)
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
                        DatePicker("Due Date", selection: $viewModel.date, in: Date()...Date().notYesterday, displayedComponents: .date)
                        
                        
                    }
                    .accentColor(.primary)
                    
                    Section(header:Text("Reminder")){
                        Toggle("Notify Me One Day Before", isOn: $viewModel.remindUser)
                        
                        if viewModel.remindUser{
                            TextField("Preferred Notification Message ", text: $viewModel.notificationMessage)
                                .transition(.move(edge: .bottom))
                                .onChange(of: viewModel.notificationMessage, perform: viewModel.notificationLimit)
                                .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.notificationMessage.count) ), totalChars: CGFloat(27) ), alignment: .trailing)
                        }
                    }
                    
                }
                
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){
                    DismissButtonView().padding()
                    
                },trailing:
                    Button(action:{viewModel.addSubscription()}){ saveButtonView() }
                    .alert(item: $viewModel.alertItem){alert in
                        Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                    }
                )
                
                .navigationTitle("New Subscription 💳")
                
            }
            
            
        }
    }
}

//MARK:- SubscriptionFormView_Previews
struct SubscriptionFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewSubscriptionFormView()
            .colorScheme(.dark)
    }
}

//
//  AddNewSubscriptionView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 27/11/2020.
//

import SwiftUI

struct UpdateSubscriptionView:View{
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var viewModel:UpdateSubscriptionViewModel
    var body: some View{
        ZStack{
            NavigationView {
                Form{
                    Section(header: Text("Subscription Details")){
                        
                        Button(action:{}){
                            HStack{
                                Text("Provider")
                                Spacer()
                                ProviderCellView(name: viewModel.subscription.subscription.name, image: viewModel.subscription.subscription.image )
                                
                            }
                        }
                        .disabled(true)
                        .foregroundColor(.standardText)
                        
                        
                        TextField("Description", text: $viewModel.subscription.subscription.description)
                            .keyboardType(.default)
                            .modifier(TextFieldModifiers())
                            /// setting limit for user because we do not want him to miss with the UI
                            //.onChange(of: $viewModel.subscription.description, perform: viewModel.descriptionLimit)
                            .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.subscription.subscription.description.count) ), totalChars: CGFloat(26) ), alignment: .trailing)
                        
                        
                        
                        TextField("Price", text: $viewModel.subscription.subscription.priceString)
                            .keyboardType(.decimalPad)
                            .modifier(TextFieldModifiers())
                        
                    }
                    
                    Section(header:(Text("Timings"))){
                        Picker("Cycle", selection: $viewModel.subscription.subscription.cycleIndex){
                            List(0..<viewModel.cycleTypes.count){cycle in
                                Text(viewModel.cycleTypes[cycle]).tag(cycle)
                            }
                        }
                        //.onChange(of: viewModel.selectedCycle, perform: viewModel.determineCycle)
                        
                        /// allowing user to select from now till 90 year only
                        DatePicker("Due Date", selection: $viewModel.subscription.subscription.dueDateInDate, in: Date()...Date().notYesterday, displayedComponents: .date)
                        
                        
                    }
                    .accentColor(.primary)
                    
                    Section(header:Text("Reminder")){
                        Toggle("Notify Me One Day Before", isOn: $viewModel.subscription.subscription.notifyMe)
                            .onChange(of: viewModel.subscription.subscription.notifyMe){ _ in
                                // if changed to false and there is notification id will be removed
                                viewModel.requestNotificationAuthorization()
                                
                            }
                        
                        if viewModel.subscription.subscription.notifyMe{
                            TextField("Preferred Notification Message ", text: $viewModel.subscription.subscription.notificationMessage)
                                .transition(.move(edge: .bottom))
                                .onChange(of: viewModel.subscription.subscription.notificationMessage, perform: viewModel.notificationLimit)
                                .overlay( CharsLimitRingView(width: 33, height: 33, remindChars: .constant(CGFloat(viewModel.subscription.subscription.notificationMessage.count) ), totalChars: CGFloat(27) ), alignment: .trailing)
                        }
                    }
                    
                }
                
                
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){
                    DismissButtonView()
                } ,
                trailing: Button(action:{viewModel.updateSubscription()}){
                    StandardButton(title:"Done" ,width: 80 , height: 30 )
                }
                .alert(item: $viewModel.alertItem){ alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                    
                }
                )
                .navigationTitle("Edit Subscription 💳")
                
            }
            
        }
    }
}
struct UpdateSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateSubscriptionView(viewModel: UpdateSubscriptionViewModel(subscription: SubscriptionServices(subscription: MockData.subscriptionSample)))
    }
}

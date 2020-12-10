//
//  AccountView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 07/12/2020.
//

import SwiftUI
import Firebase
struct AccountView: View {
    //view model will load all user data from user services
    @ObservedObject var viewModel  : AccountViewModel
    @Environment (\.presentationMode) var presentationMode
    @State var viewState: CGSize = .zero
    var body: some View {
        ZStack {
            NavigationView {
                Form{
                    Section(header:Text("Account information")){
                        Button(action:{ self.viewModel.showEmailBox.toggle() }){
                            HStack {
                                Text("Email :")
                                Text("\(viewModel.email)")
                                Spacer()
                                Image(systemName: Icons.SFChevronRight)
                                    .resizable()
                                    .frame(width:9 , height: 15)
                                    .accentColor(.chevronColor)
                            }
                        }
                        .accentColor(.primary)
                        Button(action:{viewModel.showPasswordBox.toggle() }){
                            HStack {
                                Text("Change Password")
                                    .foregroundColor(.mainColor)
                                Spacer()
                                Image(systemName: Icons.SFChevronRight)
                                    .resizable()
                                    .frame(width:9 , height: 15)
                                    .accentColor(.chevronColor)
                            }
                        }
                        TextField("Name" , text:$viewModel.displayName)
                        
                    }
                    Section(header:Text("Additional Information")){
                        TextField("Age" , text:$viewModel.age )
                        TextField("gender",text:$viewModel.gender  )
                        TextField("Preferred Provider" , text:$viewModel.preferredProviderName)
                    }
                }
                .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){DismissButtonView()}
                                    , trailing: Button(action:{}){
                                        StandardButton(title: "Save")
                                    })
                .navigationTitle("Profile")
            }
            .blur(radius: viewModel.showEmailBox ? 3 : 0)
            
            if viewModel.showEmailBox{
                EmailBoxView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn(duration: 0.3))
                    .gesture(
                        DragGesture().onChanged({value in
                            //saving the value of the drag
                            self.viewState = value.translation
                            if self.viewState.height > 150{
                                self.viewModel.showEmailBox = false
                                self.viewState.height = .zero
                            }
                        })
                        
                        .onEnded({value in
                            self.viewState = .zero
                        })
                    )
                    .offset(y: self.viewState.height > 0 ? self.viewState.height : 0)
                    // prevent animation from propagation
                    .animation(nil)
                
                
            }
            
            if viewModel.showPasswordBox{
                PasswordBoxView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn(duration: 0.3))
                    .gesture(
                        DragGesture().onChanged({value in
                            //saving the value of the drag
                            self.viewState = value.translation
                            if self.viewState.height > 150{
                                self.viewModel.showPasswordBox = false
                                self.viewState.height = .zero
                            }
                        })
                        
                        .onEnded({value in
                            self.viewState = .zero
                        })
                    )
                    .offset(y: self.viewState.height > 0 ? self.viewState.height : 0)
                    // prevent animation from propagation
                    .animation(nil)
            }
        }
    }
}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(email: "nn@1234gmail.com", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
    }
}

//
//  SignUpView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 14/12/2020.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel : RegisterViewModel
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading,spacing:40){
                    Text("Register")
                        .font(.system(size: 30, weight: .semibold, design: .rounded ))
                    
                    TextField("", text: $viewModel.name)
                        .modifier(RegisterTextFieldsModifiers(showPlaceHolder: viewModel.name.isEmpty, placeHolder: "Name"))
                        .modifier(TextFieldModifiers())
                        .background( RoundedRectangle(cornerRadius: 15).frame(width:270 ,height: 40)
                                        .foregroundColor(Color.textFieldsColor)
                        )
                    
                    //.overlay( PersonIconView(width: 36, height: 36).padding(.horizontal,7), alignment: .leading)
                    
                    TextField("", text: $viewModel.email)
                        .modifier(RegisterTextFieldsModifiers(showPlaceHolder: viewModel.email.isEmpty, placeHolder: "Email"))
                        .modifier(TextFieldModifiers())
                        .background(
                            RoundedRectangle(cornerRadius: 15).frame(width:270 ,height: 40)
                                .foregroundColor(Color.textFieldsColor)
                        )
                    
                    //.overlay(   EmailIconView(width: 36, height: 36).padding(.horizontal,7) , alignment: .leading)
                    
                    
                    SecureField("",text:$viewModel.password)
                        .modifier(RegisterTextFieldsModifiers(showPlaceHolder: viewModel.password.isEmpty, placeHolder: "Password"))
                        .modifier(TextFieldModifiers())
                        .background(
                            RoundedRectangle(cornerRadius: 15).frame(width:270 ,height: 40)
                                .foregroundColor(Color.textFieldsColor)
                        )
                    //.overlay(LockIconView(width: 36, height: 36).padding(.horizontal,7),alignment: .leading)
                }
                .padding()
                .frame(width: 320, height: 350, alignment: .center)
                .background(Color.backgroundCell)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                
                
                Button(action:{
                    self.viewModel.register(email: viewModel.email, password: viewModel.password, name: viewModel.name)
                }){
                    MainButtonView(title: "Register")
                }
                .alert(item: $viewModel.alertItem){ alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                    
                }
                
                HStack {
                    WelcomeMessage(title: "Already have an account?")
                    Button(action:{
                        self.viewModel.showRegister = false
                        self.viewModel.showLogin = true
                    }){
                        StandardButton(title: "Login", width: 70, height: 30)
                    }
                }
                .padding(.vertical)
                
            }
            .padding()
            .frame(height:600)
            
            
            if viewModel.isLoading{
                LoadingView(isLoading: $viewModel.isLoading)
            }
            Button(action:{
                viewModel.showRegister = false
            }){
                BackTrackButton()
            }
            .padding(.horizontal)
            .offset(x: -1 * UIScreen.screenWidth / 3 * 1.2 , y:  -1 * UIScreen.screenHeight / 3 * 1.3)
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: RegisterViewModel())
            .colorScheme(.dark)
    }
}

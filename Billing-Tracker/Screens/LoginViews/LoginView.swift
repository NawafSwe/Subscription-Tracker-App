//
//  LoginView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 10/12/2020.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: RegisterViewModel
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing:40){
                    
                    Text("Login")
                        .font(.title)
                    
                    TextField("Email", text: $viewModel.email)
                        .modifier(RegisterTextFieldsModifiers(showPlaceHolder: viewModel.email.isEmpty, placeHolder: "Email"))
                        .modifier(TextFieldModifiers())
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:270 ,height: 40)
                                .foregroundColor(Color.textFieldsColor)
                        )
                    // .overlay(   EmailIconView(width: 36, height: 36).padding(.horizontal,7) , alignment: .leading)
                    
                    
                    SecureField("Password",text:$viewModel.password)
                        .modifier(RegisterTextFieldsModifiers(showPlaceHolder: viewModel.password.isEmpty, placeHolder: "Password"))
                        .modifier(TextFieldModifiers())
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:270 ,height: 40)
                                .foregroundColor(Color.textFieldsColor)
                            
                        )
                    // .overlay(LockIconView(width: 36, height: 36).padding(.horizontal,7),alignment: .leading)
                    
                    
                }
                .padding()
                .frame(width: 320, height: 300, alignment: .center)
                .background(Color.backgroundCell)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                
                
                Button(action:{
                    self.viewModel.login(email: viewModel.email, password: viewModel.password)
                }){
                    MainButtonView(title: "Login")
                }
                .alert(item: $viewModel.alertItem){ alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                    
                }
                HStack{
                    
                    WelcomeMessage(title: "Do not you have an Account?")
                    
                    Button(action:{
                        self.viewModel.showRegister = true
                        self.viewModel.showLogin = false
                    }){
                        StandardButton(title: "Register", width: 70, height: 30)
                    }
                    
                }
                .padding()
                
            }
            
            if viewModel.isLoading{
                LoadingView(isLoading: $viewModel.isLoading)
            }
            
            Button(action:{
                viewModel.showLogin = false
            }){
                BackTrackButton()
            }
            .padding(.horizontal)
            .offset(x: -1 * UIScreen.screenWidth / 3 * 1.2 , y:  -1 * UIScreen.screenHeight / 3 * 1.3)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: RegisterViewModel())
            .colorScheme(.dark)
    }
}

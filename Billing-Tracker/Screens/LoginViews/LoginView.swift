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
                VStack(alignment: .leading,spacing:20){
                    
                    Text("Login")
                        .font(.title)
                    
                    Text("Your Email:")
                        .font(.body)
                    
                    HStack {
                        
                        Spacer().frame(width: 10)
                        
                        TextField("Email", text: $viewModel.email)
                            .padding(.horizontal,50)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width:270 ,height: 40)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            )
                            .overlay(   EmailIconView(width: 36, height: 36).padding(.horizontal,7) , alignment: .leading)
                    }
                    
                    
                    Text("Password:")
                        .font(.body)
                    
                    HStack {
                        Spacer().frame(width: 10)
                        SecureField("Password",text:$viewModel.password)
                            .padding(.horizontal,50)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width:270 ,height: 40)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                
                            )
                            .overlay(LockIconView(width: 36, height: 36).padding(.horizontal,7),alignment: .leading)
                    }
                    
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
                Button(action:{
                    self.viewModel.showRegister = true
                    self.viewModel.showLogin = false 
                }){
                    WelcomeMessage(title: "Do not you have an Account?", underlinedText: "Register")
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

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
                    Text("Welcome 💳")
                        .font(.title2)
                    Text("Login")
                        .font(.title)
                    
                    Text("Your Email:")
                        .font(.body)
        
                    TextField("Email", text: $viewModel.email)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:290 ,height: 30)
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        )
                       
                    
                    Text("Password:")
                        .font(.body)
                    
                    SecureField("Password",text:$viewModel.password)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:290 ,height: 30)
                                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                
                        )
                    
                }
                .padding()
                .frame(width: 320, height: 320, alignment: .center)
                .background(Color.backgroundCell)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                
                
                Button(action:{}){
                    MainButtonView(title: "Login")
                }
                Button(action:{}){
                    WelcomeMessage(title: "Do not you have an Account?", underlinedText: "Register")
                }
                .padding()
                
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: RegisterViewModel())
            .colorScheme(.dark)
    }
}

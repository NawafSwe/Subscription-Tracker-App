//
//  RegisterView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        ZStack {
            VStack( alignment: .leading, spacing: 30){
                Text("Welcome ⌚️")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                VStack(spacing:10){
                    HStack{
                        PersonIconView(width: 44 , height : 44)
                            .padding(.horizontal)
                        TextField("Email", text: $viewModel.email)
                            .modifier(TextFieldModifiers())
                            .keyboardType(.emailAddress)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.subheadline)
                        
                        
                    }
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .foregroundColor(.lunchViewIconsColor)
                            .frame(width: 44 , height : 44)
                            .background(Color.lunchViewIconsBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
                            .padding(.horizontal)
                        
                        SecureField("Password",text: $viewModel.password)
                            .modifier(TextFieldModifiers())
                            .font(.subheadline)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    
                    
                }
                .padding(.horizontal,20)
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .light))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.backgroundCell.opacity(0.15) , radius: 20, x: 0, y: 20)
                .padding()
                Button(action: {self.viewModel.isNewUser ? viewModel.login(email: viewModel.email, password: viewModel.password)
                    : viewModel.register(email: viewModel.email, password: viewModel.password)
                }){
                    MainButtonView(title: viewModel.isNewUser ? "Login" : "Register")
                    
                }
                
                .alert(item: $viewModel.alertItem){ alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                }
                
                
                Button(action:{viewModel.isNewUser.toggle()}){
                    WelcomeMessage(title: viewModel.isNewUser ? "CreateAccount?" : "Already has Account", underlinedText:  viewModel.isNewUser ? "Sign Up" : "Login!")
                    
                }
                .padding(.leading)
                
                Spacer()
            }
            .padding()
            .shadow(radius: 3)
            
            if viewModel.isLoading {
                LoadingView(isLoading: $viewModel.isLoading)
            }
            
        }
        
        .background(
            Color.backgroundCell
                .edgesIgnoringSafeArea(.all)
        )
        
        
    }
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .colorScheme(.dark)
    }
}
//MARK:- MainButtonView
struct MainButtonView : View {
    let title:String
    var body : some View{
        VStack{
            Text(title)
                .foregroundColor(.white)
                .frame(width: 350 , height: 40)
                .background(Color.mainColor.opacity(1))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 40, height: 30), style: .continuous))
                .padding()
        }
    }
}

//MARK:- WelcomeMessage
struct WelcomeMessage:View{
    let title: String
    let underlinedText:String
    var body: some View{
        HStack{
            Text(title)
            Text(underlinedText)
                .underline()
                .foregroundColor(.blue)
        }
        .font(.title2)
        .foregroundColor(.primary)
    }
}

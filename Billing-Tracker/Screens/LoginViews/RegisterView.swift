//
//  RegisterView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel : RegisterViewModel
    var screen = UIScreen.main.bounds
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 5){
                Text("Welcome To Billing Tracker 💳")
                    .font(.largeTitle)
                    .foregroundColor(.standardText)
                    .padding()
                    .multilineTextAlignment(.center)
                Button(action:{
                    viewModel.showRegister.toggle()
                }){
                    MainButtonView(title: "Register")
                }
                
                Button(action:{
                    viewModel.showLogin.toggle()
                    
                }){
                    MainButtonView(title: "Login")
                }
                
            }
            .padding()
            
            
            if viewModel.showRegister{
                SignUpView(viewModel: viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn)
                    .animation(nil)
            }
            
            if viewModel.showLogin{
                LoginView(viewModel:viewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn)
                    .animation(nil)
            }
            
        }
        
        
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
            .colorScheme(.dark)
    }
}
//MARK:- MainButtonView
struct MainButtonView : View {
    let title:String
    var screen = UIScreen.main.bounds
    var body : some View{
        VStack{
            Text(title)
                .foregroundColor(.white)
                .frame(width: 320 , height: 40)
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
                .font(.title3)
            Text(underlinedText)
                .underline()
                .font(.title3)
                .foregroundColor(.blue)
        }
        .font(.title2)
        .foregroundColor(.primary)
    }
}

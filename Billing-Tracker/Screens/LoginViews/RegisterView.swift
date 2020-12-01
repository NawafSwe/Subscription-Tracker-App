//
//  RegisterView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    @State var isNewUser = false
    
    var body: some View {
        ZStack {
            Color.backgroundCell
                .edgesIgnoringSafeArea(.all)
            VStack( alignment: .leading, spacing: 30){
                Text("Welcome ⌚️")
                    .font(.largeTitle)
                    .bold()
                
                VStack(spacing:10){
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.lunchViewIconsColor)
                        .frame(width: 44 , height : 44)
                        .background(Color.lunchViewIconsBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
                        .padding(.horizontal)
                      
                    
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.subheadline)
                        .frame(height: 44)
                }
                //make divider between the two textFields
                Divider()
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.lunchViewIconsColor)
                        .frame(width: 44 , height : 44)
                        .background(Color.lunchViewIconsBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
                        .padding(.horizontal)
                    
                    SecureField("Password",text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.subheadline)
                        .frame(height: 44)
                }
                    
                }
                .padding()
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .light))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.backgroundCell.opacity(0.15) , radius: 20, x: 0, y: 20)
                
                Button(action: {self.isNewUser ? viewModel.login(email: viewModel.email, password: viewModel.password)
                    : viewModel.register(email: viewModel.email, password: viewModel.password)
                }){
                    MainButtonView(title: isNewUser ? "Login" : "Register")
                    
                }
                .alert(item: $viewModel.alertItem){ alert in
                    Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                }
                
                
                Button(action:{isNewUser.toggle()}){
                    WelcomeMessage(title: isNewUser ? "CreateAccount?" : "Already has Account", underlinedText:  isNewUser ? "Sign Up" : "Login!")
                    
                }
                
                Spacer()
            }
            .padding()
            .shadow(radius: 3)
            
        }
        if viewModel.isLoading {
            LoadingView(isLoading: $viewModel.isLoading)
        }
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
        }
        .font(.title2)
        .foregroundColor(.primary)
    }
}

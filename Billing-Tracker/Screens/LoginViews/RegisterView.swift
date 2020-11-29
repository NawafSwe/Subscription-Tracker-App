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
        VStack(spacing: 30){
            Text("Welcome")
                .font(.title)
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
            
            
            TextField("Password",text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
            
            
            
            Button(action: {self.isNewUser ? viewModel.login(email: viewModel.email, password: viewModel.password)
                : viewModel.register(email: viewModel.email, password: viewModel.password)
            }){
                Text(isNewUser ? "Login" : "Register" )
            }.alert(item: $viewModel.alertItem){ alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
            
            
            Button(action:{isNewUser.toggle()}){
                Text(isNewUser ? "CreateAccount?" : "Already has account Login!")
            }
        }
        .padding()
        .frame(width: 320, height: 300)
        .background(Color.backgroundCell)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 3)
    }
    
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

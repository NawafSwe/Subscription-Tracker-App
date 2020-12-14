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
            VStack{
                Text("Welcome to Billing Tracker ⌚️")
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                VStack(alignment: .leading ,spacing: 25){
                    
                    VStack (alignment:.leading) {
                        Text("Name:")
                        TextField("Name", text:$viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200, alignment: .center)
                    }
                  
                      
                    VStack (alignment:.leading) {
                        Text("Email:")
                        TextField("email" , text: $viewModel.email)
                            .frame(width: 200, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                
                        
                    VStack (alignment:.leading){
                        Text("Password:")
                        SecureField("password", text: $viewModel.password)
                            .frame(width: 200, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                  
                      
                }
                .padding()
                .frame(width: 330 , height : 330)
                .background(Color.backgroundCell)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous))
                
                Button(action:{
                    viewModel.register(email: viewModel.email, password: viewModel.password , name: viewModel.name)
                }){
                    MainButtonView(title: "Signup")
                        
                }
            }
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: RegisterViewModel())
            .colorScheme(.dark)
    }
}

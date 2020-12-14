//
//  LoginView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 10/12/2020.
//

import SwiftUI

struct LoginView: View {
    @State var email:String = ""
    @State var password: String = ""
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading,spacing:20) {
                Text("Login")
                    .font(.largeTitle)
                    
                Text("Your Email")
                    .font(.title3)
                    .bold()
                TextField("Email", text: $email)
                    .padding()
                
                Text("Password")
                    .font(.title3)
                    .bold()
                SecureField("Password",text:$password)
                    .padding()
                
            }
            .padding()
            .frame(width: 350, height: 400, alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
            
            
            Image("employee-working-in-the-office")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .scaledToFit()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .colorScheme(.dark)
    }
}

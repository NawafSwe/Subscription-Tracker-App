//
//  RegisterView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        VStack(spacing: 30){
            Text("Welcome")
                .font(.title)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
            
            
            TextField("Password",text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white)
            
            
            
            Button(action:{}){
                Text("Register")
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

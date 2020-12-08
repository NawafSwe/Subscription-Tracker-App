//
//  PasswordBoxView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import SwiftUI

struct PasswordBoxView: View {
    @ObservedObject var viewModel : AccountViewModel
    var body: some View {
        
        ZStack {
       
            VStack(alignment: .leading , spacing :20){
                Text("Current Password")
                    .bold()
                SecureField("", text: $viewModel.currentPassword)
                    .frame(width:200, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
                
                Text("New Password")
                    .bold()
                SecureField("New Password", text: $viewModel.reEnteredPassword)
                    .frame(width:200, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Text("Re Enter New Password")
                    .bold()
                SecureField("New Password", text: $viewModel.reEnteredPassword)
                    .frame(width:200, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .frame(width: UIScreen.screenWidth / 2 * 1.65 , height: UIScreen.screenHeight / 2 * 0.9 , alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 10), style: .continuous))
            .shadow(radius: 2)
            .overlay(
                Button(action:{}){
                    StandardButton(title: "Update")}.padding() , alignment: .topTrailing
            )
            .overlay(Button(action:{}){
                DismissButtonView()
            }.padding() , alignment: .topLeading
            )
            
            
            
        }
        
    }
}

struct PasswordBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordBoxView(viewModel: AccountViewModel(email: "", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
            .colorScheme(.light)
        
    }
}

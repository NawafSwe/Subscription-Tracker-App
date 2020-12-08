//
//  EmailBoxView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 08/12/2020.
//

import SwiftUI

struct EmailBoxView: View {
    @ObservedObject var viewModel : AccountViewModel
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading , spacing :20){
                Text("Current Email")
                    .bold()
                TextField("current Email", text: $viewModel.email)
                    .frame(width:220, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
                
                Text("New Email")
                    .bold()
                TextField("New Email", text: $viewModel.reEnteredPassword)
                    .frame(width :220, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                Text("Your Password")
                    .bold()
                SecureField("Your Password", text: $viewModel.currentPassword)
                    .frame(width:220, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .frame(width: UIScreen.screenWidth / 2 * 1.75 , height: UIScreen.screenHeight / 2 * 0.9 , alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 10), style: .continuous))
            .shadow(radius: 2)
            .overlay(
                Button(action:{}){
                    StandardButton(title: "Update")}.padding() , alignment: .topTrailing
            )
            .overlay(Button(action:{self.viewModel.showEmailBox.toggle() }){
                DismissButtonView()
            }.padding() , alignment: .topLeading
            )
        }
        
        
        
    }
    
    
}

struct EmailBoxView_Previews: PreviewProvider {
    static var previews: some View {
        EmailBoxView(viewModel: AccountViewModel(email: "", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
    }
}

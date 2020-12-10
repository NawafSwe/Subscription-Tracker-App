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
            VStack {
                Spacer()
                VStack(alignment: .leading , spacing :20){
                  
                    Text("Current Password")
                        .bold()
                    SecureField("", text: $viewModel.currentPassword)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                    
                    
                    SecureField("New Password", text: $viewModel.reEnteredPassword)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Re Enter New Password", text: $viewModel.verifyReEnteredPassword)
                        .frame(maxWidth:.infinity, alignment: .leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                .padding()
                .frame(maxWidth:.infinity , alignment: .center)
                .frame(height: UIScreen.screenHeight / 2 * 0.9)
                
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
                .overlay(
                    NotchBarView(width: 100, height: 10, cornerRadius: 3).padding(.vertical,-0.5), alignment: .top
            )
            }
            
            
            
        }
        
    }
}

struct PasswordBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordBoxView(viewModel: AccountViewModel(email: "", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
            .colorScheme(.light)
        
    }
}

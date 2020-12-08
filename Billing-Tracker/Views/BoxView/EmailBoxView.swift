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
                
                TextField("New Email", text: $viewModel.newEmail)
                    .frame(width :220, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                
                SecureField("Your Password", text: $viewModel.verifyReEnteredPassword)
                    .frame(width:220, alignment: .leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.screenHeight / 2 * 0.9 , alignment: .center)
            .background(Color.backgroundCell)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 25, height: 10), style: .continuous))
            .shadow(radius: 2)
            .overlay(
                Button(action:viewModel.updateUserEmail ){
                    StandardButton(title: "Update")}
                    .padding()
                    .alert(item: $viewModel.alertItem){alert in
                        Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
                    }
                , alignment: .topTrailing
            )
            .overlay(
                Button(action:{viewModel.showEmailBox.toggle()} ){
                    DismissButtonView()}.padding() , alignment: .topLeading
            )

            .overlay(
                NotchBarView(width: 100, height: 10, cornerRadius: 3).padding(.vertical,-0.5), alignment: .top
            )
        }

    }
}

struct EmailBoxView_Previews: PreviewProvider {
    static var previews: some View {
        EmailBoxView(viewModel: AccountViewModel(email: "", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
    }
}


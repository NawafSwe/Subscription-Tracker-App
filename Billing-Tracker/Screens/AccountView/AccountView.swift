//
//  AccountView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 07/12/2020.
//

import SwiftUI
import Firebase
struct AccountView: View {
    //view model will load all user data from user services
    @ObservedObject var viewModel  : AccountViewModel
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form{
                Section(header:Text("Account information")){
                    TextField("Email", text: $viewModel.email)
                    TextField("Name" , text:$viewModel.displayName)
                    SecureField("Password" , text: .constant("**************************"))
                }
                Section(header:Text("Additional Information")){
                    TextField("Age" , text:$viewModel.age )
                    TextField("gender",text:$viewModel.gender  )
                    TextField("Preferred Provider" , text:$viewModel.preferredProviderName)
                }
            }
            .navigationBarItems(leading: Button(action:{self.presentationMode.wrappedValue.dismiss()}){DismissButtonView()}
                                , trailing: Button(action:{}){
                                    StandardButton(title: "Save")
                                })
            .navigationTitle("Profile")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(viewModel: AccountViewModel(email: "", preferredProviderName: "", preferredProviderImage: "", age: "", gender: "", displayName: ""))
    }
}

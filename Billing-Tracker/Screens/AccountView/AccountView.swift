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
    @State var email = Auth.auth().currentUser?.email ?? "nn123@gmail.com"
    @State var displayName = Auth.auth().currentUser?.displayName ?? "Nawaf"
    @State var age = ""
    @State var gender = ""
    @State var preferredProvider = ""
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form{
                Section(header:Text("Account information")){
                    TextField("Email", text: $email)
                    TextField("Name" , text:$displayName)
                    SecureField("Password" , text: .constant("**************************"))
                }
                Section(header:Text("Additional Information")){
                    TextField("Age" , text:$age )
                    TextField("gender",text:$gender)
                    TextField("Preferred Provider" , text:$preferredProvider)
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
        AccountView()
    }
}

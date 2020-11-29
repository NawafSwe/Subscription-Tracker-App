//
//  BothView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct BothView: View {
    @State var loginPressed = false
    @State var registerPressed = false
    @EnvironmentObject var session:UserAuthenticationManager
    var body: some View {
        Group {
            if self.session.session == nil {
                VStack{
                    Button(action:{self.loginPressed.toggle()}){
                        Text("Login")
                    }
                    .sheet(isPresented: $loginPressed) {
                        LoginView().environmentObject(session)
                    }
                    
                    Button(action:{self.registerPressed.toggle()}){
                        Text("Register")
                    }
                    .sheet(isPresented: $registerPressed) {
                        RegisterView(viewModel:RegisterViewModel(session:  session ))
                    }
                }
            }else{
                HomeTabView().environmentObject(session)
            }
            
        }
    }
}

struct BothView_Previews: PreviewProvider {
    static var previews: some View {
        BothView().environmentObject(UserAuthenticationManager())
    }
}

//
//  LandingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI
import Firebase


struct LandingView: View {
    @ObservedObject var session = UserAuthenticationManager.shared
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            Group{
                if  session.authState == .signOut {
                    RegisterView()
                }else{
                    HomeTabView()
                }
                
            }
            LoadingView(isLoading:$isLoading)
        }
        .onAppear{
            self.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                self.isLoading = false
                session.listen()
                
            }
        }
    }
}
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

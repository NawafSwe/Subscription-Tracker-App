//
//  LandingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI
import Firebase


struct LandingView: View {
    @ObservedObject var shared = UserAuthenticationManager.shared
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        ZStack {
            Group {
                if shared.authState == .signOut {
                    RegisterView(viewModel: viewModel)
                }
                else{
                    HomeTabView()
                        //                    .transition(.move(edge: .leading))
                        .animation(.easeIn, value: true)
                        .animation(nil)
                }
                
               
            }
            LoadingView(isLoading:$viewModel.isLoading)
            /// listing if there is user or not
            .onAppear{
                shared.listen()
                self.viewModel.isLoading = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
                    self.viewModel.isLoading = false
                }
        }
        }
    }
}
struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

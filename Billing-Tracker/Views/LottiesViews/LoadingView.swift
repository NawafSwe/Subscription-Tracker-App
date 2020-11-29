//
//  LoadingView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 29/11/2020.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading:Bool
    var body: some View{
        ZStack{
            if isLoading{
                
                LottieView(fileName: LottieFiles.loading)
                    .frame(width: 300, height: 300, alignment: .center)
                    .background(BlurView(style: .systemMaterial))
                    .cornerRadius(25)
                    .shadow(radius: 5)
                
            }
        }
        
    }
}
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}

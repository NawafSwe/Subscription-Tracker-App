//
//  EmptyProviders.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct EmptyProviders: View {
    let imageName = Images.emptyProviders
    let text = "You Do not have any providers please add some 💳!"
    var body: some View {
        ZStack{
            VStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 350, height: 300, alignment: .center)
                    .offset(y: 10)
                
                Text(text)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.standardText)
                    .font(.body)
                    .padding()
                    .padding(.top,10)
            }
        }
    }
}

struct EmptyProviders_Previews: PreviewProvider {
    static var previews: some View {
        EmptyProviders()
        
        
    }
}

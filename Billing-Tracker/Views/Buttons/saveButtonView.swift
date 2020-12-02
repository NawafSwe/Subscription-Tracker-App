//
//  saveButtonView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import SwiftUI
struct saveButtonView:View{
    var body: some View{
        Image(systemName: Icons.SFCloud )
            .foregroundColor(.iconsFontColor)
            .imageScale(.medium)
            .scaledToFit()
            .frame(width: 30, height: 30)
            .background(
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .accentColor(Color.iconsBackgroundColor)
            )
            
    }
}

struct saveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        saveButtonView()
    }
}

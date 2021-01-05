//
//  AddProviderButton.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 03/12/2020.
//

import SwiftUI

struct AddProviderButton: View {
    var body: some View {
        Image(systemName: Icons.SFFolder)
            .renderingMode(.original)
            .imageScale(.medium)
            .scaledToFit()
            .foregroundColor(.iconsFontColor)
            .frame(width: 30, height: 30)
            .background(
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .accentColor(Color.iconsBackgroundColor)
            )
        
    }
}

struct AddProviderButton_Previews: PreviewProvider {
    static var previews: some View {
        AddProviderButton()
            .colorScheme(.dark)
    }
}

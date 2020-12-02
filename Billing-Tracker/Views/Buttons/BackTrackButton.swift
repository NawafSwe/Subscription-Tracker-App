//
//  BackTrackButton.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 02/12/2020.
//

import SwiftUI

struct BackTrackButton: View {
    var body: some View {
        Image(systemName: Icons.SFChevron)
            .imageScale(.small)
            .scaledToFit()
            .foregroundColor(.iconsFontColor)
            .frame(width: 20, height: 20)
            .background(
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .accentColor(Color.iconsBackgroundColor)
            )
            .background(BlurView(style: .systemMaterial))
        
    }
}

struct BackTrackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackTrackButton()
    }
}

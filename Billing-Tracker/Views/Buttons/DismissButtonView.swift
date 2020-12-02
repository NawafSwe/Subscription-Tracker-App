//
//  DismissButtonView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 28/11/2020.
//

import SwiftUI

struct DismissButtonView: View {
    var body: some View{
        Image(systemName: Icons.SFXmark)
            .foregroundColor(.iconsFontColor)
            .imageScale(.small)
            .scaledToFit()
            .frame(width: 20, height: 20)
            .background(
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .accentColor(Color.iconsBackgroundColor)
            )
            .background(BlurView(style: .systemMaterial))
    }
}


struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
            .colorScheme(.light)
    }
}

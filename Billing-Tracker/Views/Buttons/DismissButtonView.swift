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
            .resizable()
            .frame(width:30 , height: 30)
            .scaledToFit()
            .accentColor(.black)
    }
}


struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}

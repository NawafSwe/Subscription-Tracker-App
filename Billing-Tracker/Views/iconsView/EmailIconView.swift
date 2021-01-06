//
//  EmailIconView.swift
//  Billing-Tracker
//
//  Created by Nawaf B Al sharqi on 06/01/2021.
//

import SwiftUI

struct EmailIconView: View {
    let width:CGFloat
    let height:CGFloat
    var body: some View {
        Image(systemName: "envelope.fill")
            .foregroundColor(.lunchViewIconsColor)
            .frame(width: width , height : height)
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.15), radius: 20, x: 0, y: 10)
    }
}

struct EmailIconView_Previews: PreviewProvider {
    static var previews: some View {
        EmailIconView(width: 44, height: 44)
    }
}
